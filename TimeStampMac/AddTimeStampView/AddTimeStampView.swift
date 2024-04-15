//
//  AddTimeStampView.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/04/12.
//

import SwiftUI

struct AddTimeStampView: View {
    @ObservedObject var viewModel: AddTimeStampViewModel
    
    init(viewModel: AddTimeStampViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        AddTimeStampButton {
            viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
        }
    }
}

#Preview {
    AddTimeStampView(viewModel: AddTimeStampViewModel(repository: UserDefaultTimeStampRepository(userDefault: .standard)))
}
