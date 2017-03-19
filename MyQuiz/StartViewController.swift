//
//  StartViewController.swift
//  MyQuiz
//
//  Created by Kei on 2017/03/18.
//  Copyright © 2017年 Kei. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 次の画面に遷移する前に呼び出される標準処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 問題文の読込み
        QuestionDataManager.sharedInstance.loadQuestion()
        // 遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            // 取得できずに終了
            return
        }
        // 問題文の取り出し
        guard let  questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 取得できずに終了
            return
        }
        // 問題文のセット
        nextViewController.questionData = questionData
        
        // タイトルに戻ってくるときに呼び出される処理
        @IBAction func goToTitle(_ segue: UIStoryboardSegue)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
