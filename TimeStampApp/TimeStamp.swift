//
//  TimeStamp.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/05.
//

import Foundation
import SwiftUI

struct TimeStamp: Identifiable, Codable {
    let id: UUID
    let date: Date
    var type: DateType? = nil
    
    enum DateType: String, CaseIterable, Codable {
        case none = "指定なし"
        case start = "開始"
        case end = "終了"
    }
}
