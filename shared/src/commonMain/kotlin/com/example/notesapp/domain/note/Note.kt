package com.example.notesapp.domain.note

import com.example.notesapp.presentation.COLOR_1_HEX
import com.example.notesapp.presentation.COLOR_2_HEX
import com.example.notesapp.presentation.COLOR_3_HEX
import com.example.notesapp.presentation.COLOR_4_HEX
import kotlinx.datetime.LocalDateTime

data class Note (
    val id: Long?,
    val title: String,
    val content: String,
    val colorHex: Long,
    val created: LocalDateTime
) {
    companion object {
        private val colors = listOf(COLOR_1_HEX, COLOR_2_HEX, COLOR_3_HEX, COLOR_4_HEX)

        fun generateRandomColor() = colors.random()
    }
}