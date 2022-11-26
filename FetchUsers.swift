//
//  FetchUsers.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/24.
//

import Foundation

//class FetchUsers : ObservableObject {
//    @Published var items = [User]()    
//    init() {
//        let CreatePaymenturl = URL( string: "http://localhost:8082/createParticipant" )!
//        URLSession.shared.dataTask(with: CreatePaymenturl) {(data, response, error) in
//            do{
//                if let data = data {
//                    let decodeData = try JSONDecoder().decode([User].self, from: data)
//                    DispatchQueue.main.async {
//                        self.items = decodeData
//                    }
//                }
//                else {
//                    print("No data")
//                }
//            }
//            catch {
//                print("Error:  \(error.localizedDescription ?? "unknown error")")
//            }
//        }.resume()
//    }
//}
