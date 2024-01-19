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
    @State private var deleteButtonTapped = false
    
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
            NoteHeaderView(
                isFavorite: $isFavorite,
                deleteButtonTapped: $deleteButtonTapped,
                deleteNote: deleteNote,
                formattedDate: formattedDate
            )
            
            NeubrutalShadowView(shape: "rectangle", contentColor: .white) {
                TextField("What should we call this?", text: $title)
                    .padding(14)
            }
            .frame(height: 40)
            
            HStack {
                ForEach(Array(colorDict.keys.sorted()), id: \.self) { key in
                    NeubrutalShadowView(shape: "circle", contentColor: .white, isInactive: tagColor != key) {
                        Circle().fill(colorDict[key] ?? .red).onTapGesture {
                            tagColor = key
                        }
                    }
                    .saturation(tagColor == key ? 1 : 0.3)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            
            NeubrutalShadowView(shape: "rectangle", contentColor: .white) {
                TextEditor(text: $content)
                    .padding()
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
                    if !deleteButtonTapped {
                        deleteNote()
                    }
                } else {
                    if !deleteButtonTapped {
                        updateNote()
                    }
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
            tagColor: tagColor,
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
            tagColor: tagColor,
            isFavorite: isFavorite,
            lastUpdated: lastUpdated)
    }
    
    private func deleteNote() {
        guard let existingNote = note else {
            print("Error retrieving note")
            return
        }
        DataManager.shared.deleteNote(existingNote: existingNote)
        dismiss()
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}

struct NoteHeaderView: View {
    @Binding var isFavorite: Bool
    @Binding var deleteButtonTapped: Bool
    var deleteNote: () -> Void
    var formattedDate: String
    var note: Note?
    
    var body: some View {
        ZStack {
            HStack {
                NeubrutalShadowView(shape: "rectangle", contentColor: .yellow) {
                    Button {
                        isFavorite.toggle()
                    } label: {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 40, height: 40)
                Spacer()
            }
            
            Text("\(formattedDate)")
            
            HStack {
                Spacer()
                NeubrutalShadowView(shape: "rectangle", contentColor: note == nil ? .gray : .red) {
                    Button {
                        deleteButtonTapped = true
                        deleteNote()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                    }
                    .disabled(note == nil)
                }
                .frame(width: 40, height: 40)
            }
        }
        .padding(EdgeInsets(top:20, leading: 0, bottom: 20, trailing: 0))
    }
}
