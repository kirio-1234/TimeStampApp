//
//  TimeStampListViewModel.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/02/01.
//

import Foundation
import SwiftUI
import TimeStampCore

@MainActor
final class TimeStampListViewModel: ObservableObject {
    @Published var timeStamps: [TimeStamp] = []
    let repository: UserDefaultTimeStampRepository
    
    init(repository: UserDefaultTimeStampRepository) {
        self.repository = repository
        fetchTimeStamps()
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
    
    func fetchTimeStamps() {
        timeStamps = repository.fetchAll()
    }
    
    func edit(timeStamp: TimeStamp) {
        repository.edit(timeStamp: timeStamp)
        fetchTimeStamps()
    }
    
    func deleteAll() {
        repository.deleteAll()
        fetchTimeStamps()
    }
}
