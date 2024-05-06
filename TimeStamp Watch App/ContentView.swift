//
//  ContentView.swift
//  TimeStamp Watch App
//
//  Created by Iori Suzuki on 2024/04/05.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AddTimeStampViewModel
    
    var body: some View {
        AddTimeStampView()
            .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
        .environmentObject(AddTimeStampViewModel())
}
