//
//  TimeStampApp_TimeStampListViewModelTests.swift
//  TimeStampAppTests
//
//  Created by Iori Suzuki on 2024/05/24.
//

import XCTest

final class TimeStampApp_TimeStampListViewModelTests: XCTestCase {
    func test_editTimeStamp() {
        let timeStamps: [TimeStamp] = [
            .currentTimeStamp,
            .currentTimeStamp
        ]
        let repository = InMemoryTimeStampRepository(timeStamps: .init(timeStamps))
        let viewModel = TimeStampListViewModel(repository: repository)
        
        let timeStamp: TimeStamp = .currentTimeStamp
        viewModel.runAction(.edit(timeStamp: timeStamp))
        XCTAssertEqual(viewModel.timeStamps[2].id, timeStamp.id)
    }
    
    func test_deleteTimeStamp() {
        let timeStamp: TimeStamp = .currentTimeStamp
        let timeStamps: [TimeStamp] = [
            timeStamp
        ]
        
        let repository = InMemoryTimeStampRepository(timeStamps: .init(timeStamps))
        let viewModel = TimeStampListViewModel(repository: repository)
        
        viewModel.runAction(.delete(id: timeStamp.id))
        XCTAssertFalse(viewModel.timeStamps.contains { $0.id == timeStamp.id })
    }
    
    func test_deleteAllTimeStamp() {
        let timeStamps: [TimeStamp] = [
            .currentTimeStamp
        ]
        let repository = InMemoryTimeStampRepository(timeStamps: .init(timeStamps))
        let viewModel = TimeStampListViewModel(repository: repository)
        viewModel.runAction(.deleteAll)
    }
}
