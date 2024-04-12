//
//  AddTimeStampViewModel.swift
//  TimeStamp Watch App
//
//  Created by Iori Suzuki on 2024/04/05.
//

import Foundation

final class AddTimeStampViewModel: ObservableObject {
    private let repository: UserDefaultTimeStampRepository
    
    init(repository: UserDefaultTimeStampRepository) {
        self.repository = repository
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
        repository.edit(timeStamp: timeStamp)
    }
}
