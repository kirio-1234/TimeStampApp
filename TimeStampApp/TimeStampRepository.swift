//
//  TimeStampRepository.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/06.
//

import Foundation

protocol TimeStampRepository {
    func fetchAll() -> [TimeStamp]
    func edit(timeStamp: TimeStamp)
    func delete(id: TimeStamp.ID)
    func delete(offsets: IndexSet)
    func deleteAll()
}

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
    let userDefault = UserDefaults.standard
    
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

struct TimeStampCorder {
    func decode(data: Data?) -> [TimeStamp]? {
        let jsonDecoder = JSONDecoder()
        guard let data else { return nil }
        return try? jsonDecoder.decode([TimeStamp].self, from: data)
    }
    
    func encode(timeStamps: [TimeStamp]) -> Data? {
        return try? JSONEncoder().encode(timeStamps)
    }
}
