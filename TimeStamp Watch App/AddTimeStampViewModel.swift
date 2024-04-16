//
//  AddTimeStampViewModel.swift
//  TimeStamp Watch App
//
//  Created by Iori Suzuki on 2024/04/05.
//

import Foundation
import WatchConnectivity

final class AddTimeStampViewModel: NSObject, ObservableObject {
    
    private let session = WCSession.default
    
    override init() {
        super.init()
        
        setupSession()
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
    
    private func setupSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    private func edit(timeStamp: TimeStamp) {
        guard let jsonData = TimeStampCorder().encode(timeStamps: [timeStamp]) else { return }
        session.sendMessageData(jsonData, replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
}

extension AddTimeStampViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
