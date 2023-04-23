package com.example.notesapp.data.note

import com.example.NoteDatabase
import com.example.notesapp.domain.note.Note
import com.example.notesapp.domain.note.NoteDataSource
import com.example.notesapp.domain.time.DateTimeUtil

class SqlDelightNoteDataSource(db: NoteDatabase) : NoteDataSource {

    private val queries = db.noteQueries

    override suspend fun insertNote(note: Note) {
        queries.createNote(
            id = note.id,
            title = note.title,
            content = note.content,
            colorHex = note.colorHex,
            created = DateTimeUtil.toEpochMillis(note.created)
        )
    }

    override suspend fun getNoteById(id: Long): Note? =
        queries.getNoteById(id).executeAsOneOrNull()?.toNote()

    override suspend fun getAllNotes(): List<Note> =
        queries.getAllNotes().executeAsList().map { it.toNote() }

    override suspend fun deleteNoteById(id: Long) = queries.deleteNoteById(id)
}