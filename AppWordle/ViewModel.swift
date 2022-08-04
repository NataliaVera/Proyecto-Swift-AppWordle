//
//  ViewModel.swift
//  AppWordle
//
//  Created by Desarrollador1 on 4/08/22.
//

import Foundation
import UIKit


enum BannerType{
    case error(String)
    case successes
}

//nos sirve para saber en que fila estamos y saber que letras se estan ingresando
final class ViewModel: ObservableObject{
    var numOfRow: Int = 0
    @Published var bannerType: BannerType? = nil
    @Published var result: String = "REINA"
    @Published var word: [LetterModel] = [] // @Published se usa cuando una clase implementa una interfaz ObservableObject que significa que será observado desde una vista
    @Published var gameData: [[LetterModel]] = [
        [.init(""), .init(""),.init(""),.init(""),.init("")],
        [.init(""), .init(""),.init(""),.init(""),.init("")],
        [.init(""), .init(""),.init(""),.init(""),.init("")],
        [.init(""), .init(""),.init(""),.init(""),.init("")],
        [.init(""), .init(""),.init(""),.init(""),.init("")],
        [.init(""), .init(""),.init(""),.init(""),.init("")]
    ]
    
    func addNewLetter(letterModel: LetterModel){
        bannerType = nil
        if letterModel.name == "🚀"{
            tapOnSend()
            return
        }
        if letterModel.name == "🗑"{
            tapOnRemove()
            return
        }
        if word.count < 5{
            //se almacena la letra en la casilla correcta
            let letter = LetterModel(letterModel.name)
            word.append(letter)
            gameData[numOfRow][word.count-1] = letter
        }
    }
    
    private func tapOnSend(){
        guard word.count == 5 else{
            print("Añade más letras")
            bannerType = .error("¡Añade más letras!")
            return
        }// compruebo que la palabra que me escribe el usuario tiene 5 letras
        
        let finalStringWord = word.map{ $0.name}.joined() //junta todas las palabras de la fila y pregunta si la palabra es correcta o no
        
        if wordIsReal(word: finalStringWord){
            print("Palabra correcta")
            bannerType = .successes
            
            for(index, _) in word.enumerated(){
                let currentCharacter = word[index].name
                var status: Status
                
                if result.contains(where: {String($0) == currentCharacter}){
                    status = .appear
                    print("\(currentCharacter) .appear")
                    
                    if currentCharacter == String(result[result.index(result.startIndex, offsetBy: index)]){
                        status = .match
                        print("\(currentCharacter) .match")
                    }//comprueba si la letra aparece en la palabra
                } else {
                    status = .dontAppear
                    print("\(currentCharacter) .don'tAppear")
                }
                
                //Update GameView
                var updateGameBoardCell = gameData[numOfRow][index]
                updateGameBoardCell.status = status
                gameData[numOfRow][index] = updateGameBoardCell
                
                //Update KeyboardView
                let indexToUpdate = keyboardData.firstIndex(where: {$0.name == word[index].name})
                var keyboardKey = keyboardData[indexToUpdate!]
                if keyboardKey.status != .match{
                    keyboardKey.status = status
                    keyboardData[indexToUpdate!] = keyboardKey
                }
            }
            //Clean word and move to the new row
            word = [] // resetea el arreglo para pasar a la siguiente linea
            numOfRow += 1
        } else {
            print("Palabra incorrecta")
            bannerType = .error("Palabra Incorrecta. Vuelve a intentarlo")
        }
    }
    
    func hasError(index: Int) -> Bool{
        guard let bannerType = bannerType else {
            return false 
        }
        //comprueba si tiene un error y si el indice que le llega como parametro sea igual a la fila actual
        switch bannerType {
        case .error(_):
            return index == numOfRow
        case .successes:
            return false
        }

    }
    
    private func tapOnRemove(){
        guard word.count > 0 else{
            return
        }
        gameData[numOfRow][word.count-1] = .init("")
        word.removeLast()
        
    }
    
    private func wordIsReal(word: String) -> Bool{
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: word)//retorna true o false si existe o no la palabra por el diccionario que esta descargado desde el cell
    }
}


