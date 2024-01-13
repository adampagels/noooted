
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
    
    func formattedDate(date: Date) -> String {
        return date.formatted()
    }
    
    var body: some View {
        ZStack {
            List(notes) { note in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .offset(x: 3, y: 5)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(colorDict[note.tagColor ?? "red"])
                    
                    Button {
                        selectedNote = note
                    } label: {
                        VStack {
                            HStack {
                                Text("\(formattedDate(date: note.lastUpdated ?? Date.now))")
                                    .font(.system(size: 13))
                                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 5))
                                    .opacity(0.7)
                                Spacer()
                            }
                            HStack {
                                Text("\(note.title ?? "Untitled")")
                                    .lineLimit(1)
                                    .bold()
                                Spacer()
                            }
                        }
                        .padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 5))
                    }
                    .padding(EdgeInsets(top:0, leading: 0, bottom: 10, trailing: 10))
                    .foregroundColor(.black)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style:StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }
                .padding(EdgeInsets(top:5, leading: 0, bottom: 5, trailing: 0))
                .listRowSeparator(.hidden)
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
