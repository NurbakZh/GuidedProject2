//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by mac on 09.02.2022.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var singleStackButton1: UIButton!
    @IBOutlet weak var singleStackButton2: UIButton!
    @IBOutlet weak var singleStackButton3: UIButton!
    @IBOutlet weak var singleStackButton4: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var multipleStackLabel1: UILabel!
    @IBOutlet weak var multipleStackLabel2: UILabel!
    @IBOutlet weak var multipleStackLabel3: UILabel!
    @IBOutlet weak var multipleStackLabel4: UILabel!
    @IBOutlet weak var rangedStackLabel: UILabel!
    @IBOutlet weak var rangedStackLabel2: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questions: [Question] = [
        Question(text: "What activity you like most?",
                 type: .single,
                 answers: [
                    Answer(text: "Create new projects", type: .Kerey),
                    Answer(text: "Play board games/strategies", type: .Abylai),
                    Answer(text: "Spend time with friends", type: .Tauke),
                    Answer(text: "Travel somewhere", type: .Hak_Nazar)]),
        Question(text: "What are you doing the most in a group work?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Creating new ideas", type: .Kerey),
                    Answer(text: "Searchin for best option", type: .Abylai),
                    Answer(text: "Combining ideas", type: .Tauke),
                    Answer(text: "Scaling the ideas", type: .Hak_Nazar)]
                ),
        Question(text: "How much you like to use open source code",
                 type: .ranged,
                 answers: [
                    Answer(text: "I don't like it", type: .Kerey),
                    Answer(text: "I barely like it", type: .Abylai),
                    Answer(text: "I like to update them", type: .Tauke),
                    Answer(text: "I use it often", type: .Hak_Nazar)]),
    ]
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
            switch sender {
            case singleStackButton1:
                answersChosen.append(currentAnswers[0])
            case singleStackButton2:
                answersChosen.append(currentAnswers[1])
            case singleStackButton3:
                answersChosen.append(currentAnswers[2])
            case singleStackButton4:
                answersChosen.append(currentAnswers[3])
            default:
                break
            }
        
        nextQuestion()
    }
    
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    
    @IBOutlet var rangedSlider: UISlider!
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value *
          Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    func nextQuestion() {
        questionIndex += 1
            if questionIndex < questions.count {
                updateUI()
            } else {
                performSegue(withIdentifier: "Results", sender: nil)
            }
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        let currentQuestion = questions[questionIndex]
        let currentAnswer = currentQuestion.answers
        let totalProgress = Float(questionIndex)/Float(questions.count)
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswer)
        case .multiple:
            updateMultipleStack(using: currentAnswer)
        case .ranged:
            updateRangedStack(using: currentAnswer)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleStackButton1.setTitle(answers[0].text, for: .normal)
        singleStackButton2.setTitle(answers[1].text, for: .normal)
        singleStackButton3.setTitle(answers[2].text, for: .normal)
        singleStackButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multipleStackLabel1.text = answers[0].text
        multipleStackLabel2.text = answers[1].text
        multipleStackLabel3.text = answers[2].text
        multipleStackLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedStackLabel.text = answers.first?.text
        rangedStackLabel2.text = answers.last?.text
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
