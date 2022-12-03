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
    var currency = "Ethereum"
    
    var body: some View {
        ScrollView{
            VStack{
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
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
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
                            Text("To Alan")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text("Ethereum")
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
                HStack(spacing: 20){
                    Image("Byron")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("Byron Chang")
                            .font(FontSmall)
                            .fontWeight(.bold)
                            .foregroundColor(Color("DarkGray"))
                        HStack(spacing: 5){
                            Text("To Ginny")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
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
                            Text("To Lance")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
                HStack(spacing: 20){
                    Image("Lance")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("Lance Chen")
                            .font(FontSmall)
                            .fontWeight(.bold)
                            .foregroundColor(Color("DarkGray"))
                        HStack(spacing: 5){
                            Text("To Amy")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
                HStack(spacing: 20){
                    Image("Sherry")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("Sherry Chen")
                            .font(FontSmall)
                            .fontWeight(.bold)
                            .foregroundColor(Color("DarkGray"))
                        HStack(spacing: 5){
                            Text("To Alan")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
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
                            Text("To Lance")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
                HStack(spacing: 20){
                    Image("Byron")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("Byron Chang")
                            .font(FontSmall)
                            .fontWeight(.bold)
                            .foregroundColor(Color("DarkGray"))
                        HStack(spacing: 5){
                            Text("To Amy")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
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
                            Text("To Amy")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
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
                            Text("To Sherry")
                            Text("/")
                            Text(getCurrentDate())
                        }
                        .font(FontMini)
                        .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack{
                        Text(currency)
                            .font(FontMini)
                        Text("\(Double.random(in: 1...1000),specifier: "%.2f")")
                            .font(FontRegular)
                            .fontWeight(.bold)
                    }
                }
            }.frame(width: UIScreen.main.bounds.width * 0.9)
        }
        
        
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
