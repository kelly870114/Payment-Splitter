//
//  TransferTo.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/16.
//

import SwiftUI

struct TransferTo: View {
    @Binding public var amount : Int
    @State public var note = ""
    var textFieldBorder: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.white)
    }
    var body: some View {
        var FontMini : Font = Font.custom("Nunito", size: 13)
        var FontSmall : Font = Font.custom("Nunito", size: 16)
        var FontRegular : Font = Font.custom("Nunito", size: 20)
        var FontLarge : Font = Font.custom("Nunito", size: 30)
        
        VStack{
            Text("Transfer to")
                .font(FontRegular)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
            Image("Amy")
                .resizable()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            Text("Amy Ho")
                .font(FontSmall)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
            
            CryptoCurrPicker()
            TextField("Enter Amount", value: $amount, format: .number)
                //.font(FontRegular)
                .frame(width: 275)
    //            .background(textFieldBorder)
                // Make sure no other style is mistakenly applied.
                  .textFieldStyle(PlainTextFieldStyle())
                  // Text alignment.
                  .multilineTextAlignment(.leading)
                  // Cursor color.
                  //.accentColor(.pink)
                  // Text/placeholder font.
                  //.font(.title.weight(.semibold))
                  // TextField spacing.
                  .padding(12.0)
                  // TextField border.
                  .background(textFieldBorder)
            
            TextField("Placeholder", text: $note, prompt: Text("Note (Optional)"))
                .frame(width: 275)
                  .textFieldStyle(PlainTextFieldStyle())
                  .multilineTextAlignment(.leading)
                  .padding(12.0)
                  .background(textFieldBorder)
            
        }
        .padding()
        .background(Color("Card"))
        .cornerRadius(20)
        
        
    }
}

struct TransferTo_Previews: PreviewProvider {
    static var previews: some View {
        TransferTo(amount: .constant(0))
    }
}
