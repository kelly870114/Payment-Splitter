//
//  RoundedRectMid.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/14.
//

import SwiftUI

struct RoundedRectMid: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(Color.black)
            .shadow(
                color: Color("Shadow").opacity(0.75),
                radius:8,
                x:0,
                y:3)
    }
}

struct RoundedRectMid_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectMid()
    }
}
