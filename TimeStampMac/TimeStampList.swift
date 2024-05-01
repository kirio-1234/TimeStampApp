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
    
    @State private var showTimeStampDuration = false
    
    private var timeStampDuration: String {
        guard let duration = viewModel.duration?.description else { return "" }
        return duration + "min"
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 32) {
                addTimeStampButton
                calculateTimeStampDurationButton
                deleteAllButton
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
    
    var addTimeStampButton: some View {
        Button {
            viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
        } label: {
            Image(symbol: .plus)
        }
        .buttonStyle(.bordered)
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
                cell(timeStamp: timeStamp)
            }
        }
    }
    
    func cell(timeStamp: TimeStamp) -> some View {
        HStack {
            Button {
                viewModel.runAction(.selectTimeStamp(timeStamp: timeStamp))
            } label: {
                Text(timeStamp.date.yyyyMMDDEEEHHmm)
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            if timeStamp.isSelected {
                Image(symbol: .checkmark)
            }
        }
    }
}
