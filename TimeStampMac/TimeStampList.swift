//
//  TimeStampList.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/02/01.
//

import SwiftUI
import SFUserFriendlySymbols
import TimeStampCore

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
            viewModel.runAction(.edit(timeStamp: newTimeStamp))
        } label: {
            Image(symbol: .plus)
        }
        .buttonStyle(.bordered)
    }
    
    var deleteAllButton: some View {
        Button {
            viewModel.deleteAll()
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

private extension TimeStampList {
    var newTimeStamp: TimeStamp {
        .init(id: UUID(), date: Date(), type: nil)
    }
}
