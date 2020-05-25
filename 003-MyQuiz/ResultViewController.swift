//
//  ResultViewController.swift
//  003-MyQuiz
//
//  Created by Takatoshi Miura on 2020/05/25.
//  Copyright © 2020 Takatoshi Miura. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //問題数を取得する
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        //正解数を取得する
        var correctCount:Int = 0
        //正解数を計算する
        for questionData in QuestionDataManager.sharedInstance.questionDataArray{
            if questionData.isCorrect(){
                //正解数を増やす
                correctCount += 1
            }
        }
        //正解率を計算する
        let correctPercent:Float = (Float(correctCount) / Float(questionCount)) * 100
        //正解率を少数第一位まで計算して画面に反映する
        correctPercentLabel.text = String(format:"%.1f",correctPercent)+"%"
    }
    
    @IBOutlet weak var correctPercentLabel: UILabel!   //正解率ラベル
    
}
