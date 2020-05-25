//
//  QuestionViewController.swift
//  003-MyQuiz
//
//  Created by Takatoshi Miura on 2020/05/25.
//  Copyright © 2020 Takatoshi Miura. All rights reserved.
//
//  ＜概要＞
//  開始画面からのデータの受け取り、問題の答えを選択する問題画面の動作、
//  次の問題への遷移処理、結果画面の呼び出し処理を実装している。
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //初期データ設定処理。前画面で設定済みのquestionDataから値を取り出す
        questionNoLabel.text  = "Q.\(questionData.questionNo)"
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1,for:UIControl.State.normal)
        answer2Button.setTitle(questionData.answer2,for:UIControl.State.normal)
        answer3Button.setTitle(questionData.answer3,for:UIControl.State.normal)
        answer4Button.setTitle(questionData.answer4,for:UIControl.State.normal)
    }
    
    var questionData:QuestionData!  //前画面からのデータ受け取り用
    
    @IBOutlet weak var questionNoLabel: UILabel!          //問題番号ラベル
    @IBOutlet weak var questionTextView: UITextView!      //問題文テキストビュー
    @IBOutlet weak var answer1Button: UIButton!           //選択肢1ラベル
    @IBOutlet weak var answer2Button: UIButton!           //選択肢2ラベル
    @IBOutlet weak var answer3Button: UIButton!           //選択肢3ラベル
    @IBOutlet weak var answer4Button: UIButton!           //選択肢4ラベル
    @IBOutlet weak var correctImageView: UIImageView!     //正解時のイメージビュー
    @IBOutlet weak var incorrectImageView: UIImageView!   //不正解時のイメージビュー
    
    //選択肢1をタップした時の処理
    @IBAction func tapAnswe1Button(_ sender: Any) {
        //選択した答えの番号を保存する
        questionData.userChoiceAnswerNumber = 1
        //次の問題に進む
        goNextQuestionWithAnimation()
    }
    
    //選択肢2をタップした時の処理
    @IBAction func tapAnswer2Button(_ sender: Any) {
        //選択した答えの番号を保存する
        questionData.userChoiceAnswerNumber = 2
        //次の問題に進む
        goNextQuestionWithAnimation()
    }
    
    //選択肢3をタップした時の処理
    @IBAction func tapAnswer3Button(_ sender: Any) {
        //選択した答えの番号を保存する
        questionData.userChoiceAnswerNumber = 3
        //次の問題に進む
        goNextQuestionWithAnimation()
    }
    
    //選択肢4をタップした時の処理
    @IBAction func tapAnswer4Button(_ sender: Any) {
        //選択した答えの番号を保存する
        questionData.userChoiceAnswerNumber = 4
        //次の問題に進む
        goNextQuestionWithAnimation()
    }
    
    //次の問題にアニメーション付きで進むメソッド
    func goNextQuestionWithAnimation(){
        //正解しているか判定する
        if questionData.isCorrect(){
            //正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithCorrectAnimation()
        }else{
            //不正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithIncorrectAnimation()
        }
    }
    
    //次の問題に正解のアニメーション付きで遷移するメソッド
    func goNextQuestionWithCorrectAnimation(){
        //正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1025)
        //アニメーション
        UIView.animate(withDuration:2.0,animations:{
            //アルファ値を1.0に変化させる（初期値はStoryboardで0.0に設定済み）
            self.correctImageView.alpha = 1.0
        }){Bool in
            //アニメーション完了後に次の問題に進む
            self.goNextQuestion()
        }
    }
    
    //次の問題に不正解のアニメーション付きで遷移するメソッド
    func goNextQuestionWithIncorrectAnimation(){
        //不正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1006)
        //アニメーション
        UIView.animate(withDuration: 2.0,animations:{
            //アルファ値を1.0に変化させる（初期値はStoryboardで0.0に設定済み）
            self.incorrectImageView.alpha = 1.0
        }){Bool in
            //アニメーション完了後に次の問題に進む
            self.goNextQuestion()
        }
    }
    
    //次の問題へ遷移するメソッド
    func goNextQuestion(){
        //問題文の取り出し
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else{
            //問題文がなければ結果画面へ遷移する
            //StoryboardのIdentifierに設定した値（result）を指定してViewControllerを生成する
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController{
                //StoryboardのSegueを利用しない明示的な画面遷移処理
                present(resultViewController, animated: true, completion:nil)
            }
            return
        }
        //問題文がある場合は次の問題へ遷移する
        //Storyboardのidentifierに設定した値（question)を設定してViewControllerを生成する
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController{
            nextQuestionViewController.questionData = nextQuestion
            //storyboardのSegueを利用しない明示的な画面遷移処理
            present(nextQuestionViewController, animated: true,completion:nil)
        }
    }

}
