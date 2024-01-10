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
    
    func createNote() {
        let newNote = Note(context: moc)
        newNote.id = UUID()
        newNote.title = title
        newNote.content = content
        newNote.tagColor = tagColor
        newNote.isFavorite = false
        newNote.lastUpdated = Date.now
        do {
            try moc.save()
            dismiss()
        } catch {
            print("Error saving note: \(error)")
        }
    }
    
    func updateNote() {
        guard let existingNote = note else {
            print("Error retrieving note")
            return
        }
        existingNote.title = title
        existingNote.content = content
        existingNote.tagColor = tagColor
        existingNote.lastUpdated = Date.now
        
        do {
            try moc.save()
            dismiss()
        } catch {
            print("Error updating note: \(error)")
        }
    }
    
    private func deleteNote() {
        guard let existingNote = note else {
            print("Error retrieving note")
            return
        }
        moc.delete(existingNote)
        
        do {
            try moc.save()
            dismiss()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            Button {
                deleteNote()
            } label: {
                Image(systemName: "trash")
            }.disabled(note == nil)
            Text("\(formattedDate)")
            Section {
                TextField("Title", text: $title)
            }
            HStack {
                Circle().fill(Color.red)
                    .onTapGesture {
                        changeTagColor(tag: "red")
                    }
                    .overlay(tagColor == "red" ? Circle().stroke(Color.black, lineWidth: 3) : nil)
                
                Circle().fill(Color.orange)
                    .onTapGesture {
                        changeTagColor(tag: "orange")
                    }
                    .overlay(tagColor == "orange" ? Circle().stroke(Color.black, lineWidth: 3) : nil)
                
                Circle().fill(Color.yellow)
                    .onTapGesture {
                        changeTagColor(tag: "yellow")
                    }
                    .overlay(tagColor == "yellow" ? Circle().stroke(Color.black, lineWidth: 3) : nil)
                
                Circle().fill(Color.green)
                    .onTapGesture {
                        changeTagColor(tag: "green")
                    }
                    .overlay(tagColor == "green" ? Circle().stroke(Color.black, lineWidth: 3) : nil)
                
                Circle().fill(Color.blue)
                    .onTapGesture {
                        changeTagColor(tag: "blue")
                    }
                    .overlay(tagColor == "blue" ? Circle().stroke(Color.black, lineWidth: 3) : nil)
                
                Circle().fill(Color.indigo)
                    .onTapGesture {
                        changeTagColor(tag: "indigo")
                    }
                    .overlay(tagColor == "indigo" ? Circle().stroke(Color.black, lineWidth: 3) : nil)
                
                Circle().fill(Color.purple)
                    .onTapGesture {
                        changeTagColor(tag: "purple")
                    }
                    .overlay(tagColor == "purple" ? Circle().stroke(Color.black, lineWidth: 3) : nil)
            }
            
            Section {
                TextEditor(text: $content)
            }
            Button(note != nil ? "Update" : "Create") {
                note != nil ? updateNote() : createNote()
            }.disabled(content.isEmpty)
            
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
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
