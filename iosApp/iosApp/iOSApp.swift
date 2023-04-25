import SwiftUI
import shared

@main
struct iOSApp: App {
    private let databaseModule = DatabaseModule()
    
	var body: some Scene {
		WindowGroup {
            NavigationView {
                NoteListScreen(noteDataSource: self.databaseModule.noteDataSource)
            }.accentColor(.black)
		}
	}
}
