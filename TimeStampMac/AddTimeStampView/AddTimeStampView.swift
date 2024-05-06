//
//  AddTimeStampView.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/04/12.
//

import SwiftUI

struct AddTimeStampView: View {
    @EnvironmentObject var viewModel: AddTimeStampViewModel
    
    var body: some View {
        AddTimeStampButton {
            viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
        }
    }
}

#Preview {
    AddTimeStampView()
        .environmentObject(AddTimeStampViewModel(repository: UserDefaultTimeStampRepository(userDefault: .standard)))
}
