//
//  NoteDetailViewModel.swift
//  iosApp
//
//  Created by John Larsson on 2023-04-24.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

extension NoteDetailScreen {
    @MainActor class NoteDetailViewModel: ObservableObject {
        private var noteDataSource: NoteDataSource?
        private var noteId: Int64? = nil
        
        @Published var noteTitle = ""
        @Published var noteContent = ""
        @Published private(set) var noteColor = Note.companion.generateRandomColor()
        private var noteCreated: Kotlinx_datetimeLocalDateTime? = nil
        
        
        init(noteDataSource: NoteDataSource? = nil) {
            self.noteDataSource = noteDataSource
        }
        
        func loadNoteIfExists(id: Int64?) async {
            if id != nil {
                self.noteId = id
                do {
                    let note = try await noteDataSource?.getNoteById(id: id!)
                    noteTitle = note?.title ?? ""
                    noteContent = note?.content ?? ""
                    noteColor = note?.colorHex ?? Note.companion.generateRandomColor()
                    noteCreated = note?.created
                } catch {}
            }
        }
        
        func saveNote() async {
            do {
                try await noteDataSource?.insertNote(
                    note: Note(
                        id: noteId == nil ? nil : KotlinLong(value: self.noteId!),
                        title: self.noteTitle, content: self.noteContent,
                        colorHex: self.noteColor,
                        created: self.noteCreated ?? DateTimeUtil().now())
                )
            } catch {}
        }
        
        func setParamsAndLoadNote(noteDataSource: NoteDataSource, noteId: Int64?) {
            self.noteDataSource = noteDataSource
            Task {
                await self.loadNoteIfExists(id: noteId)
            }
        }
    }
}
