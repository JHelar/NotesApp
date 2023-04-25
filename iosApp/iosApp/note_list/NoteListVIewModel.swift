//
//  NoteListVIewModel.swift
//  iosApp
//
//  Created by John Larsson on 2023-04-24.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

extension NoteListScreen {
    @MainActor class NoteListViewModel: ObservableObject {
        private var noteDataSource: NoteDataSource? = nil
        
        private let searchNotes = SearchNotes()
        
        private var notes = [Note]()
        @Published private(set) var filterNotes = [Note]()
        @Published var searchText = "" {
            didSet {
                self.filterNotes = searchNotes.execute(notes: self.notes, query: searchText)
            }
        }
        @Published private(set) var isSearchActive = false
        
        init(noteDataSource: NoteDataSource? = nil) {
            self.noteDataSource = noteDataSource
        }
        
        func loadNotes() async {
            do {
                self.notes = try await noteDataSource?.getAllNotes() ?? []
                self.filterNotes = self.notes
            } catch {
                
            }
        }
        
        func deleteNoteById(id: Int64?) async {
            if id != nil {
                do {
                    try await noteDataSource?.deleteNoteById(id: id!)
                    await self.loadNotes()
                } catch {
                    
                }
            }
        }
        
        func toggleIsSearchActive() {
            isSearchActive = !isSearchActive
            
            if(!isSearchActive) {
                searchText = ""
            }
        }
        
        func setNoteDataSource(noteDataSource: NoteDataSource) {
            self.noteDataSource = noteDataSource
        }
    }
}
