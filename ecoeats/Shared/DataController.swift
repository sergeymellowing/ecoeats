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
    
    func getStores(lookAround: Bool, completion: @escaping (String?) -> Void) {
        if lookAround {
            let url = URL(string: "\(Const.domain)stores/get")!
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8)!)
                do {
                    if let response: GetStoresResponse = decodeJson(data: data) {
                        //                    await MainActor.run {
                        DispatchQueue.main.async {
                            self.stores = response.data
                        }
                        
                        //                    }
                        completion(response.data.isEmpty ?
                                   "GetStoresResponse error" :
                                    nil)
                    } else {
                        completion("Error: Invalid Json")
                    }
                }
            }
            
            task.resume()
        } else {
            let request = RESTRequest(apiName: "storeApi",
                                      path: "/stores/get")
            
            //        let request = RESTRequest(apiName: "storeApi",
            //                    path: "/stores/get",
            //                    headers: [:])
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
                    print("Get Store failure: \(error)")
                    completion(error.localizedDescription)
                }
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
    
    func checkQR(storeId: String, itemId: String, userId: String, completion: @escaping (String?) -> Void) {
        let queryParameters = ["userId": userId, "storeId": storeId, "itemId": itemId]
        let request = RESTRequest(apiName: "storeApi",
                                  path: "/qr/check/",
                                  queryParameters: queryParameters)
        
        Task {
            do {
                let data = try await Amplify.API.get(request: request)
                let str = String(decoding: data, as: UTF8.self)
                print("Check QR: \(str)")
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
                print("Check QR failure \(error)")
                completion(error.localizedDescription)
            }
        }
    }
    
    func scanQR(request: ScanQRRequest, completion: @escaping (String?) -> Void) {
        if let requestBody = encodeJson(data: request) {
            let scanRequest = RESTRequest(apiName: Const.API,
                                      path: "/qr/scan",
                                      body: requestBody)
            print("scanning: \(request)")
            
            Task {
                do {
                    let data = try await Amplify.API.post(request: scanRequest)
                    let str = String(decoding: data, as: UTF8.self)
                    print("Scan QR success \(str)")
                    //                    if let response: GroupResponse = decodeJson(data: data) {
                    //                        completion(.success(response))
                    //                    } else {
                    //                        completion(.failure(ApiError.invalidJSON))
                    //                    }
                    completion(nil)
                } catch let error as APIError {
                    print("Scan QR code failed \(error)")
                    completion(error.localizedDescription)
                    //                    completion(.failure(ApiError.generalError))
                }
            }
        }
    }
}
