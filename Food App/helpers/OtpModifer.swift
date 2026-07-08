//
//  OtpModifer.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI
import Combine


struct OtpModifer: ViewModifier {

    @Binding var pin : String

    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }


    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
//            .frame(width: 40, height: 40)
            .frame(width: (UIScreen.main.bounds.size.width/6)-24,height: 40)
            .background(Color.white.cornerRadius(5))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(ColorConstants.hint)
                    .frame(height:1)
                    .padding(.top,40)
            })

    }
}
