//
//  NoteView.Swift
//  noooted
//
//  Created by Adam Pagels on 2024-01-04.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    var note: Note?
    
    @State private var title = ""
    @State private var content = ""
    @State private var tagColor = "red"
    @State private var isFavorite = false
    @State private var lastUpdated: Date? = nil
    
    func changeTagColor (tag: String) {
        tagColor = tag
    }
    
    var formattedDate: String {
        guard let date = lastUpdated else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .offset(x: 3, y: 5)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.yellow)
                        
                        Button {
                            isFavorite.toggle()
                        } label: {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .foregroundColor(.white)
                        }
                        
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style:StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        
                    }.frame(width: 40, height: 40)
                    Spacer()
                }
                Text("\(formattedDate)")
                
                HStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .offset(x: 3, y: 5)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(note == nil ? .gray : .red)
                        
                        Button {
                            deleteNote()
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                        }
                        .disabled(note == nil)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style:StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        
                    }.frame(width: 40, height: 40)
                }
            }.padding(EdgeInsets(top:20, leading: 0, bottom: 20, trailing: 0))
            
            ZStack {
                RoundedRectangle(cornerRadius: 8).offset(x: 3, y: 5)
                RoundedRectangle(cornerRadius: 8).foregroundColor(Color.white)
                Section {
                    TextField("What should we call this?", text: $title)
                }.padding(14)
                RoundedRectangle(cornerRadius: 8).stroke(style:StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
            .frame(height: 40)
            
            HStack {
                ZStack {
                    Circle().offset(x: 1.5, y: 2).fill(Color.black)
                    Circle().fill(Color.red).onTapGesture {
                        changeTagColor(tag: "red")
                    }
                    Circle().stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                }.saturation(tagColor == "red" ? 1 : 0.6)
                
                ZStack {
                    Circle().offset(x: 1.5, y: 2).fill(Color.black)
                    Circle().fill(Color.orange).onTapGesture {
                        changeTagColor(tag: "orange")
                    }
                    Circle().stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                }.saturation(tagColor == "orange" ? 1 : 0.6)
                
                ZStack {
                    Circle().offset(x: 1.5, y: 2).fill(Color.black)
                    Circle().fill(Color.yellow).onTapGesture {
                        changeTagColor(tag: "yellow")
                    }
                    Circle().stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                }.saturation(tagColor == "yellow" ? 1 : 0.6)
                
                ZStack {
                    Circle().offset(x: 1.5, y: 2).fill(Color.black)
                    Circle().fill(Color.green).onTapGesture {
                        changeTagColor(tag: "green")
                    }
                    Circle().stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                }.saturation(tagColor == "green" ? 1 : 0.6)
                
                ZStack {
                    Circle().offset(x: 1.5, y: 2).fill(Color.black)
                    Circle().fill(Color.blue).onTapGesture {
                        changeTagColor(tag: "blue")
                    }
                    Circle().stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                }.saturation(tagColor == "blue" ? 1 : 0.6)
                
                ZStack {
                    Circle().offset(x: 1.5, y: 2).fill(Color.black)
                    Circle().fill(Color.indigo).onTapGesture {
                        changeTagColor(tag: "indigo")
                    }
                    Circle().stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                }.saturation(tagColor == "indigo" ? 1 : 0.6)
                
                ZStack {
                    Circle().offset(x: 1.5, y: 2).fill(Color.black)
                    Circle().fill(Color.purple).onTapGesture {
                        changeTagColor(tag: "purple")
                    }
                    Circle().stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                }.saturation(tagColor == "purple" ? 1 : 0.6)
            }.frame(maxWidth: .infinity, maxHeight: 100)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8).offset(x: 3, y: 5)
                RoundedRectangle(cornerRadius: 8).foregroundColor(Color.white)
                TextEditor(text: $content).padding()
                RoundedRectangle(cornerRadius: 8).stroke(style:StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
        }
        .onAppear {
            if let note = note {
                title = note.title ?? ""
                content = note.content ?? ""
                tagColor = note.tagColor ?? "red"
                isFavorite = note.isFavorite
                lastUpdated = note.lastUpdated
            }
        }
        .onDisappear {
            if note != nil {
                if title.isEmpty && content.isEmpty {
                    deleteNote()
                } else {
                    updateNote()
                }
            } else {
                createNote()
            }
        }
        .padding(EdgeInsets(top:0, leading: 20, bottom: 20, trailing: 20))
    }
    
    
    private func createNote() {
        DataManager.shared.createNote(
            id: UUID(),
            title: !title.isEmpty ? title : "Untitled",
            content: content,
            tagColor: !title.isEmpty ? tagColor : "red",
            isFavorite: isFavorite,
            lastUpdated: Date.now
        )
    }
    
    private func updateNote() {
        guard let existingNote = note else {
            print("Error retrieving note")
            return
        }
        DataManager.shared.updateNote(
            existingNote: existingNote,
            id: UUID(),
            title: !title.isEmpty ? title : "Untitled",
            content: content,
            tagColor: !title.isEmpty ? tagColor : "red",
            isFavorite: isFavorite,
            lastUpdated: lastUpdated)
    }
    
    private func deleteNote() {
        guard let existingNote = note else {
            print("Error retrieving note")
            return
        }
        DataManager.shared.deleteNote(existingNote: existingNote)
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
