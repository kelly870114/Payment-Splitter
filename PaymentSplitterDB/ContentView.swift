//
//  ContentView.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/1.
//

import SwiftUI

struct ContentView: View {
    var FontMini : Font = Font.custom("Nunito", size: 13)
    var FontSmall : Font = Font.custom("Nunito", size: 16)
    var FontRegular : Font = Font.custom("Nunito", size: 20)
    var FontLarge : Font = Font.custom("Nunito", size: 30)
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                VStack{
                    ZStack(alignment: .topLeading){
                        RoundedRectMid()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.5).ignoresSafeArea()
                        VStack(alignment: .leading){
                            HStack(spacing: 10){
                                Image("Sherry")
                                    .resizable()
                                    .frame(width: 60, height: 60)
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
                            
                            TotalBalance()
                            
                            HStack{
                                
                                
                                
                                NavigationLink(destination: CreateExpenseMainView()) {
                                    VStack{
                                        Image("AddExpense")
                                            .resizable()
                                            .aspectRatio(100/95, contentMode: .fit)
                                            .frame(width: 40)
                                        Text("Expense")
                                            .font(.system(size: 13))
                                            .foregroundColor(Color.white)
                                    }
                                    //Action
                                }
                                .navigationBarBackButtonHidden(true)
                                .padding(.leading, 40)
                                .padding(.top, 10)
                                
                                Spacer()
                                NavigationLink(destination: CreatePaymentMainView()) {
                                    VStack{
                                        Image("CreatePayment")
                                            .resizable()
                                            .aspectRatio(100/95, contentMode: .fit)
                                            .frame(width: 40)
                                        Text("Payment")
                                            .font(.system(size: 13))
                                            .foregroundColor(Color.white)
                                    }
                                    //Action
                                }
                                .navigationBarBackButtonHidden(true)
                                .padding(.top, 10)
                                Spacer()
                                NavigationLink(destination: testPOST()) {
                                    VStack{
                                        Image("Withdraw")
                                            .resizable()
                                            .aspectRatio(100/95, contentMode: .fit)
                                            .frame(width: 40)
                                        Text("Withdraw")
                                            .font(.system(size: 13))
                                            .foregroundColor(Color.white)
                                    }
                                    //Action
                                }
                                .padding(.trailing, 40)
                                .padding(.top, 10)
                                
                            }
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height*0.45)
                    //Get Activity
                    VStack(alignment: .leading){
                        Text("All Activity")
                            .font(FontRegular)
                            .fontWeight(.bold)
                            .frame(maxWidth: geometry.size.width*0.9, alignment: .leading)
                            .foregroundColor(Color("SecondColor"))
                        Text(getCurrentMonth())
                            .font(FontSmall)
                            .fontWeight(.medium)
                            .foregroundColor(Color("Shadow"))
                        History()
                    }
                    
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
func getCurrentMonth() -> String{
    let date = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    //let month = calendar.component(.day, from: date)
    let monthName = dateFormatter.string(from: date)
    let year = calendar.component(.year, from: date)
    let theMonth = "\(monthName) \(year)"
    return theMonth
}

func getCurrentDate() -> String{
    let date = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    let month = calendar.component(.month, from: date)
    //let monthName = dateFormatter.string(from: date)
    let year = calendar.component(.year, from: date)
    let day = calendar.component(.day, from: date)
    let theDate = "\(month). \(day), \(year)"
    return theDate
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
