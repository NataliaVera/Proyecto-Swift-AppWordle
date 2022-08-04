//
//  BannerView.swift
//  AppWordle
//
//  Created by Desarrollador1 on 4/08/22.
//

import SwiftUI

struct BannerView: View {
    private let bannerType: BannerType
    @State private var isOnScreen: Bool = false
    
    init(bannerType : BannerType){
        self.bannerType = bannerType
    }
    
    var body: some View {
        VStack{
            // que vista se debe mostrar al usuario
            switch bannerType {
            case .error(let errorMessage):
                Text(errorMessage)
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                    .cornerRadius(12)
            case .successes:
                Text("¡Has Ganado!").foregroundColor(.white)
                    .padding()
                    .background(.green)
                    .cornerRadius(12)
            }
            Spacer()
        }
        .padding(.horizontal, 12)
        .frame(height: 40)
        .animation(.easeOut(duration: 0.3), value: isOnScreen)
        .offset(y: isOnScreen ? -350 : -500)
        .onAppear{
            isOnScreen = true
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(bannerType: .successes)
    }
}
