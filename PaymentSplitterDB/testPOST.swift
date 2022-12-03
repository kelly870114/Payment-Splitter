//
//  testPOST.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/27.
//

import SwiftUI

struct testPOST: View {
    @State private var name: String = ""
    @State private var password: String = ""
    
    @ObservedObject var manager = HttpAuth()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if self.manager.authenticated {
                Text("Correct!").font(.headline)
            }
            
            Spacer()
            
            Text("Username")
            TextField("placeholder", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.green)
                .autocapitalization(.none)
            
            Text("Password")
            SecureField("placeholder", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.green)
            
            Button(action: {
                self.manager.postAuth(name: self.name, password: self.password)
                
            }) {
                HStack{
                    Spacer()
                    Text("Login")
                    Spacer()
                }
                .accentColor(Color.white)
                .padding(.vertical, 10)
                .background(Color.red)
                .cornerRadius(5)
                .padding(.horizontal, 40)
                
            }
            Spacer()
        }.padding()
    }
    
    struct testPOST_Previews: PreviewProvider {
        static var previews: some View {
            testPOST()
        }
    }
}
