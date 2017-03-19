//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by Kei on 2017/03/18.
//  Copyright © 2017年 Kei. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {

    // スタート画面から問題データを受け取るプロパティ。必ず受け取るから「！」使用
    var questionData: QuestionData!
    
    @IBOutlet weak var questionNoLabel: UILabel! // 問題番号ラベル
    @IBOutlet weak var questionTextView: UITextView! // 問題文テキストビュー
    @IBOutlet weak var answer1Button: UIButton! // 選択肢1ボタン
    @IBOutlet weak var answer2Button: UIButton! // 選択肢2ボタン
    @IBOutlet weak var answer3Button: UIButton! // 選択肢3ボタン
    @IBOutlet weak var answer4Button: UIButton! // 選択肢4ボタン
    @IBOutlet weak var correctImageView: UIImageView! // 正解時のイメージビュー
    @IBOutlet weak var incorrectImageView: UIImageView! // 不正解時のイメージビュー
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初期データ設定処理。前画面で設定済みのquestionDataから値を取り出す
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1, for: UIControlState.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControlState.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControlState.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControlState.normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 選択肢1をタップ
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1 // 選択した答えの番号を保存する
        goNextQuestionWithAnimation() // 次の問題に進む
    }
    // 選択肢2をタップ
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2 // 選択した答えの番号を保存する
        goNextQuestionWithAnimation() // 次の問題に進む
    }
    // 選択肢3をタップ
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3 // 選択した答えの番号を保存する
        goNextQuestionWithAnimation() // 次の問題に進む
    }
    // 選択肢4をタップ
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4 // 選択した答えの番号を保存する
        goNextQuestionWithAnimation() // 次の問題に進む
    }
    // 次の問題にアニメーション付きで進む
    func goNextQuestionWithAnimation() {
        // 正解しているか判断する
        if questionData.isCorrect() {
            // 正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithCorrectAnimation(soundId: 1025)
        } else {
            // 不正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithCorrectAnimation(soundId: 1006)
        
        }
    }
    // 次の問題に正解か不正解のアニメーション付きで遷移する
    func goNextQuestionWithCorrectAnimation(soundId: Int) {
        // 正解か不正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(SystemSoundID(soundId))
        // アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            //アルファ値を1.0に変化させる（初期値はStoryboadで0.0に設定済み）
            self.correctImageView.alpha = 1.0
        }) { (Bool) in
                self.goNextQuestion() // アニメーション終了後に次の問題に進む
        }
    }
    // 次の問題に遷移する
    func goNextQuestion() {
        // 問題文の取り出し
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 問題文がなければ結果画面へ遷移する
            // StoryboadのIdentifierに設定した値（result）を指定してViewControllerを生成する
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResltViewController {
                // StoryboadのSegueを利用しない明示的な画面遷移処理
                present(resultViewController, animated: true, completion: nil)
            }
            return
        }
        // 問題文がある場合は次の問題へ遷移する
        // StoryboadのIdentifierに設定した値（question）を指定してViewControllerを生成する
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController {
            nextQuestionViewController.questionData = nextQuestion
            // StoryboadのSegueを利用しない明示的な画面遷移処理
            present(nextQuestionViewController, animated: true, completion: nil)
        }
    }
}