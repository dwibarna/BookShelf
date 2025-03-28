//
//  ContentView.swift
//  BookShelf
//
//  Created by Dwi Aji Sobarna on 28/03/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.dateAdded, order: .reverse)]
    )
    var books: FetchedResults<LibraryBook>

    var body: some View {
        NavigationView {
            VStack {
                if books.isEmpty {
                    Text("Belum ada buku")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                Text(book.title ?? "Tanpa Judul")
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(book.title ?? "Tanpa Judul")
                                        .font(.headline)
                                    Text("by \(book.author ?? "-")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text(book.isRead ? "✅ Sudah Dibaca" : "📘 Belum Dibaca")
                                        .font(.caption)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("BookShelf")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
        }

    }

    private func addItem() {
        withAnimation {
            let newBook = LibraryBook(context: viewContext)
            newBook.title = "Buku Baru"
            newBook.author = "Anonim"
            newBook.isRead = false
            newBook.dateAdded = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    let context = PersistenceController.preview.container.viewContext
    return ContentView()
        .environment(\.managedObjectContext, context)
}

