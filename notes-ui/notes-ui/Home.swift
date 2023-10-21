//
//  ContentView.swift
//  notes-ui
//
//  Created by Jayanta Adhikary on 21/10/23.
//

import SwiftUI

struct Home: View {
    
    @State var notes = [Note]()
    
    @State var showAdd = false
    
    var body: some View {
        NavigationView {
            List(self.notes){ note in
                Text(note.note)
                    .padding()
            }
            .sheet(isPresented: $showAdd, onDismiss: fetchNotes
             , content: {
                AddNoteView()
            })
            .onAppear(perform: {
                fetchNotes()
            })
            .navigationTitle("Notes")
            .navigationBarItems(trailing: Button(action: {
                self.showAdd.toggle()
            }, label: {
                Text("Add")
            }))
        }
        
    }
    
    
    func fetchNotes(){
        let url = URL(string: "http://localhost:5000/notes")!
        
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data else {return}
            
            do {
                let notes = try JSONDecoder().decode([Note].self, from: data)
                self.notes = notes
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}

struct Note: Identifiable, Codable {
    var id: String {_id}
    var _id: String
    var note: String
    
}

#Preview {
    Home()
}
