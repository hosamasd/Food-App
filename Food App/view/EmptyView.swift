//
//  EmptyView.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct EmptyView: View {
    var text = "You Card is Empty"
    
    var body: some View {
        Text(text)
            .font(.customfont(.bold, fontSize: 20))
    }
}

#Preview {
    EmptyView()
}
