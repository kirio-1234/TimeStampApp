//
//  TimeStampApp.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/05.
//

import SwiftUI

@main
struct TimeStampApp: App {
    private let repository = UserDefaultTimeStampRepository(userDefault: .standard)
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: TimeStampListViewModel(repository: repository))
        }
        
        MenuBarExtra {
            AddTimeStampView(viewModel: AddTimeStampViewModel(repository: repository))
        } label: {
            Image(symbol: .timer)
        }
    }
}
