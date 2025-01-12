//
//  OnboardingStep1.swift
//  ecoeats
//
//  Created by Sergey Li on 9/20/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isAppOnboarded") private var isAppOnboarded = Defaults.isAppOnboarded
    @EnvironmentObject var appController: AppController
    let index: Int
    @Binding var currentTabIndex: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("onboarding-bg\(index)")
                .resizable()
                .scaledToFit()
                .frame(width: 393, height: 558)
            
            VStack {
                Text(title)
                    .foregroundColor(.green100)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(.green900)
                    .cornerRadius(100)
                    .padding(.bottom, 40)
                    .padding(.top, 20)
                
                Image("onboarding\(index)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 247, height: 238)
                    .padding(.bottom, 40)
                
                description
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .lineSpacing(7)
                    .multilineTextAlignment(index == 4 ? .leading : .center)
                    .padding(.bottom, 30)
                
                Button(action: {
                    isAppOnboarded = true
                    self.appController.getCurrentAuthSession()
                }) {
                    Text("건너뛰기")
                        .font(.system(size: 14))
                        .underline()
                        .foregroundColor(.white.opacity(index == 4 ? 0 : 0.3))
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        if self.currentTabIndex == 4 {
                            isAppOnboarded = true
                            self.appController.getCurrentAuthSession()
                        } else {
                            self.currentTabIndex = self.currentTabIndex + 1
                        }
                    }
                }) {
                    Group {
                        if appController.isLoading {
                            ProgressView().tint(.black)
                        } else {
                            Text(index == 4 ? "시작하기" : "다음")
                        }
                    }
                        .font(.system(size: 18))
                        .foregroundColor(index == 4 ? .black : .green100)
                        .frame(width: index == 4 ? (UIScreen.main.bounds.width - 40) : 140, height: 58)
                        .overlay(
                            index != 4 ?
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(.green100, lineWidth: 1)
                            : nil
                        )
                        .background(index == 4 ? .green100 : .clear)
                        .cornerRadius(14)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 15)
                .padding(.horizontal, 20)
                
            }
        }
    }
    
    var title: String {
        switch index {
        case 0: "매일의 할인가"
        case 1: "환경보호의 시작"
        case 2: "착한 맛집의 발견"
        case 3: "재빠르게 할인 받기"
        case 4: "매일의 기회 노리기"
        default: "매일의 할인가"
        }
    }
    
    @ViewBuilder
    var description: some View {
        switch index {
        case 0: 
            Group {
                Text("맛있는 음식을  ") +
                Text("반값에 득템\n").bold().foregroundColor(.yellow200) + 
                Text("당신 근처에서 기다리고 있어요!")
            }
        case 1:
            Group {
                Text("낭비되는 음식만 줄여도\n") +
                Text("탄소배출 ").bold().foregroundColor(.yellow200) +
                Text("을 줄일 수 있어요!")
            }
        case 2:
            Group {
                Text("ECO EATS로 환경보호를 실천하는\n") +
                Text("착한 주변 맛집 ").bold().foregroundColor(.yellow200) +
                Text("을 찾아보세요!")
            }
        case 3:
            Group {
                Text("원하는 맛집의 메뉴가 있다면\n이제부터는 ") +
                Text("선착순!\n앱의 QR ").bold().foregroundColor(.yellow200) +
                Text("을 보여주고 할인을 받으세요!")
            }
        case 4:
            Group {
                Text("원하는 메뉴가 모두 소진되었나요?\n해당 가게를 ") +
                Text("팔로우 ").bold().foregroundColor(.yellow200) +
                Text("하고\n") +
                Text("할인 소식 ").bold().foregroundColor(.yellow200) +
                Text("을 먼저 받으세요!")
            }
        default:
            Text("Something went wrong ...")
        }
    }
}

//#Preview {
//    OnboardingStep1()
//}
