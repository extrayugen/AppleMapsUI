//
//  BottomSheetMainView.swift
//  AppleMapsUI
//
//  Created by Djallil Elkebir on 2023-01-07.
//

import SwiftUI

struct BottomSheetMainView: View {
    @Binding var searchText: String
    var body: some View {
        List {
            HStack {
                SearchBarView(text: $searchText)
                Image("animoji")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding()
            Section {
                HStack (alignment: .top, spacing: 20){
                    HorizontalButton(icon: "house.fill", title: "Home", showAdd: true) {
                            print("Home")
                    }
                    HorizontalButton(icon: "briefcase.fill", title: "Work", showAdd: true) {
                            print("Work")
                    }
                    HorizontalButton(icon: "plus", title: "Add", showAdd: false) {
                            print("Add")
                    }
                    Spacer()
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(12)
            } header: {
                HStack {
                    Text("Favorites")
                    Spacer()
                    Button(action:{}) {
                        Text("More")
                            .font(.callout)
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            Section {
                VStack {
                    ForEach(HorizontalSearchModel.sampleData) { search in
                        HorizontalSearchListRow(recentSearch: search)
                        dividersWithHiddenLast(search: search, searches: HorizontalSearchModel.sampleData)
                    }
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(12)
            } header: {
                HStack {
                    Text("Recents")
                    Spacer()
                    Button(action:{}) {
                        Text("More")
                            .font(.callout)
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .listRowBackground(Color.clear)
        .background(.thinMaterial)
    }
    
    @ViewBuilder
    private func dividersWithHiddenLast(search: HorizontalSearchModel, searches: [HorizontalSearchModel]) -> some View {
        if let lastID = searches.last?.id, search.id == lastID {
            EmptyView()
        } else {
            Divider()
        }
    }
}

struct BottomSheetMainView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetMainView(searchText: .constant(""))
    }
}
