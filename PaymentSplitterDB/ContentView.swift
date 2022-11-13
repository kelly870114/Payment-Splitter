//
//  ContentView.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/1.
//

import SwiftUI

struct ContentView: View {
    var FontSmall : Font = Font.custom("Nunito", size: 16)
    var FontRegular : Font = Font.custom("Nunito", size: 20)
    var FontLarge : Font = Font.custom("Nunito", size: 30)
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                ZStack(alignment: .topLeading){
                    RoundedRectangle(cornerRadius: 50 )
                        .fill(Color.black)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.45).ignoresSafeArea()
                        .shadow(
                            color: Color("Shadow").opacity(0.75),
                            radius: 3,
                            x:0,
                            y:3)
                    VStack(alignment: .leading){
                        HStack(spacing: 10){
                            Image("Sherry")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .padding(.leading, 20)
                            VStack(alignment: .leading){
                                Text("Welcome Back,")
                                    .font(FontSmall)
                                    .foregroundColor(Color.gray)
                                Text("Sherry Chen")
                                    .font(FontRegular)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                            Image("Notification")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding()
                        }
                        //.background(Color.pink)
                        HStack{
                            VStack(alignment: .leading){
                                Text("Total Balance")
                                    .font(FontSmall)
                                    .foregroundColor(Color.white)
                                Text("500,000")
                                    .font(FontLarge)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                            .padding()
                            .frame(width: geometry.size.width * 0.45)
                            //.background(Color.blue)
                            
                            Spacer()
                            HStack(alignment: .center){
                                VStack{
                                    Image("Bitcoin")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .padding(.top)
                                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("CryptoCurrency")) {
                                        Text("Bitcoin").tag(1)
                                        Text("Ethereum").tag(2)
                                    }
                                    .padding(.top, -10)
                                }
                                .frame(width: geometry.size.width * 0.3)
                            }
                            .padding()
                            //.background(Color.orange)
                        }
                        .background(Color("Card"))
                        .cornerRadius(20)
                        .padding()
                        
                    }
                    //.background(Color.green)
                    
                    
                }
                
               
                
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
