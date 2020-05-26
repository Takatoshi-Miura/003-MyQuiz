//
//  StartViewController.swift
//  003-MyQuiz
//
//  Created by Takatoshi Miura on 2020/05/25.
//  Copyright © 2020 Takatoshi Miura. All rights reserved.
//
//  ＜概要＞
//  「START」ボタンをタップしたら、CSVファイルから問題文データを読み取り、QuestionDataManagerクラスに問題文情報を設定する。
//  問題文を読み取ることができたらQuestionDataManagerから最初の問題を取得し、その問題を次の画面の問題画面に渡す。
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //次の画面に遷移する前に呼び出される準備処理
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        //問題文の読み込み
        QuestionDataManager.sharedInstance.loadQuestion()
        //遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else{
            return
        }
        //問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else{
            //取得できずに終了
            return
        }
        //問題文のセット
        nextViewController.questionData = questionData
    }
    
    //タイトルに戻ってくるときに呼び出される処理
    @IBAction func goToTitle(_segue:UIStoryboardSegue){
    }


}
