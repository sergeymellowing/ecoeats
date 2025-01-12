//
//  ScannerView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/20/24.
//

import SwiftUI

struct ScannerView: View {
    @EnvironmentObject var appController: AppController
//    @EnvironmentObject var dataController: DataController
    @State var torchIsOn: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 100)
                
                CodeScannerView(codeTypes: [.qr], scanMode: .once, isTorchOn: $torchIsOn, completion: handleScan)
                    .border(Color.white)
                
                Spacer(minLength: 100)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("QR code was successfully scanned!"))
                    }
                
//                Button(action: { appController.signOut() }) {
//                    Text("Sign out")
//                }
//                .buttonStyle(.bordered)
                
                Spacer()
            }
            .padding(.horizontal, 22)
            .background(Color.greenMain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("ECO EATS")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .navigationBarItems(
                trailing: Button(action: {
                    appController.signOut()
                }) {
                    Image(systemName: "door.left.hand.open")
                        .foregroundColor(.white)
                }
            )
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            print("success")
            let data = result.string.components(separatedBy: "//")
            if data.count > 2 {
                let request = ScanQRRequest(userId: data[0], storeId: data[1], itemId: data[2])

                DataController().scanQR(request: request) { error in
                    if let error {
                        print(error)
                    } else {
                        self.showAlert = true
                    }
                }
    //            userManager.createCheckInByToken(token: result.string) { error, business, id in
    //                if let business {
    //                    self.businessName = business.businessName ?? ""
    //                    self.id = id ?? ""
    //                    self.image = business.images?.first?.map({ $0.file?.url ?? "" })
    //                    openResult = true
    //                }
    //                if let error {
    //                    notificationController.setNotification(text: error, type: .error)
    //                }
    //            }
            }

        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
//            notificationController.setNotification(text: error.localizedDescription, type: .error)
        }
    }
}

#Preview {
    ScannerView()
}
