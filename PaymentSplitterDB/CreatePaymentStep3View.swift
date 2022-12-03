//
//  CreatePaymentStep3View.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/23.
//

import SwiftUI

struct CreatePaymentStep3View: View {
    init() {
        //Use this if NavigationBarTitle is with displayMode = .inline
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
                        
                        Image("Step3")
                            .resizable()
                            .frame(width:150, height: 25)
                            .padding(.top, 50)
                        TotalBalance()
                        TransferResult()
                        NavigationLink(destination: ContentView()){
                            Text("Home")
                            .font(FontRegular)
                            .fontWeight (.bold)
                            .padding(10)

                            .foregroundColor(Color.black)
                            .frame(width: geometry.size.width * 0.5)
                            .background(
                                RoundedRectangle(cornerRadius: 30).fill(Color.white)

                            )
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height*0.8 )
                
                
            }
        }
        .navigationBarTitle(Text("Payment").font(FontLarge), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct CreatePaymentStep3View_Previews: PreviewProvider {
    static var previews: some View {
        CreatePaymentStep3View()
    }
}
