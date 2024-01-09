//
//  Date+Extension.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/07.
//

import Foundation

extension Date {
    var yyyyMMDDEEEHHmm: String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .gregorian)
        dateFormatter.locale = .init(identifier: "ja_JP")
        dateFormatter.dateFormat = "yy/MM/DD (EEE) HH:mm"
        return dateFormatter.string(from: self)
    }
}
