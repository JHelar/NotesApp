package com.example.notesapp.domain.note

import com.example.notesapp.domain.time.DateTimeUtil

class SearchNotes {
    fun execute(notes: List<Note>, query: String): List<Note> {
        if(query.isBlank()) {
            return notes
        }

        return notes.filter {
            listOf(it.title, it.content).any { str -> str.trim().lowercase().contains(query.lowercase()) }
        }.sortedByDescending { DateTimeUtil.toEpochMillis(it.created) }
    }
}