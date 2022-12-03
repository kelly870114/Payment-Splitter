//
//  testMultiPicker.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/30.
//

import SwiftUI
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    var FontSmall : Font = Font.custom("Nunito", size: 18)
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(Color("SecondColor"))
                }
            }
        }
        .foregroundColor(Color.black)
        .font(FontSmall)
    }
}
struct testMultiPicker: View {
    init() {
        UITableView.appearance().backgroundColor = .yellow
    }
    @State var items: [String] = ["Sherry", "Amy", "Ginny", "Alan", "Byron", "Lance"]
        @State var selections: [String] = []

        var body: some View {
            if #available(iOS 16.0, *) {
                List {
                    ForEach(self.items, id: \.self) { item in
                        MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                            if self.selections.contains(item) {
                                self.selections.removeAll(where: { $0 == item })
                            }
                            else {
                                self.selections.append(item)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
            } else {
                // Fallback on earlier versions
            }
        }
}

struct testMultiPicker_Previews: PreviewProvider {
    static var previews: some View {
        testMultiPicker()
    }
}
