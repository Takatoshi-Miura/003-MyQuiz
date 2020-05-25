//
//  QuestionDataManager.swift
//  003-MyQuiz
//
//  Created by Takatoshi Miura on 2020/05/25.
//  Copyright © 2020 Takatoshi Miura. All rights reserved.
//

import Foundation

//CSVファイル内の問題のうち1問分の情報を管理するクラス
class QuestionData {
    
    var question:String               //問題文
    var answer1:String                //選択肢1
    var answer2:String                //選択肢2
    var answer3:String                //選択肢3
    var answer4:String                //選択肢4
    var correctAnswerNumber:Int       //正解の番号
    
    var userChoiceAnswerNumber:Int?   //ユーザーが選択した選択肢の番号
    var questionNo:Int = 0            //問題文の番号
    
    //クラス生成時にcsvの配列を受け取る
    init(questionSourceDataArray:[String]){
        question = questionSourceDataArray[0]
        answer1  = questionSourceDataArray[1]
        answer2  = questionSourceDataArray[2]
        answer3  = questionSourceDataArray[3]
        answer4  = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
    //ユーザーの解答の正誤を判定するメソッド
    func isCorrect() -> Bool {
        //ユーザーの解答が正解と一致しているかを確認
        if userChoiceAnswerNumber == correctAnswerNumber {
            return true    //正解
        } else {
            return false   //不正解
        }
    }
    
}


//クイズデータ全般の管理と正答率を管理するクラス
class QuestionDataManager{
    
    static let sharedInstance = QuestionDataManager()   //シングルトンオブジェクト
    var questionDataArray = [QuestionData]()            //CSVファイルの問題を格納する配列
    var nowQuestionIndex:Int = 0                        //現在の問題番号
    
    private init(){
        //シングルトンであることを保証するためにprivateで宣言
    }
    
    //CSVファイルから問題文のデータを読み込むメソッド
    func loadQuestion(){
        //格納済みの問題文があればいったん削除しておく
        questionDataArray.removeAll()
        //現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        //csvファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question",ofType: "csv") else {
            //csvファイルなし
            print("csvファイルが存在しません")
            return
        }
        //csvファイル読み込み
        do{
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            //csvデータを１行ずつ読み込む
            csvStringData.enumerateLines(invoking:{(line,stop)in
                //カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy:",")
                //問題データを格納するオブジェクトを作成
                let questionData = QuestionData(questionSourceDataArray:questionSourceDataArray)
                //問題を追加
                self.questionDataArray.append(questionData)
                //問題番号を設定
                questionData.questionNo = self.questionDataArray.count
            })
        }catch let error{
            print("csvファイル読み込みエラーが発生しました:\(error)")
            return
        }
    }
    
    //次の問題を取り出す
    func nextQuestion() -> QuestionData?{
        if nowQuestionIndex < questionDataArray.count{
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
    
}
