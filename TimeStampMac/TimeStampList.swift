//
//  TimeStampList.swift
//  TimeStampMac
//
//  Created by Iori Suzuki on 2024/02/01.
//

import SwiftUI
import SFUserFriendlySymbols

struct TimeStampList: View {
    @EnvironmentObject var viewModel: TimeStampListViewModel
    
    @State private var showTimeStampDuration = false
    
    private var timeStampDuration: String {
        guard let duration = viewModel.duration?.description else { return "" }
        return duration + "min"
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 32) {
                AddTimeStampButton {
                    viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
                }
                calculateTimeStampDurationButton
                TrashTimeStampButton {
                    viewModel.runAction(.deleteAll)
                }
            }
            .padding()
            list
                .alert(timeStampDuration, isPresented: $showTimeStampDuration) {
                    Button {
                        showTimeStampDuration = false
                    } label: {
                        Text("OK")
                    }
                }
        }
    }
    
    var calculateTimeStampDurationButton: some View {
        Button {
            viewModel.runAction(.calculateTimeStampDuration)
            showTimeStampDuration = true
        } label: {
            Image(symbol: .clock)
        }
        .buttonStyle(.bordered)
    }
    
    var list: some View {
        List {
            ForEach(viewModel.timeStamps) { timeStamp in
                cell(timeStamp: timeStamp)
                    .onTapGesture {
                        viewModel.runAction(.selectTimeStamp(timeStamp: timeStamp))
                    }
            }
        }
    }
    
    func cell(timeStamp: TimeStamp) -> some View {
        HStack {
            Text(timeStamp.date.yyyyMMDDEEEHHmm)
            
            Spacer()
            
            if timeStamp.isSelected {
                Image(symbol: .checkmark)
            }
        }
    }
}
