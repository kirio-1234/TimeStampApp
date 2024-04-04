//
//  TimeStamp.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/05.
//

import Foundation

public struct TimeStamp: Identifiable, Codable {
    public let id: UUID
    public let date: Date
    public var type: DateType? = nil
    
    public init(id: UUID, date: Date, type: DateType? = nil) {
        self.id = id
        self.date = date
        self.type = type
    }
    
    public enum DateType: String, CaseIterable, Codable {
        case none = "指定なし"
        case start = "開始"
        case end = "終了"
    }
}
