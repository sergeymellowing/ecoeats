//
//  ItemDetails.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI
//import QRCode
import CoreImage.CIFilterBuiltins


struct ItemDetails: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var appController: AppController
//    @State var qrcode: QRCode.Document? = nil
    @State var qrcode: UIImage? = nil
    @State var isLoading: Bool = false
    
    let item: Item
    let store: Store
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Spacer()
                
                Text(item.itemName)
                    .font(.headline)
                
                ZStack {
                    if isLoading {
                        ProgressView()
                    } else {
                        if let qrcode = qrcode {
//                            QRCodeDocumentUIView(document: qrcode)
//                                .onTapGesture {
//                                    withAnimation {
//                                        //                                    self.expired.toggle()
//                                    }
//                                }
                            Image(uiImage: qrcode)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                    }
                }
                .frame(width: geometry.size.height / 2.7, height: geometry.size.height / 2.7)
                .padding(7)
//                .background(Color.red.opacity(0.3))
                .cornerRadius(20)
                .padding(.bottom, 32)
                .onAppear {
                    setToken()
                }
                HStack {
                    (Text(item.discount.description) + Text( "%"))
                        .padding(.horizontal)
                        .padding(.vertical, 2)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(50)
                    (Text(item.quantity.description) + Text(" left"))
                        .padding(.horizontal)
                        .padding(.vertical, 2)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(50)
                }
                
                Spacer()
                
                Text(item.description)
                
                Text(Date().description)
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func setToken() {
        if let userId = appController.apiUser?.id {
            self.isLoading = true
            dataController.checkQR(storeId: store.id, itemId: item.id, userId: userId) { error in
                //        dataController.checkQR(storeId: "101", itemId: "101", userId: "user_id") { error in
                if let error {
                    print(error)
                    withAnimation {
                        self.isLoading = false
                    }
                } else {
                    let context = CIContext()
                    let filter = CIFilter.qrCodeGenerator()
                    self.qrcode = QRCodeGenerator().generateQRCode(from: store.id + "//" + item.id + "//" + userId)
//                    let qrcodeDoc: QRCode.Document = {
//                        let doc = QRCode.Document()
//                        doc.utf8String = store.id + "//" + item.id + "//" + userId
//                        doc.design.shape.onPixels = QRCode.PixelShape.Squircle(insetFraction: 0.1)
//                        doc.design.shape.eye = QRCode.EyeShape.Squircle()
//                        doc.errorCorrection = .high
//                        print("QR CODE: \(doc.utf8String)")
//                        //                    let image = UIImage(named: "LOGO")!
//                        
//                        // Centered square logo
//                        //                    doc.logoTemplate = QRCode.LogoTemplate(
//                        //                        image: image.cgImage!,
//                        //                        path: CGPath(rect: CGRect(x: 0.40, y: 0.40, width: 0.20, height: 0.20), transform: nil),
//                        //                        inset: 2
//                        //                    )
//                        
//                        return doc
//                    }()
//                    self.qrcode = qrcodeDoc
                    //            }
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        }
    }
}

//#Preview {
//    ItemDetails()
//}
