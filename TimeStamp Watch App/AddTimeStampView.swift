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
            viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
        }
    }
}

#Preview {
    AddTimeStampView(viewModel: AddTimeStampViewModel(repository: UserDefaultTimeStampRepository(userDefault: .standard)))
}
