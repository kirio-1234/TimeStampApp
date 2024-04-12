//
//  TimeStampList.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/02/01.
//

import SwiftUI
import SFUserFriendlySymbols

struct TimeStampList: View {
    @ObservedObject var viewModel: TimeStampListViewModel

    var body: some View {
        VStack {
            HStack(spacing: 32) {
                addTimeStampButton
                deleteAllButton
            }
            .padding()
            list
        }
    }
    
    var addTimeStampButton: some View {
        Button {
            viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
        } label: {
            Image(symbol: .plus)
        }
        .buttonStyle(.bordered)
    }
    
    var deleteAllButton: some View {
        Button {
            viewModel.runAction(.deleteAll)
        } label: {
            Image(symbol: .trash)
        }
        .buttonStyle(.bordered)
    }
    
    var list: some View {
        List {
            ForEach(viewModel.timeStamps) { timeStamp in
                Text(timeStamp.date.yyyyMMDDEEEHHmm)
            }
        }
    }
}
