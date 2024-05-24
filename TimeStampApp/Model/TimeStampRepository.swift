//
//  TimeStampRepository.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/05.
//

import Foundation
import Combine

protocol TimeStampRepository {
    var timeStamps: CurrentValueSubject<[TimeStamp]?, Never> { get }
    func edit(timeStamp: TimeStamp)
    func delete(id: TimeStamp.ID)
    func delete(offsets: IndexSet)
    func deleteAll()
}
