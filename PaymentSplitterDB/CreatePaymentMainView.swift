//
//  CreatePaymentMainView.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/14.
//

import SwiftUI
//往右滑返回
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct CreatePaymentMainView: View {
    init() {
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white,.font : UIFont(name: "Nunito-Bold", size: 30)!]
    }
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
                        VStack(alignment: .center, spacing: 20){
                            
                            Image("Step1")
                                .resizable()
                                .frame(width:150, height: 25)
                                .padding(.top, 50)
                            TotalBalance()
                            
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height*0.4 )
                    .background(Color.pink)
                    VStack(alignment: .leading){
                        HStack{
                            YouOweComponent()
                                .frame(maxWidth: geometry.size.width*0.8, alignment: .leading)
                                .background(Color.orange)
                            NavigationLink(destination: CreatePaymentMainView()) {
                                Image("PayButton")
                                    .resizable()
                                    .aspectRatio(100/100, contentMode: .fit)
                                    .frame(width: 40)
                            }
                        }
                        
                            
                    }.background(Color.green)
                    
                }
            }
            .navigationBarTitle(Text("Payment").font(FontLarge), displayMode: .inline)
        }
    }
}

struct CreatePaymentMainView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePaymentMainView()
    }
}
