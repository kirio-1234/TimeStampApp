//
//  AddTimeStampViewModel.swift
//  TimeStamp Watch App
//
//  Created by Iori Suzuki on 2024/04/05.
//

import Foundation
import WatchConnectivity

final class AddTimeStampViewModel: NSObject, ObservableObject {
    
    override init() {
        super.init()
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

extension AddTimeStampViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
