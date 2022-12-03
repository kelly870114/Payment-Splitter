//
//  CountryPicker.swift
//  JDA Country Picker
//
//  Created by Jeevan on 04/07/20.
//  Copyright © 2020 JDA. All rights reserved.
//

import SwiftUI


struct ParticipantPicker: View {
    @State var selectParticipant = ""
    @State var selectedIcon: Image?
    var placeholder = "Select Participants"
    var dropDownList = Participant.participantNamesByCode()
    
    var body: some View {
        
        //Dropdown list
        Menu {
            ForEach(dropDownList, id: \.self) { client in
                Button(action: {
                    //選了之後會顯示 name & flag
                    self.selectParticipant = client.name
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
                        .frame(width: 20, height: 20)
                    
                    //下拉選單文字（如果empty: Select)
                    Text(selectParticipant.isEmpty ? placeholder : selectParticipant)
                        .foregroundColor(selectParticipant.isEmpty ? .gray : .black)
                    
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.gray.opacity(0.33))
                        .font(Font.system(size: 16, weight: .semibold))
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

struct ParticipantPicker_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantPicker()
    }
}




