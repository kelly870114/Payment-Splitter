//
//  TransferTo.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/16.
//

import SwiftUI

struct SplitGroup: View {
    @Binding public var amount : Float
    @Binding public var title : String
    var textFieldBorder: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.white)
    }
    var body: some View {
        var FontMini : Font = Font.custom("Nunito", size: 13)
        var FontSmall : Font = Font.custom("Nunito", size: 16)
        var FontRegular : Font = Font.custom("Nunito", size: 20)
        var FontLarge : Font = Font.custom("Nunito", size: 30)
        
        VStack{
            TextField("Placeholder", text: $title, prompt: Text("Enter Title"))
                .frame(width: 275)
                  .textFieldStyle(PlainTextFieldStyle())
                  .multilineTextAlignment(.leading)
                  .padding(12.0)
                  .background(textFieldBorder)
            testMultiPicker()
                .padding(.vertical, -30.0)
            TextField("Enter Amount", value: $amount, format: .number)
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

struct SplitGroup_Previews: PreviewProvider {
    static var previews: some View {
        SplitGroup(amount: .constant(0), title: .constant(""))
    }
}
