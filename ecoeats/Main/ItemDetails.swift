//
//  ItemDetails.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI
//import QRCode
import CoreImage.CIFilterBuiltins
import CachedAsyncImage


struct ItemDetails: View {
    //    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var appController: AppController
    //    @State var qrcode: QRCode.Document? = nil
    @State var qrcode: UIImage? = nil
    @State var isLoading: Bool = false
    @State var offset: CGFloat = 0
    @State var qrCodeMode: Bool = false
    @Binding var selectedItem: Item?
    
    let store: Store
    
    var body: some View {
        if let item = selectedItem {
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 20) {
                    Text(item.itemName)
                        .font(.system(size: 24, weight: .bold))
                    // MARK: Half image and padding
                        .padding(.top, 130/2 + 32)
                    
                    Text(item.itemName)
                        .font(.system(size: 14))
                        .foregroundColor(.gray800)
                    
                    HStack {
                        Spacer()
                        ItemElement(image: "ic-discount-arrow", text: item.discount.description + " %")
                        ItemElement(image: "ic-quantity", text: item.quantity.description + "개")
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("이용 전 유의사항")
                            .font(.system(size: 16, weight: .semibold))
                        
                        
                        let hint: String =
"""
• 메뉴당 당일 구매가능 횟수는 1인 1개 입니다.
• 아래의 사용하기 버튼을 누르면 QR이 활성화 됩니다.
• 사용된 QR은 재사용, 재발급이 불가합니다.
• QR 코드를 결제 전 직원에게 보여주세요.
"""
                        
                        Text(hint)
                            .font(.system(size: 14))
                            .foregroundColor(.gray800)
                            .lineSpacing(7)
                            .multilineTextAlignment(.leading)
                        
                    }
                    
                    Divider()
                    
                    
                        if !qrCodeMode {
                            ZStack(alignment: .topLeading) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 160)
                                    .opacity(0.1)
                                    .padding(.horizontal, 10)
                                
                                VStack(alignment: .trailing) {
                                    HStack {
                                        Text("정상가: ")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black)
                                        
                                        Text(item.price.description + "원")
                                            .strikethrough()
                                            .font(.system(size: 30, weight: .semibold))
                                            .foregroundColor(.gray800.opacity(0.7))
                                    }
                                    
                                    HStack {
                                        Text("Eco eats : ")
                                            .font(.system(size: 14))
                                            .foregroundColor(.greenMain)
                                        
                                        Text((item.price - Float(item.discount) / Float(100) * item.price).description + "원")
                                            .font(.system(size: 34, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Button(action: {
                                        withAnimation {
                                            self.qrCodeMode = true
                                        }
                                    }) {
                                        Text("사용하기")
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 64)
                                            .background(Color.greenMain)
                                            .cornerRadius(10)
                                    }
                                }
                                .padding(.bottom, 40)
                            }
                        } else {
                            HStack(alignment: .bottom) {
                                VStack(alignment: .center, spacing: 10) {
                                    ZStack {
                                        if isLoading {
                                            ProgressView()
                                        } else {
                                            if let qrcode = qrcode {
                                                Image(uiImage: qrcode)
                                                    .interpolation(.none)
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                        }
                                    }
                                    .frame(width: 100, height: 100)
                           
                                    .padding(.top, 30)
                                    .onAppear {
                                        setToken()
                                    }
                                    
                                    Text("남은 시간 " + Date().description)
                                        .font(.system(size: 12, weight: .semibold))
                                        .lineLimit(1)
                                        .opacity(0.001)
                                }
                                .padding(.horizontal, 30)
                                .padding(.bottom, 50)
                                .background(Color.white)
                                .cornerRadius(26, corners: [.topLeft, .topRight])
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    HStack(alignment: .bottom) {
                                        Text("정상가: ")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black)
                                        
                                        Text(item.price.description + "원")
                                            .strikethrough()
                                            .font(.system(size: 24, weight: .semibold))
                                            .foregroundColor(.gray800.opacity(0.7))
                                    }
                                    
                                    HStack(alignment: .bottom) {
                                        Text("Eco eats : ")
                                            .font(.system(size: 14))
                                            .foregroundColor(.greenMain)
                                        
                                        Text((item.price - Float(item.discount) / Float(100) * item.price).description + "원")
                                            .font(.system(size: 26, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.bottom, 50)
                            }
                            
                        }
                        
                        
                    
                    
                    
                    //                ZStack {
                    //                    if isLoading {
                    //                        ProgressView()
                    //                    } else {
                    //                        if let qrcode = qrcode {
                    //                            //                            QRCodeDocumentUIView(document: qrcode)
                    //                            //                                .onTapGesture {
                    //                            //                                    withAnimation {
                    //                            //                                        //                                    self.expired.toggle()
                    //                            //                                    }
                    //                            //                                }
                    //                            Image(uiImage: qrcode)
                    //                                .interpolation(.none)
                    //                                .resizable()
                    //                                .scaledToFit()
                    //                                .frame(width: 200, height: 200)
                    //                        }
                    //                    }
                    //                }
                    //                .padding(7)
                    //                //                .background(Color.red.opacity(0.3))
                    //                .cornerRadius(20)
                    //                .padding(.bottom, 32)
                    //                .onAppear {
                    //                    setToken()
                    //                }
                    //                HStack {
                    //                    (Text(item.discount.description) + Text( "%"))
                    //                        .padding(.horizontal)
                    //                        .padding(.vertical, 2)
                    //                        .background(.gray.opacity(0.3))
                    //                        .cornerRadius(50)
                    //                    (Text(item.quantity.description) + Text(" left"))
                    //                        .padding(.horizontal)
                    //                        .padding(.vertical, 2)
                    //                        .background(.gray.opacity(0.3))
                    //                        .cornerRadius(50)
                    //                }
                    //
                    //                Spacer()
                    //
                    //                Text(item.description)
                    //
                    //                Text(Date().description)
                    //                Spacer()
                    //
                }
                .padding(.horizontal, 20)
                .background(Color.gray100)
                .frame(maxWidth: .infinity)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .overlay(alignment: .top) {
                    CachedAsyncImage(
                        url: "https://picsum.photos/200/300",
                        placeholder: { progress in
                            // Create any view for placeholder (optional).
                            ZStack {
                                ProgressView() {
                                    VStack {
                                        Text("\(progress) %")
                                    }
                                }
                            }
                        },
                        image: {
                            // Customize image.
                            Image(uiImage: $0)
                                .resizable()
                                .scaledToFill()
                        }
                    )
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .offset(y: -130/2)
                }
                
            }
            .ignoresSafeArea()
            .offset(y: self.offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.height > 0 {
                            self.offset = gesture.translation.height
                        }
                    }
                    .onEnded { gesture in
                        if gesture.translation.height > 100 {
                            withAnimation {
                                self.selectedItem = nil
                            }
                            
                        } else {
                            withAnimation {
                                self.offset = 0
                            }
                        }
                        
                        
                    }
            )
        }
    }
    
    private func setToken() {
        if let userId = appController.apiUser?.id, let item = selectedItem {
            self.isLoading = true
            
            DataController().checkQR(storeId: store.id, itemId: item.id, userId: userId) { error in
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
