//
//  InMemoryTimeStampRepository.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/12.
//

import Foundation
import Combine

struct InMemoryTimeStampRepository: TimeStampRepository {
    var timeStamps: CurrentValueSubject<[TimeStamp]?, Never> = .init([])
    
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
