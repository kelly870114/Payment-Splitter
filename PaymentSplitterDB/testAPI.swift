//
//  testAPI.swift
//  PaymentSplitterDB
//
//  Created by 黃嬿羽 on 2022/11/24.
//

import SwiftUI
struct Course : Hashable, Codable {
    let name: String
    let image: String
}

class ViewModel: ObservableObject{
    @Published var courses: [Course] = []
    func fetch() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct testAPI: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.courses, id: \.self) {
                    course in
                    HStack {
                        Image("")
                            .frame(width: 130, height: 70)
                            .background(Color.gray)
                        Text(course.name)
                            .bold()
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Course")
            .onAppear(){
                viewModel.fetch()
            }
        }
        
        
    }
}

struct testAPI_Previews: PreviewProvider {
    static var previews: some View {
        testAPI()
    }
}
