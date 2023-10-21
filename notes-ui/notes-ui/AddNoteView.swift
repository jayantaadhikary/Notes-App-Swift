//
//  AddNoteView.swift
//  notes-ui
//
//  Created by Jayanta Adhikary on 21/10/23.
//

import SwiftUI

struct AddNoteView: View {
    
    @State var text = ""
    
    var body: some View {
        HStack{
            TextField("Write a note...", text: $text)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .clipped()
            
            Button {
                postNote()
            } label: {
                Text("Add")
            }
            .padding(8)
        }
    }
    
    func postNote(){
        print("POST")
    }
}

#Preview {
    AddNoteView()
}
