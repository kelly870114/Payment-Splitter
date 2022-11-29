//
//  CreatePaymentStep2View.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/15.
//

import SwiftUI

struct CreatePaymentStep2View: View {
    @State private var answer : Bool = false
    @State private var amount : Int = 0
    @ObservedObject var manager = PaymentAuth()
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white,.font : UIFont(name: "Nunito-Bold", size: 30)!]
    }
    var FontMini : Font = Font.custom("Nunito", size: 13)
    var FontSmall : Font = Font.custom("Nunito", size: 16)
    var FontRegular : Font = Font.custom("Nunito", size: 20)
    var FontLarge : Font = Font.custom("Nunito", size: 30)
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                ZStack(alignment: .topLeading){
                    RoundedRectMid()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.9).ignoresSafeArea()
                    VStack(alignment: .center, spacing: 20){
                        
                        Image("Step2")
                            .resizable()
                            .frame(width:150, height: 25)
                            .padding(.top, 50)
                        TotalBalance()
                        TransferTo(amount: self.$amount)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height*0.8 )
                
                
                VStack(alignment: .leading){
//                    Button(action: {
//                        print(self.amount)
//
//                    }) {
//
//                        HStack{
//                            Spacer()
//                            Text("Confirm")
//                            Spacer()
//                        }
//                        .accentColor(Color.white)
//                        .padding(.vertical, 10)
//                        .background(Color.red)
//                        .cornerRadius(5)
//                        .padding(.horizontal, 40)
//
//                    }
                    NavigationLink(destination: CreatePaymentStep3View(), isActive: $answer, label: {
                        Button(action: {
                            self.manager.paymentPostAuth(payer: "Ginny", payee: "Will", amount: self.amount); self.answer = true
                                }, label: {
                                        Text("Confirm")
                                        .font(FontRegular)
                                        .fontWeight (.bold)
                                        .padding(10)

                                        .foregroundColor(Color.white)
                                        .frame(width: geometry.size.width * 0.8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 30).fill(Color("SecondColor"))

                                        )

                            })
                    })
//                    NavigationLink(destination: CreatePaymentStep3View()) {
//                        Text("Confirm")
//                            .font(FontRegular)
//                            .fontWeight (.bold)
//                            .padding(10)
//
//                            .foregroundColor(Color.white)
//                            .frame(width: geometry.size.width * 0.8)
//                            .background(
//                                RoundedRectangle(cornerRadius: 30).fill(Color("SecondColor"))
//
//                            )
//                    }
                }
                
            }
        }
        .navigationBarTitle(Text("Payment").font(FontLarge), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct CreatePaymentStep2View_Previews: PreviewProvider {
    static var previews: some View {
        CreatePaymentStep2View()
    }
}
