//
//  CountryPicker.swift
//  JDA Country Picker
//
//  Created by Jeevan on 04/07/20.
//  Copyright © 2020 JDA. All rights reserved.
//

import SwiftUI


struct CryptoCurrPicker: View {
    @State var selectedCrypto = ""
    @State var selectedIcon: Image?
    var placeholder = "Select CryptoCurrency"
    var dropDownList = CryptoCurr.cryptoNamesByCode()
    
    var body: some View {
        
        //Dropdown list
        Menu {
            ForEach(dropDownList, id: \.self) { client in
                Button(action: {
                    //選了之後會顯示 name & flag
                    self.selectedCrypto = client.name
                    self.selectedIcon = client.icon
                }) {
                    
                    HStack{
                        Text(client.name)
                            .foregroundColor(client.name.isEmpty ? .gray : .black)
                        Spacer()
                        
                        client.icon
                    }
                    .padding(.horizontal)
                    
                }
            }
 
        } label: {
            //下拉選單的顯示
            VStack(spacing: 5){
                HStack{
                    selectedIcon?
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    //下拉選單文字（如果empty: Select Country)
                    Text(selectedCrypto.isEmpty ? placeholder : selectedCrypto)
                        .foregroundColor(selectedCrypto.isEmpty ? .gray : .black)
                    
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.gray.opacity(0.33))
                        .font(Font.system(size: 20, weight: .semibold))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.white)
                )
                
                
            }
        }
        .frame(width: 300)
    }
    
}

struct CryptoCurrPicker_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrPicker()
    }
}




