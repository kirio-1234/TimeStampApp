//
//  ContentView.swift
//  TimeStamp Watch App
//
//  Created by Iori Suzuki on 2024/04/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: AddTimeStampViewModel
    
    init(viewModel: AddTimeStampViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        AddTimeStampView(viewModel: viewModel)
    }
}

#Preview {
    ContentView(viewModel: AddTimeStampViewModel())
}
