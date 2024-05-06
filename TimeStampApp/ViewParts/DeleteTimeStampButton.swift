//
//  DeleteTimeStampButton.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/05/06.
//

import SwiftUI

struct DeleteTimeStampButton: View {
    var action: () -> Void
    var body: some View {
        Button(role: .destructive) {
            action()
        } label: {
            Text("すべて削除")
        }
    }
}

#Preview {
    DeleteTimeStampButton {
        
    }
}
