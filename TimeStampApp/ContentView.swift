//
//  ContentView.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/05.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: TimeStampListViewModel
    
    
    var body: some View {
        TimeStampList()
            .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
        .environmentObject(TimeStampListViewModel(repository: .init(userDefault: .standard)))
}
