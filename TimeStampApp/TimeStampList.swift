//
//  TimeStampList.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/01/05.
//

import SwiftUI
import SFUserFriendlySymbols

struct TimeStampList: View {
    @EnvironmentObject var viewModel: TimeStampListViewModel
    @State private var isDeletedAll: Bool = false
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        VStack {
            NavigationStack {
                list
                    .navigationTitle("Time Stamp List")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            TrashTimeStampButton {
                                isDeletedAll.toggle()
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            EditTimeStampButton(editMode: self.$editMode)
                        }
                    }
                    .confirmationDialog("すべて削除しますか？", isPresented: $isDeletedAll) {
                        DeleteTimeStampButton {
                            viewModel.runAction(.deleteAll)
                        }
                    }
            }
        }
        .listStyle(.insetGrouped)
        .overlay(alignment: .bottomTrailing) {
            AddTimeStampButton {
                viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
            }
            .padding()
        }
        .onOpenURL { url in
            if url == URL(string: "com-time-stamp-app://") {
                viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
            }
        }
    }
    
    var list: some View {
        List {
            ForEach(viewModel.timeStamps) { timeStamp in
                cell(timeStamp: timeStamp)
                    .swipeActions {
                        swipeDeleteButton(id: timeStamp.id)
                    }
            }
            .onDelete { indexSet in
                viewModel.runAction(.deleteBy(offsets: indexSet))
            }
        }
        .environment(\.editMode, self.$editMode)
    }
    
    func cell(timeStamp: TimeStamp) -> some View {
        Picker(timeStamp.date.yyyyMMDDEEEHHmm, selection: viewModel.bindingDateType(timeStamp: timeStamp)) {
            ForEach(TimeStamp.DateType.allCases, id: \.self) { type in
                Text(type.rawValue)
                    .monospacedDigit()
                    .tag(type)
            }
        }
        .pickerStyle(.menu)
    }
    
    func swipeDeleteButton(id: TimeStamp.ID) -> some View {
        Button(role: .destructive) {
            viewModel.runAction(.delete(id: id))
        } label: {
            Text("削除")
        }
    }
}
