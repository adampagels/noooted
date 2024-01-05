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
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
            }
            Section {
                TextEditor(text: $content)
            }
        }
        
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
