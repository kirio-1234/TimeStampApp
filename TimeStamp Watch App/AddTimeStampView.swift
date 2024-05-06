//
//  AddTimeStampView.swift
//  TimeStamp Watch App
//
//  Created by Iori Suzuki on 2024/04/05.
//

import SwiftUI

struct AddTimeStampView: View {
    @EnvironmentObject var viewModel: AddTimeStampViewModel
    
    var body: some View {
        AddTimeStampButton {
            viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddTimeStampView()
        .environmentObject(AddTimeStampViewModel())
}
