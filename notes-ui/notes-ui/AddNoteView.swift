//
//  AddNoteView.swift
//  notes-ui
//
//  Created by Jayanta Adhikary on 21/10/23.
//

import SwiftUI

struct AddNoteView: View {
    
    @State var text = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack{
            TextField("Write a note...", text: $text)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
//                .clipped()
            
            Button {
                postNote()
            } label: {
                Text("Add")
            }
            .padding(8)
        }
    }
    
    func postNote(){
        let params = ["note" : text] as [String: Any]
        
        let url = URL(string: "http://localhost:5000/notes")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) {
            data, res, err in
                guard err == nil else {return}
                
                guard let data = data else {return}
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
                        print(json)
                    }
                        
                }
                catch let error{
                    print(error)
                }
            
        }
        task.resume()
        
        self.text = ""
        
        dismiss()
        
    }
}

#Preview {
    AddNoteView()
}
