//
//  TimeStampListViewModel.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/02/01.
//

import Foundation
import Combine

@MainActor
final class TimeStampListViewModel: ObservableObject {
    @Published var timeStamps: [TimeStamp] = []
    @Published var duration: Int? = nil
    private let repository: TimeStampRepository
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(repository: TimeStampRepository) {
        self.repository = repository
        
        self.repository.timeStamps
            .sink { timeStamps in
                self.timeStamps = timeStamps ?? []
            }
            .store(in: &cancellables)
    }
    
    enum Action {
        case edit(timeStamp: TimeStamp)
        case calculateTimeStampDuration
        case selectTimeStamp(timeStamp: TimeStamp)
        case deleteAll
    }
    
    func runAction(_ action: Action) {
        switch action {
        case .edit(let timeStamp):
            edit(timeStamp: timeStamp)
        case .calculateTimeStampDuration:
            self.duration = calculateTimeStampDuration()
        case .selectTimeStamp(let timeStamp):
            selectTimeStamp(timeStamp: timeStamp)
        case .deleteAll:
            deleteAll()
        }
    }
    
    private func edit(timeStamp: TimeStamp) {
        repository.edit(timeStamp: timeStamp)
    }
    
    private func calculateTimeStampDuration() -> Int? {
        let selectedTimeStampDates = timeStamps
            .filter(\.isSelected)
            .map(\.date)
        guard let minDate = selectedTimeStampDates.min(), let maxDate = selectedTimeStampDates.max() else { return nil }
        return Int(maxDate.timeIntervalSince(minDate)) / 60
    }
    
    private func selectTimeStamp(timeStamp: TimeStamp) {
        var timeStamp = timeStamp
        timeStamp.isSelected.toggle()
        edit(timeStamp: timeStamp)
    }
    
    private func deleteAll() {
        repository.deleteAll()
    }
}
