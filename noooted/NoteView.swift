//
//  NoteView.Swift
//  noooted
//
//  Created by Adam Pagels on 2024-01-04.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var content = ""
    @State private var tagColor = "red"
    
    func changeTagColor (tag: String) {
        tagColor = tag
    }
    
    var body: some View {
        Form {
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
            Button("Add Note") {
                print("button clicked")
            }
            
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
