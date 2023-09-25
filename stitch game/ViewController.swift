//
//  ViewController.swift
//  stitch game
//
//  Created by Alina Floccus on 20.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var arrayImage = ["stitch1", "stitch2", "stitchbow", "stitchcry", "stitchfrog", "stitchhappy", "stitchhawai", "stitchlilo", "stitch1", "stitch2", "stitchbow", "stitchcry", "stitchfrog", "stitchhappy", "stitchhawai", "stitchlilo"]
    
    var isOpened = false  // для проверки состояния кнопки
    var previousMove = 0  // для того, чтобы определить переменную под кнопку
    var moves: [Int] = Array(repeating: 0, count: 16)  // чтобы потом вывести модалку
    
    //   var previosImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearGame()
    }
    
    func clearGame() {
        moves = Array(repeating: 0, count: 16)
        isOpened = false
        for tag in 1...16 {
            let button = view.viewWithTag(tag) as! UIButton
            button.setBackgroundImage(nil, for: .normal)
        }
        arrayImage.shuffle()
    }
    
    @IBAction func buttongame(_ buttonSender: UIButton) {
        print(buttonSender.tag)
        print(isOpened)
        
        // есть ли в массиве moves значение
        if moves[buttonSender.tag-1] == 0 {
            
            buttonSender.setBackgroundImage(UIImage(named: arrayImage[buttonSender.tag-1]), for: .normal)
            print("была поставлена картинка \(arrayImage[buttonSender.tag-1])")
            
            
            if isOpened {
                
                // правило, чтобы не нажималась одна и таже кнопка 2 раза
                if previousMove == buttonSender.tag {
                    print("нельзя нажимать на одну и туже кнопку")
                    return
                }
                // определяем пред. кнопку
                let previous = view.viewWithTag(previousMove) as! UIButton
                
                print("предыдущая кнопка была \(previousMove)")
                print("там была картинка \(arrayImage[previous.tag-1])")
                
                // записываем картинки из пред. двух кнопок
                let previousImage = arrayImage[previous.tag-1]
                let secondImage = arrayImage[buttonSender.tag-1]
                
                
                // сравниваем картинки
                if previousImage == secondImage {
                    print("УСПЕХ")
                    moves[buttonSender.tag-1] = 1
                    moves[previous.tag-1] = 1
                    print(moves)
                } else {
                    // закрываю изображения
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        buttonSender.setBackgroundImage(nil, for: .normal)
                        previous.setBackgroundImage(nil, for: .normal)
                    }
                }
                // ___ завершилось сравнение картинок
            } else {
                previousMove = buttonSender.tag
                print("previousMove was \(previousMove)")
            }
            
            isOpened = !isOpened
            
        }
       
        // хочу вывести модалку в конце игры
        for move in moves {
            if (move == 0) {
                return
            }
        }
        let alert = UIAlertController(title: "Игра закончена!", message:"", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: { [self] action in
            self.clearGame()
            print("теперь moves \(moves)")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}
