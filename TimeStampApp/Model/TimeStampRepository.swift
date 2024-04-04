//
//  TimeStampRepository.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/05.
//

import Foundation

public protocol TimeStampRepository {
    func fetchAll() -> [TimeStamp]
    func edit(timeStamp: TimeStamp)
    func delete(id: TimeStamp.ID)
    func delete(offsets: IndexSet)
    func deleteAll()
}

public extension UserDefaults {
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

public struct UserDefaultTimeStampRepository: TimeStampRepository {
    public let userDefault = UserDefaults.standard
    
    public init() { }
    
    public func fetchAll() -> [TimeStamp] {
        userDefault.timeStamps ?? []
    }
    
    public func edit(timeStamp: TimeStamp) {
        if let index = userDefault.timeStamps?.firstIndex(where: { $0.id == timeStamp.id }) {
            userDefault.timeStamps?[index] = timeStamp
        } else {
            userDefault.timeStamps?.append(timeStamp)
        }
    }
    
    public func delete(id: TimeStamp.ID) {
        if let timeStamps = userDefault.timeStamps {
            if let index = timeStamps.firstIndex(where: { $0.id == id }) {
                userDefault.timeStamps?.remove(at: index)
            }
        }
    }
    
    public func delete(offsets: IndexSet) {
        userDefault.timeStamps?.remove(atOffsets: offsets)
    }
    
    public func deleteAll() {
        userDefault.timeStamps?.removeAll()
    }
}

public struct TimeStampCorder {
    public func decode(data: Data?) -> [TimeStamp]? {
        let jsonDecoder = JSONDecoder()
        guard let data else { return nil }
        return try? jsonDecoder.decode([TimeStamp].self, from: data)
    }
    
    public func encode(timeStamps: [TimeStamp]) -> Data? {
        return try? JSONEncoder().encode(timeStamps)
    }
}
