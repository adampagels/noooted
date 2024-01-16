//
//  DataManager.swift
//  noooted
//
//  Created by Adam Pagels on 2024-01-15.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = PersistenceController.shared.viewContext
    }
    
    func createNote(id: UUID, title: String, content: String, tagColor: String, isFavorite: Bool, lastUpdated: Date) {
        let newNote = Note(context: viewContext)
        newNote.id = id
        newNote.title = title
        newNote.content = content
        newNote.tagColor = tagColor
        newNote.isFavorite = isFavorite
        newNote.lastUpdated = lastUpdated
        
        do {
            try viewContext.save()
        } catch {
            print("Error creating note: \(error)")
        }
    }
    
    func updateNote(existingNote: Note, id: UUID?, title: String?, content: String?, tagColor: String?, isFavorite: Bool?, lastUpdated: Date?) {
        existingNote.title = title
        existingNote.content = content
        existingNote.tagColor = tagColor
        existingNote.isFavorite = isFavorite ?? existingNote.isFavorite
        existingNote.lastUpdated = lastUpdated
        
        do {
            try viewContext.save()
        } catch {
            print("Error updating note: \(error)")
        }
    }
    
    func deleteNote(existingNote: Note) {
        viewContext.delete(existingNote)
        
        do {
            try viewContext.save()
        } catch {
            print("Error deleting note: \(error)")
        }
    }
}
