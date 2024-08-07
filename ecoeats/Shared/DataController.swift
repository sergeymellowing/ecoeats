//
//  DataController.swift
//  ecoeats
//
//  Created by 이준녕 on 8/7/24.
//

import SwiftUI

class DataController: ObservableObject {
    @Published var stores: [Store] = []
    
    func getData() {
        self.stores = DummyData.storeList
    }
}
