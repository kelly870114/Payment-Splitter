//
//  testAPI.swift
//  testCreatePayment
//
//  Created by 黃嬿羽 on 2022/11/24.
//

import SwiftUI
struct Users : Hashable, Codable {
    let amount: Int
}

class PaymentViewModel: ObservableObject{
    @Published var users: [Users] = []
    func fetch() {
        guard let url = URL(string: "http://localhost:8082/showAmount/Will") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let users = try JSONDecoder().decode([Users].self, from: data)
                DispatchQueue.main.async {
                    self?.users = users
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct testCreatePayment: View {
    @StateObject var paymentViewModel = PaymentViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Console 去哪了")
                            .padding()
                            .onTapGesture(perform: {
                                print(paymentViewModel.users)
                            })
                ForEach(paymentViewModel.users, id: \.self) {
                    user in
                    HStack {
                        Image("")
                            .frame(width: 130, height: 70)
                            .background(Color.gray)
                        
                        Text("\(user.amount)")
                            .bold()
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Users")
            .onAppear(){
                           paymentViewModel.fetch()
            }
        }
        
        
    }
}

struct testCreatePayment_Previews: PreviewProvider {
    static var previews: some View {
        testCreatePayment()
    }
}
