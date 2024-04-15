//
//  AddTimeStampViewModel.swift
//  TimeStamp Watch App
//
//  Created by Iori Suzuki on 2024/04/05.
//

import Foundation

final class AddTimeStampViewModel: ObservableObject {
    
    init() {
    }
    
    enum Action {
        case edit(timeStamp: TimeStamp)
    }
    
    func runAction(_ action: Action) {
        switch action {
        case .edit(let timeStamp):
            edit(timeStamp: timeStamp)
        }
    }
    
    private func edit(timeStamp: TimeStamp) {
    }
}
