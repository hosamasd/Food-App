//
//  OtpFormFieldView.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI

enum FocusStateEnum: Int, Hashable {
    case pinOne = 0, pinTwo, pinThree, pinFour//, pinFive, pinSex
}
struct OtpFormFieldView: View {
    @FocusState private var pinFocusState : FocusStateEnum?

    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    
    @Binding var total : String
    var isHodeen = false
    
    var type:UIKeyboardType = .numberPad
    
    // Dynamically bind to the respective `@State` property
    private func binding(for index: Int) -> Binding<String> {
        switch index {
        case 0: return $pinOne
        case 1: return $pinTwo
        case 2: return $pinThree
        case 3: return $pinFour
        default: fatalError("Index out of range")
        }
    }

    // Handle input changes
    
    private func handleInputChange(for index: Int, value: String) {
        let maxCount = 1
        if value.count == maxCount {
            if index < 3 { // Move to the next input field
                pinFocusState = FocusStateEnum(rawValue: index + 1)
            }
        } else if value.isEmpty {
            if index > 0 { // Move to the previous input field
                pinFocusState = FocusStateEnum(rawValue: index - 1)
            }
        }
        // Update the total after each change
        total = pinOne + pinTwo + pinThree + pinFour
    }


    
    var body: some View {
        HStack(spacing: 12) {
            ForEach((0..<4), id: \.self) { index in
                TextField("", text: binding(for: index))
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundStyle(Color.primaryText)
                    .keyboardType(type)
                    .modifier(OtpModifer(pin: binding(for: index)))
                    .onChange(of: binding(for: index).wrappedValue) { newVal in
                        handleInputChange(for: index, value: newVal)
                    }
                    .focused($pinFocusState, equals: FocusStateEnum(rawValue: index))
            }
        }
        .padding(.vertical)
    }
}
