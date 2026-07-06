//
//  OverlayDemo.swift
//  Magician
//
//

import SwiftUI

struct Banner: View {
    
    struct BannerDataModel {
        var title:String
        var titleAr:String=""
        
        var detail:String
        var type: BannerType
        var isArabic=false
        
    }
    
    enum BannerType {
        case info
        case warning
        case success
        case error
        
        var tintColor: Color {
            switch self {
            case .info:
                return .blue
            case .success:
                return .green
            case .warning:
                return .yellow
            case .error:
                return .red
            }
        }
        
        var sfSymbol: String {
            switch self {
            case .info:
                return "info.circle"
            case .success:
                return "checkmark.seal"
            case .warning:
                return "exclamationmark.octagon"
            case .error:
                return "xmark.octagon"
            }
        }
    }
    let data: BannerDataModel
    @Binding var show: Bool
    var body: some View {
        VStack {
            HStack {
                Image.init(systemName: data.type.sfSymbol)
                    .font(.system(size: 35))
                    .padding(.bottom,8)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(LocalizedStringKey(data.isArabic ? data.titleAr : data.title))
//                        .font(.system(size: 18))
//                        .bold()
                    Text(LocalizedStringKey(data.detail))
                        .font(Font.system(size: 16, weight: Font.Weight.light, design: Font.Design.default))
//                        .lineLimit(3)
                }
                .padding()
                .padding(.top,-8)
                .padding(.bottom,8)
                Spacer()
            }
            .foregroundColor(Color.white)
//            .padding(.top,30)
//            .padding(12)
            .padding(.horizontal)
//            .padding(.vertical,12)
            .padding(.top,getSafeArea()?.top)
            //            .padding(.horizontal)
            .background(data.type.tintColor)
            .cornerRadius(8)
            
            Spacer()
        }
//        .padding()
//        .padding(.horizontal)
        .edgesIgnoringSafeArea(.top)
        
        .animation(.easeInOut)
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onTapGesture {
            withAnimation {
                self.show = false
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.show = false
                }
            }
        })
    }
}

struct Toasts: View {
    
    struct ToastDataModel {
        var title:String
        var image:String
        
    }
    let dataModel: ToastDataModel
    @Binding var show: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
//                Image(systemName: dataModel.image)
//                Text(dataModel.title)
                
                Text(dataModel.title)
                Image(systemName: dataModel.image)
                
            }.font(.headline)
            .foregroundColor(.primary)
            .padding([.top,.bottom],20)
            .padding([.leading,.trailing],40)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(Capsule())
        }
        .frame(width: UIScreen.main.bounds.width / 1.25)
        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .onTapGesture {
            withAnimation {
                self.show = false
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.show = false
                }
            }
        })
    }
}

struct OverlayDemo: View {
    @State private var showOverlay = false
    @State private var showToastOverlay = false
    
    var body: some View {
        VStack {
            Text("Show Banner!")
                .onTapGesture {
                    withAnimation {
                        showOverlay = true
                    }
                }
            
            Text("Show Toast!")
                .onTapGesture {
                    withAnimation {
                        showToastOverlay = true
                    }
                }
        }
        .overlay(overlayView: Banner.init(data: Banner.BannerDataModel(title: "Title", detail: "your message", type: .success), show: $showOverlay)
                 , show: $showOverlay)
        .overlay(overlayView: Toasts.init(dataModel: Toasts.ToastDataModel.init(title: "toast message", image: "checkmark"), show: $showToastOverlay)
                 , show: $showToastOverlay)
        
    }
}

struct Overlay<T: View>: ViewModifier {
    
    @Binding var show: Bool
    let overlayView: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                overlayView
            }
        }
//        .environment(\.layoutDirection, .rightToLeft)

    }
}

extension View {
    func overlay<T: View>( overlayView: T, show: Binding<Bool>) -> some View {
        self.modifier(Overlay.init(show: show, overlayView: overlayView))
    }
}

struct OverlayDemo_Previews: PreviewProvider {
    static var previews: some View {
        OverlayDemo()
    }
}
