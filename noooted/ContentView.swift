//
//  ContentView.swift
//  noooted
//
//  Created by Adam Pagels on 2024-01-03.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    @State private var showAddScreen = false
    var body: some View {
        NavigationView {
            VStack {
                List(notes) { note in
                    Text(note.title ?? "Unknown")
                }
                Spacer()
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
            }
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showAddScreen) {
                NoteView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
