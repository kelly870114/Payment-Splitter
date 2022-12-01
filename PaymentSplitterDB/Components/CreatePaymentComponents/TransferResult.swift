//
//  TransferResult.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/23.
//

import SwiftUI

struct TransferResult: View {
    @State private var amount = ""
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
            Text("Bitcoin 200.00")
                .font(FontRegular)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
            
            Image("Success")
                .resizable()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            
        }
        .frame(width: UIScreen.main.bounds.width*0.6)
        .padding()
        .background(Color("Card"))
        .cornerRadius(20)
        
        
    }
}

struct TransferResult_Previews: PreviewProvider {
    static var previews: some View {
        TransferResult()
    }
}
