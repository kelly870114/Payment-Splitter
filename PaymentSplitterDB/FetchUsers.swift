//
//  FetchUsers.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/24.
//

import Foundation

class testPaymentAPI: ObservableObject{
    @Published var users: [Users] = []
    func fetch() {
        guard let url = URL(string: "http://localhost:8082/showAmount/amy") else{
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



