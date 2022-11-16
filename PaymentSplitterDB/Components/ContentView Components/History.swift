//
//  History.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/14.
//

import SwiftUI

struct History: View {
    var FontMini : Font = Font.custom("Nunito", size: 13)
    var FontSmall : Font = Font.custom("Nunito", size: 16)
    var FontRegular : Font = Font.custom("Nunito", size: 20)
    var FontLarge : Font = Font.custom("Nunito", size: 30)
    
    var body: some View {
        HStack(spacing: 20){
            Image("Alan")
                .resizable()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            VStack(alignment: .leading){
                Text("Alan Chen")
                    .font(FontSmall)
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkGray"))
                HStack(spacing: 5){
                    Text("To Byron")
                    Text("/")
                    Text(getCurrentDate())
                }
                .font(FontMini)
                .foregroundColor(Color.gray)
            }
            Spacer()
            VStack{
                Text("Bitcoin")
                    .font(FontMini)
                Text("500")
                    .font(FontRegular)
                    .fontWeight(.bold)
            }
            
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
