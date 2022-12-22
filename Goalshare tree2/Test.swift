//
//  Test.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 12/21/22.
//

import SwiftUI

struct Test: View {
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            .navigationBarTitle("Items")
            .navigationBarItems(trailing:
                Button(action: {
                    self.items.insert("New Item", at: 0)
                }) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}
struct TestPreview: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
