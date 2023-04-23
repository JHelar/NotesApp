package com.example.notesapp

import app.cash.sqldelight.db.SqlDriver
import com.example.NoteDatabase

expect class DriverFactory {
    fun createDriver(): SqlDriver
}

fun createDatabase(driverFactory: DriverFactory) {
    val driver = driverFactory.createDriver()
    val database = NoteDatabase(driver)
}