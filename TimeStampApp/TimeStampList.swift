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
                            editButton
                        }
                    }
                    .confirmationDialog("すべて削除しますか？", isPresented: $isDeletedAll) {
                       deleteAllButton
                    }
            }
        }
        .listStyle(.insetGrouped)
        .overlay(alignment: .bottomTrailing) {
            addTimeStampButton
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
    
    var editButton: some View {
        Button {
            editMode = editMode.isEditing ? .inactive : .active
        } label: {
            Text(editMode.isEditing ? "Done" : "Edit")
                .bold()
        }
    }
    
    var deleteAllButton: some View {
        Button(role: .destructive) {
            viewModel.runAction(.deleteAll)
        } label: {
            Text("すべて削除")
        }
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
    
    var addTimeStampButton: some View {
        Button {
            viewModel.runAction(.edit(timeStamp: .currentTimeStamp))
        } label: {
            Image(symbol: .plus)
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundStyle(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
        }
        .padding()
    }
}
