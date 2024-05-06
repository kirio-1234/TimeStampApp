//
//  TimeStamp.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/05.
//

import Foundation

 struct TimeStamp: Identifiable, Codable {
    let id: UUID
    let date: Date
    var type: DateType? = nil
    var isSelected = false
    
    init(id: UUID, date: Date, type: DateType? = nil) {
        self.id = id
        self.date = date
        self.type = type
    }
    
    enum DateType: String, CaseIterable, Codable {
        case none = "指定なし"
        case start = "開始"
        case end = "終了"
    }
}

extension TimeStamp {
    static var currentTimeStamp: Self {
        .init(id: UUID(), date: Date())
    }
}
