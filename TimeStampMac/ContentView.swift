//
//  ContentView.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/02/01.
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
        .environmentObject(TimeStampListViewModel(repository: UserDefaultTimeStampRepository(userDefault: .standard)))
}
