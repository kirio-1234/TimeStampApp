//
//  AddTimeStampView.swift
//  TimeStamp Watch App
//
//  Created by Iori Suzuki on 2024/04/05.
//

import SwiftUI

struct AddTimeStampView: View {
    @ObservedObject var viewModel: AddTimeStampViewModel
    var body: some View {
        AddTimeStampButton {
            viewModel.runAction(.edit(timeStamp: TimeStamp(id: UUID(), date: Date())))
        }
    }
}

#Preview {
    AddTimeStampView(viewModel: AddTimeStampViewModel(repository: UserDefaultTimeStampRepository()))
}
