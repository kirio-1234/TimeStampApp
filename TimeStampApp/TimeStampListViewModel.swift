//
//  TimeStampListViewModel.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/05.
//

import Foundation
import SwiftUI

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
        case delete(id: TimeStamp.ID)
        case deleteBy(offsets: IndexSet)
        case deleteAll
    }
    
    func runAction(_ action: Action) {
        switch action {
        case .edit(let timeStamp):
            edit(timeStamp: timeStamp)
        case .delete(let id):
            delete(id: id)
        case .deleteBy(let offsets):
            delete(offsets: offsets)
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
    
    func delete(offsets: IndexSet) {
        repository.delete(offsets: offsets)
        fetchTimeStamps()
    }
    
    func delete(id: TimeStamp.ID) {
        repository.delete(id: id)
        fetchTimeStamps()
    }
    
    func deleteAll() {
        repository.deleteAll()
        fetchTimeStamps()
    }
}

extension TimeStampListViewModel {
    func bindingDateType(timeStamp: TimeStamp) -> Binding<TimeStamp.DateType> {
        .init(
            get: {
                return timeStamp.type ?? .none
            },
            set: { [weak self] newValue in
                let timeStamps = self?.repository.fetchAll()
                if let index = timeStamps?.firstIndex(where: { $0.id == timeStamp.id} ) {
                    self?.timeStamps[index].type = newValue
                    if let newTimeStamp = self?.timeStamps[index] {
                        self?.repository.edit(timeStamp: newTimeStamp)
                    }
                }
            }
        )
    }
}
