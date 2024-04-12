//
//  UserDefaultTimeStampRepository.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/12.
//

import Foundation
import Combine

struct UserDefaultTimeStampRepository: TimeStampRepository {
    
    var timeStamps: CurrentValueSubject<[TimeStamp]?, Never> = .init([])
    
    private let userDefault: UserDefaults
    private var cancellables: Set<AnyCancellable> = .init()
    
    private static let key = "timeStamp"
    
    init(userDefault: UserDefaults) { 
        self.userDefault = userDefault
        
        let data = userDefault.data(forKey: Self.key)
        self.timeStamps = .init(TimeStampCorder().decode(data: data) ?? [])
        
        self.timeStamps
            .sink { timeStamps in
                let data = TimeStampCorder().encode(timeStamps: timeStamps ?? [])
                userDefault.set(data, forKey: Self.key)
            }
            .store(in: &cancellables)
    }
    
    func edit(timeStamp: TimeStamp) {
        guard var timeStamps = self.timeStamps.value else { return }
        if let index = timeStamps.firstIndex(where: { $0.id == timeStamp.id }) {
            timeStamps[index] = timeStamp
        } else {
            timeStamps.append(timeStamp)
        }
        self.timeStamps.send(timeStamps)
    }
    
    func delete(id: TimeStamp.ID) {
        guard var timeStamps = self.timeStamps.value else { return }
        if let index = timeStamps.firstIndex(where: { $0.id == id }) {
            timeStamps.remove(at: index)
        }
        self.timeStamps.send(timeStamps)
    }
    
    func delete(offsets: IndexSet) {
        guard var timeStamps = self.timeStamps.value else { return }
        timeStamps.remove(atOffsets: offsets)
        self.timeStamps.send(timeStamps)
    }
    
    func deleteAll() {
        timeStamps.send([])
    }
}
