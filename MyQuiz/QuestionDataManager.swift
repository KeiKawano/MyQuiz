//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by Kei on 2017/03/18.
//  Copyright © 2017年 Kei. All rights reserved.
//

import Foundation

class QuestionData {
    // 問題文
    var question: String
    // 選択肢１
    var answer1 : String
    // 選択肢２
    var answer2 : String
    // 選択肢３
    var answer3 : String
    // 選択肢４
    var answer4 : String
    // 正解の番号
    var correctAnswerNumber: Int
    
    // ユーザが選択した選択肢の番号
    var userChoiceAnswerNumber: Int?
    // 問題の番号
    var questionNo: Int
    
    // クラスが生成されたときの処理
    init(questionSourceDataArray: [String]) {
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
    // ユーザが選択した答えが正解かどうか判定する
    func isCorrect() -> Bool {
        // 答えが一致しているかどうか判定する
        if correctAnswerNumber == userChoiceAnswerNumber {
            // 正解
            return true
        }
        return false
    }
    
}

// クイズデータ全般の管理と成績を管理するクラス
class QuestionDataManager {
    // シングルトンのオブジェクトを生成
    static let sharedInstance = QuestionDataManager()
    // 問題を格納するための配列
    var questionDataArray = [QuestionData]()
    // 現在の問題のインデックス
    var nowQuestionIndex: Int = 0
    // 初期化処理
    private init() {
        // シングルトンであることを保証するためにprivateで宣言しておく
    }
    // 問題文の読み込み処理
    func loadQuestion() {
        // 格納済みの問題があればいったん削除しておく
        questionDataArray.removeAll()
        // 現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        // CSVファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            // CSVファルなし
            print("CSVファイルが存在しません")
            return
        }
        // CSVファイル読込み
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            // CSVデータを１行ずつ読み込む
            csvStringData.enumerateLines(invoking: { (line, stop) in
                // カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy: ",")
                // 問題データを格納するオブジェうとを作成
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                // 問題を追加
                self.questionDataArray.append(questionData)
                // 問題番号を設定
                questionData.questionNo = self.questionDataArray.count
            })
        } catch let error {
            print("CSVファイル読込みエラーが発生しました：\(error)")
            return
        }
    }

    // 次の問題を取り出す
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            // あやしい
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
}
