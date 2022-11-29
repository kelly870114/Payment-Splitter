//
//  TotalBalance.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/14.
//

import SwiftUI

struct TotalBalance: View {
    @StateObject var paymentViewModel = PaymentViewModel()
    var body: some View {
        var FontSmall : Font = Font.custom("Nunito", size: 16)
        var FontLarge : Font = Font.custom("Nunito", size: 30)
        
        //GeometryReader{ geometry in
            HStack{
                VStack(alignment: .leading){
                    Text("Total Balance")
                        .font(FontSmall)
                        .foregroundColor(Color.white)
                    ForEach(paymentViewModel.users, id: \.self) {
                        user in
                        HStack {
                            
                            Text("\(user.amount)")
                                .font(FontLarge)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .onAppear(){
                    paymentViewModel.fetch()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.45)
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
                        .accentColor(Color.white)
                        .padding(.top, -10)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3)
                }
                .padding()
                //.background(Color.orange)
            }
            .background(Color("Card"))
            .cornerRadius(20)
            .padding(.horizontal)
        //}
    }
}

struct TotalBalance_Previews: PreviewProvider {
    static var previews: some View {
        TotalBalance()
    }
}
