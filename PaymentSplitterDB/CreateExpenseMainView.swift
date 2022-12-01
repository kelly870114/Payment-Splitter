//
//  CreatePaymentStep2View.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/15.
//

import SwiftUI

struct CreateExpenseMainView: View {
    @State private var answer : Bool = false
    @State private var amount : Float = 0
    @State private var title = ""
    @ObservedObject var manager = ExpenseAuth()
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white,.font : UIFont(name: "Nunito-Bold", size: 30)!]
    }
    var FontMini : Font = Font.custom("Nunito", size: 13)
    var FontSmall : Font = Font.custom("Nunito", size: 16)
    var FontRegular : Font = Font.custom("Nunito", size: 20)
    var FontLarge : Font = Font.custom("Nunito", size: 30)
    var payees : [String] = ["amy", "ginny", "alan"]
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                ZStack(alignment: .topLeading){
                    RoundedRectMid()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.9).ignoresSafeArea()
                    VStack{
                        SplitGroup(amount: self.$amount, title: self.$title)
                    }
                    .padding(.top, 80.0)
                }
                .frame(width: geometry.size.width, height: geometry.size.height*0.8 )
                
                
                VStack(alignment: .leading){
                    NavigationLink(destination: ContentView(), isActive: $answer, label: {
                        Button(action: {
                            self.manager.expensePostAuth(title: self.title, payer: "sherry", payees: payees, amount: self.amount, date: 20221130); self.answer = true
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
                }
                
            }
        }
        .navigationBarTitle(Text("Payment").font(FontLarge), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct CreateExpenseMainView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExpenseMainView()
    }
}
