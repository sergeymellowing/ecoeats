//
//  ItemDetails.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI

struct ItemDetails: View {
    let item: Item
    var body: some View {
        Text(item.itemName)
    }
}

//#Preview {
//    ItemDetails()
//}
