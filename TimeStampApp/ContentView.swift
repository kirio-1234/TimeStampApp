//
//  ContentView.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/05.
//

import SwiftUI
import TimeStampCore

struct ContentView: View {
    var body: some View {
        TimeStampList(viewModel: TimeStampListViewModel(repository: UserDefaultTimeStampRepository()))
    }
}

#Preview {
    ContentView()
}
