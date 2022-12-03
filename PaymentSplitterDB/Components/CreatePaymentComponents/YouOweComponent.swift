//
//  YouOweComponent.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/14.
//

import SwiftUI

struct YouOweComponent: View {
    var body: some View {
        var FontMini : Font = Font.custom("Nunito", size: 13)
        var FontSmall : Font = Font.custom("Nunito", size: 15)
        var FontRegular : Font = Font.custom("Nunito", size: 20)
        var FontLarge : Font = Font.custom("Nunito", size: 30)
        var currency = "Ethereum"
        VStack{
            HStack{
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
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("500.0")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.75, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(
                    color: Color("Shadow").opacity(0.3),
                    radius:3,
                    x:0,
                    y:1)
                
                NavigationLink(destination: CreatePaymentStep2View()) {
                    Image("PayButton")
                        .resizable()
                        .aspectRatio(100/100, contentMode: .fit)
                        .frame(width: 40)
                }
            }
            
            
            
            HStack{
                HStack(spacing: 20){
                    Image("Amy")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("Amy Ho")
                            .font(FontSmall)
                            .fontWeight(.bold)
                            .foregroundColor(Color("DarkGray"))
                        HStack(spacing: 5){
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("2.0")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                    
                    
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.75, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(
                    color: Color("Shadow").opacity(0.3),
                    radius:3,
                    x:0,
                    y:1)
                NavigationLink(destination: CreatePaymentStep2View()) {
                    Image("PayButton")
                        .resizable()
                        .aspectRatio(100/100, contentMode: .fit)
                        .frame(width: 40)
                }
            }
            
            HStack{
                HStack(spacing: 20){
                    Image("Ginny")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("Ginny Huang")
                            .font(FontSmall)
                            .fontWeight(.bold)
                            .foregroundColor(Color("DarkGray"))
                        HStack(spacing: 5){
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("100.5")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                    
                    
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.75, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(
                    color: Color("Shadow").opacity(0.3),
                    radius:3,
                    x:0,
                    y:1)
                NavigationLink(destination: CreatePaymentStep2View()) {
                    Image("PayButton")
                        .resizable()
                        .aspectRatio(100/100, contentMode: .fit)
                        .frame(width: 40)
                }
            }
            
        }
        
        
        
    }
}

struct YouOweComponent_Previews: PreviewProvider {
    static var previews: some View {
        YouOweComponent()
    }
}
