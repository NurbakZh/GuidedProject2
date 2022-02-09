//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by mac on 09.02.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefLabel: UILabel!
    
    var responses: [Answer]
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculatePersonalityResult() {
        let frequencyOfAnswers = responses.reduce(into:
            [Khan: Int]()) { (counts, answer) in
             if let existingCount = counts[answer.type] {
                 counts[answer.type] = existingCount + 1
             } else {
                 counts[answer.type] = 1
             }
         }
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 >
            $1.1 }.first!.key
        resultAnswerLabel.text = "You are \(mostCommonAnswer.rawValue)!"
        resultDefLabel.text = mostCommonAnswer.definition
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
