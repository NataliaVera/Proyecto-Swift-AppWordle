//
//  ContentView.swift
//  AppWordle
//
//  Created by Desarrollador1 on 4/08/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        //unir las dos vistas model y game
        ZStack{
            VStack(spacing: 40){
                GameView(viewModel: viewModel)
                KeyboardView(viewModel: viewModel)
            }
            if viewModel.bannerType != nil{
                BannerView(bannerType: viewModel.bannerType!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
