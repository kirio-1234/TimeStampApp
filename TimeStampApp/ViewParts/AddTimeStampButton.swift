//
//  AddTimeStampButton.swift
//  TimeStampApp
//
//  Created by Iori Suzuki on 2024/04/05.
//

import SwiftUI
import SFUserFriendlySymbols

struct AddTimeStampButton: View {
    var action: () -> Void
    var body: some View {
        #if os(macOS)
        Button {
            action()
        } label: {
            Image(symbol: .plus)
        }
        .buttonStyle(.bordered)
        #else
        Button {
            action()
        } label: {
            Image(symbol: .plus)
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundStyle(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
        }
        #endif
    }
}

#Preview {
    AddTimeStampButton {
        
    }
}
