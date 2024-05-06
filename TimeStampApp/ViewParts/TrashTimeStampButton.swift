//
//  TrashTimeStampButton.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/05/06.
//

import SwiftUI

struct TrashTimeStampButton: View {
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(symbol: .trash)
        }
    }
}

#Preview {
    TrashTimeStampButton {
        
    }
}
