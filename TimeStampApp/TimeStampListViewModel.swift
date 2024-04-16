//
//  TimeStampListViewModel.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/05.
//

import Foundation
import SwiftUI
import Combine
import WatchConnectivity

@MainActor
final class TimeStampListViewModel: NSObject, ObservableObject {
    @Published var timeStamps: [TimeStamp] = []
    private let repository: UserDefaultTimeStampRepository
    private let session = WCSession.default
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(repository: UserDefaultTimeStampRepository) {
        self.repository = repository
        
        super.init()
        
        setupSession()
        
        self.repository.timeStamps
            .sink { timeStamps in
                self.timeStamps = timeStamps ?? []
            }
            .store(in: &cancellables)
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
    
    private func edit(timeStamp: TimeStamp) {
        repository.edit(timeStamp: timeStamp)
    }
    
    private func delete(offsets: IndexSet) {
        repository.delete(offsets: offsets)
    }
    
    private func delete(id: TimeStamp.ID) {
        repository.delete(id: id)
    }
    
    private func deleteAll() {
        repository.deleteAll()
    }
    
    private func setupSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
}

extension TimeStampListViewModel {
    func bindingDateType(timeStamp: TimeStamp) -> Binding<TimeStamp.DateType> {
        .init(
            get: {
                return timeStamp.type ?? .none
            },
            set: { [weak self] newValue in
                guard var timeStamps = self?.repository.timeStamps.value else { return }
                if let index = timeStamps.firstIndex(where: { $0.id == timeStamp.id} ) {
                    self?.timeStamps[index].type = newValue
                    if let newTimeStamp = self?.timeStamps[index] {
                        self?.repository.edit(timeStamp: newTimeStamp)
                    }
                }
            }
        )
    }
}

extension TimeStampListViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        if let timeStamps = TimeStampCorder().decode(data: messageData), let timeStamp = timeStamps.first {
            self.edit(timeStamp: timeStamp)
        }
    }
}
