//
//  paymentPOST.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/28.
//

import Foundation
import SwiftUI
import Combine

//struct ServerMessage: Decodable {
//   let res, message: String
//}
class PaymentAuth: ObservableObject {

    @Published var authenticated = false

    func paymentPostAuth(payer: String, payee: String, amount: Int) {
        guard let url = URL(string: "http://localhost:8082/createPayment") else { return }

        let body: [String: Any] = ["payer": payer, "payee": payee, "amount": amount]


        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
//            let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)
//            print(resData.res)
//            if resData.res == "correct" {
//                DispatchQueue.main.async {
//                    self.authenticated = true
//                }
//            }
        }.resume()
    }
}
