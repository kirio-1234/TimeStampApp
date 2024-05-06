//
//  EditTimeStampButton.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/05/06.
//

import SwiftUI

struct EditTimeStampButton: View {
    @Binding var editMode: EditMode
    
    var body: some View {
        Button {
            editMode = editMode.isEditing ? .inactive : .active
        } label: {
            Text(editMode.isEditing ? "Done" : "Edit")
                .bold()
        }
    }
}

#Preview {
    EditTimeStampButton(editMode: .constant(.inactive))
}
