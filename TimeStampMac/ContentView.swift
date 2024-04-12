//
//  ContentView.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/02/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TimeStampList(viewModel: TimeStampListViewModel(repository: UserDefaultTimeStampRepository(userDefault: .standard)))
    }
}

#Preview {
    ContentView()
}
