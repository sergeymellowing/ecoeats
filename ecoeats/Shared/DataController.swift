//
//  DataController.swift
//  ecoeats
//
//  Created by 이준녕 on 8/7/24.
//

import SwiftUI
import Amplify

class DataController: ObservableObject {
    @Published var stores: [Store] = []
    
//    func getData() {
//        self.stores = DummyData.storeList
//    }
    
    func getStores(completion: @escaping (String?) -> Void) {
        let request = RESTRequest(apiName: "storeApi",
                                  path: "/stores/get")
        
        Task {
            do {
                let data = try await Amplify.API.get(request: request)
                let str = String(decoding: data, as: UTF8.self)
                print("Get Store success \(str)")
                print(data.description)
                if let response: GetStoresResponse = decodeJson(data: data) {
                    await MainActor.run {
                        self.stores = response.data
                    }
                    completion(response.data.isEmpty ?
                        "GetStoresResponse error" :
                            nil)
                } else {
                    completion("Error: Invalid Json")
                }
            } catch {
                print("Get Store failure \(error)")
                completion(error.localizedDescription)
            }
        }
    }
    
    func getStore(id: String, completion: @escaping (String?) -> Void) {
        let queryParameters = ["id": id]
        let request = RESTRequest(apiName: "storeApi",
                                  path: "/stores/get/\(id)",
                                  queryParameters: queryParameters)
        
        Task {
            do {
                let data = try await Amplify.API.get(request: request)
                let str = String(decoding: data, as: UTF8.self)
                print("Get Store success \(str)")
                print(data.description)
//                self.stores.append(<#T##newElement: Store##Store#>)
                completion(nil)
//                if let response: GetIotDeviceResponse = decodeJson(data: data) {
//                    // todo(florian) for now we only return the first device in list
//                    completion(response.data.isEmpty ?
//                        .failure(ApiError.notFound) :
//                            .success(response.data.first!))
//                } else {
//                    completion(.failure(ApiError.invalidJSON))
//                }
            } catch {
                print("Get Store failure \(error)")
                completion(error.localizedDescription)
            }
        }
    }
}
