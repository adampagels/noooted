
//  ContentView.swift
//  noooted
//
//  Created by Adam Pagels on 2024-01-03.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    @State private var selectedNote: Note?
    @State private var showAddScreen = false
    
    var body: some View {
        ZStack {
            List(notes) { note in
                Button(note.title ?? "Unknown") {
                    selectedNote = note
                }
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
