package com.example.notesapp

class Greeting {
    private val platform: Platform = getPlatform()

    fun greet(): String {
        return "Hello from the shared greeting, ${platform.name}!"
    }
}