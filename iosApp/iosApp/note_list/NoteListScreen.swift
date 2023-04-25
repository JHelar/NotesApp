//
//  NoteListScreen.swift
//  iosApp
//
//  Created by John Larsson on 2023-04-24.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct NoteListScreen: View {
    private var noteDataSource: NoteDataSource
    @StateObject var viewModel = NoteListViewModel(noteDataSource: nil)
    
    @State private var isNoteSelected = false
    @State private var selectedNoteId: Int64? = nil
    
    init(noteDataSource: NoteDataSource) {
        self.noteDataSource = noteDataSource
    }
    
    var body: some View {
        VStack {
            ZStack {
                NavigationLink(
                    destination: NoteDetailScreen(
                        noteDataSource: self.noteDataSource,
                    noteId: selectedNoteId),
                            
                    isActive: $isNoteSelected) {
                    EmptyView()
                }.hidden()
                
                SearchTextField(
                    searchText: $viewModel.searchText
                )
                .frame(maxWidth: .infinity, minHeight: 40)
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Notes").font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {
                        NoteDetailScreen(noteDataSource: noteDataSource, noteId: selectedNoteId)
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                }
            }
            
            List {
                ForEach(viewModel.filterNotes, id: \.self.id) { note in
                    Button(action: {
                        isNoteSelected = true
                        selectedNoteId = note.id?.int64Value
                    }) {
                        NoteItem(note: note, onDeleteClick: {
                            Task {
                                await viewModel.deleteNoteById(id: note.id?.int64Value)
                            }
                        })
                    }
                    .background(Color(hex: note.colorHex))
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .onAppear {
                Task {
                    await viewModel.loadNotes()
                }
            }
        }
        .onAppear {
            viewModel.setNoteDataSource(noteDataSource: noteDataSource)
        }
    }
}

struct NoteListScreen_Previews: PreviewProvider {
    static var previews: some View {
        //NoteListScreen()
        EmptyView()
    }
}
