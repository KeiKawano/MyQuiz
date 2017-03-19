//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by Kei on 2017/03/20.
//  Copyright © 2017年 Kei. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var correctPercentLabel: UILabel! // 正解率ラベル
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 問題数を取得する
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        // 正解数を取得する
        var correctCount: Int = 0
        // 正解数を計算する
        for questionData in QuestionDataManager.sharedInstance.questionDataArray {
            if questionData.isCorrect() {
                correctCount += 1 // 正解数を増やす
            }
        }
        // 正解率を計算する
        let correctPercent: Float = (Float(correctCount) / Float(questionCount)) * 100
        // 正解率を小数点第一位まで計算して画面に反映する
        correctPercentLabel.text = String(format: "%.1f", correctPercent) + "%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
