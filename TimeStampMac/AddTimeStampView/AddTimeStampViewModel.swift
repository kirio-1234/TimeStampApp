//
//  AddTimeStampViewModel.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/04/12.
//

import Foundation

final class AddTimeStampViewModel: ObservableObject {
    private let repository: UserDefaultTimeStampRepository
    
    init(repository: UserDefaultTimeStampRepository) {
        self.repository = repository
    }
    
    enum Action {
        case edit(timeStamp: TimeStamp)
        case deleteAll
    }
    
    func runAction(_ action: Action) {
        switch action {
        case .edit(let timeStamp):
            edit(timeStamp: timeStamp)
        case .deleteAll:
            deleteAll()
        }
    }
    
    private func edit(timeStamp: TimeStamp) {
        repository.edit(timeStamp: timeStamp)
    }
    
    private func deleteAll() {
        repository.deleteAll()
    }
}
