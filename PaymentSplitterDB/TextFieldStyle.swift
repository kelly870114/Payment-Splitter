//
//  TextFieldStyle.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/20.
//

import SwiftUI

struct TextFieldStyle: View {
    @State private var amount = ""
    var font : Font = Font.custom("Nunito", size: 20)
    var body: some View {
        TextField("Placeholder", text: $amount, prompt: Text("HI"))
            .font(font)
            .frame(width: 300)
//            .background(textFieldBorder)
            // Make sure no other style is mistakenly applied.
              .textFieldStyle(PlainTextFieldStyle())
              // Text alignment.
              .multilineTextAlignment(.leading)
              // Cursor color.
              .accentColor(.pink)
              // Text color.
              .foregroundColor(.blue)
              // Text/placeholder font.
              .font(.title.weight(.semibold))
              // TextField spacing.
              .padding()
              // TextField border.
              .background(textFieldBorder)
            
    }
    
    var textFieldBorder: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.white)
        
            
    }
}

struct TextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldStyle()
    }
}
