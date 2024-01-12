
//  ContentView.swift
//  noooted
//
//  Created by Adam Pagels on 2024-01-03.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.lastUpdated, order: .reverse)
    ]) var notes: FetchedResults<Note>
    
    let colorDict: [String: Color] =
    ["red" : .red,
     "orange" : .orange,
     "yellow" : .yellow,
     "green" : .green,
     "blue" : .blue,
     "indigo" : .indigo,
     "purple" : .purple
    ]
    
    @State private var selectedNote: Note?
    @State private var showAddScreen = false
    
    var body: some View {
        ZStack {
            List(notes) { note in
                ZStack {
                    RoundedRectangle(cornerRadius: 8).offset(x: 3, y: 5)
                    RoundedRectangle(cornerRadius: 8) .foregroundColor(colorDict[note.tagColor ?? "red"])
                    Button(note.title ?? "Untitled") {
                        selectedNote = note
                    }.padding(10).foregroundColor(.black)
                    RoundedRectangle(cornerRadius: 8).stroke(style:StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }.padding(EdgeInsets(top:5, leading: 0, bottom: 5, trailing: 0)).listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .sheet(item: $selectedNote) { item in
                NoteView(note: item)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    showAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                }
                .padding(50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showAddScreen) {
            NoteView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
