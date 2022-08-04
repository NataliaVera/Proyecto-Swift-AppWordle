//
//  GameView.swift
//  AppWordle
//
//  Created by Desarrollador1 on 4/08/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel:  ViewModel
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 20), spacing: 0), count: 5) //count -> numero de columnas
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8){
            ForEach(0...5, id: \.self){ index in
                ForEach(viewModel.gameData[index], id: \.id){ model in
                    //button -> para representar la celda
                    Button{
                        
                    }label: {
                        Text(model.name)
                            .font(.system(size: 40, weight: .bold))
                    }
                    .frame(width: 60, height: 60)
                    .foregroundColor(viewModel.hasError(index: index) ? .white : model.foregroundColor)
                    .background(viewModel.hasError(index: index) ? .red :model.backgroundColor)
                }
                
            }
        }
        .padding(.horizontal, 20)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: ViewModel())
    }
}
