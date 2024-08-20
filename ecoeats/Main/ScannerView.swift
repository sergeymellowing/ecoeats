//
//  ScannerView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/20/24.
//

import SwiftUI

struct ScannerView: View {
    @EnvironmentObject var appController: AppController
    @State var torchIsOn: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            CodeScannerView(codeTypes: [.qr], scanMode: .once, isTorchOn: $torchIsOn, completion: handleScan)
                .border(Color.blue)
            
            Spacer()
            
            Button(action: { appController.signOut() }) {
                Text("Sign out")
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
        
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            print("success")
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
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
//            notificationController.setNotification(text: error.localizedDescription, type: .error)
        }
    }
}

#Preview {
    ScannerView()
}
