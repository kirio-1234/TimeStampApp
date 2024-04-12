//
//  TimeStampCorder.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/12.
//

import Foundation

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
