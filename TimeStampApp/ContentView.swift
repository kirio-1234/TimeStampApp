//
//  ContentView.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TimeStampListViewModel
    
    init(viewModel: TimeStampListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TimeStampList(viewModel: viewModel)
    }
}

#Preview {
    ContentView(viewModel: TimeStampListViewModel(repository: .init(userDefault: .standard)))
}
