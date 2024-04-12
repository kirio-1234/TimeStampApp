//
//  UserDefaultTimeStampRepository.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/12.
//

import Foundation

extension UserDefaults {
    var corder: TimeStampCorder {
        TimeStampCorder()
    }

    var key: String {
        "timeStamp"
    }
    
    var timeStamps: [TimeStamp]? {
        get {
            let data = data(forKey: key)
            return corder.decode(data: data)
        }
        set {
            let data = corder.encode(timeStamps: newValue ?? .init())
            self.set(data, forKey: key)
        }
    }
}

struct UserDefaultTimeStampRepository: TimeStampRepository {
    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults) { 
        self.userDefault = userDefault
    }
    
    func fetchAll() -> [TimeStamp] {
        userDefault.timeStamps ?? []
    }
    
    func edit(timeStamp: TimeStamp) {
        if let index = userDefault.timeStamps?.firstIndex(where: { $0.id == timeStamp.id }) {
            userDefault.timeStamps?[index] = timeStamp
        } else {
            userDefault.timeStamps?.append(timeStamp)
        }
    }
    
    func delete(id: TimeStamp.ID) {
        if let timeStamps = userDefault.timeStamps {
            if let index = timeStamps.firstIndex(where: { $0.id == id }) {
                userDefault.timeStamps?.remove(at: index)
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        userDefault.timeStamps?.remove(atOffsets: offsets)
    }
    
    func deleteAll() {
        userDefault.timeStamps?.removeAll()
    }
}
