//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  
  func submitButtonPressed(question: QuestionText, answerArray: [AnswerID], correctAnswer: Int, questionDuration: Int)
  func backButtonPressed()
  func checksInput (question:QuestionText, A1:AnswerText, A2:AnswerText,  A3:AnswerText, A4:AnswerText, correctAnswer:Int, timerWasSet:Bool) -> Bool}

class CreateQuestionContainerView: UIView {
  @IBOutlet weak var timerLabel: UILabel!
  
  @IBOutlet weak var doneButton: UIButton!
  
  @IBOutlet weak var setTimerButton: UIButton!
  
  @IBOutlet weak var timerScroller: UIDatePicker!
  
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var Submit: UIButton!
  
  var delegate: CreateQuestionViewContainerDelegate?
  
  @IBOutlet weak var questionInputText: UITextField!
  
  @IBOutlet weak var tableView: UITableView!
  
  var timerHasBeenSet = false
  
  var time: Int = 0;
  
  var answerIdentifier:[Int] = [1, 2, 3, 4]
  var answers = [Int: String]()
  var correctAnswer:Int = 0
  
  @IBAction func setTimerButtonPressed(sender: AnyObject) {
    doneButton.alpha = 1;
    Submit.alpha = 0
    setTimerButton.alpha = 0;
    timerScroller.alpha = 1;
    timerScroller.backgroundColor = UIColor.whiteColor()
  }
  
  @IBAction func SubmitPress(sender: AnyObject) {
    let question = questionInputText.text;
    let A1 = answers[1]
    let A2 = answers[2]
    let A3 = answers[3]
    let A4 = answers[4]
    
    if ((delegate?.checksInput(question!, A1: A1!, A2: A2!, A3: A3!, A4: A4!, correctAnswer: correctAnswer, timerWasSet:timerHasBeenSet)) == true) {
      return
    }
    
    let Answers = [A1!, A2!, A3!, A4!];
    
    delegate?.submitButtonPressed(question!,answerArray: Answers, correctAnswer: correctAnswer, questionDuration: time);
    
    
  }
  
  
    
  @IBAction func backButtonPressed(sender: AnyObject) {
    delegate?.backButtonPressed()
  }
  
  
  class func instanceFromNib(frame: CGRect) -> CreateQuestionContainerView {
    let view = UINib(nibName: "CreateQuestionContainerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CreateQuestionContainerView
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    view.tableView.separatorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2 )

    return view
  }
  
  @IBAction func doneButtonPressed(sender: AnyObject) {
    timerScroller.alpha = 0
    Submit.alpha = 1
    setTimerButton.alpha = 1
    timerHasBeenSet = true
    timerLabel.alpha = 1
    time = Int(timerScroller.countDownDuration) - 7
    timerLabel.text = TimerUtil.getTextToShowInTimer(time)
    doneButton.alpha = 0
  }

}

extension CreateQuestionContainerView: AnswerTableViewCellDelegate {
  
  func updateAnswer(identifier: Int, answer: String) {
    answers[identifier] = answer
    print(answer)
  }
  
  func updateCorrectAnswer(identifier: Int) {
    for cell in tableView.visibleCells {
      let answerCell = cell as! AnswerTableViewCell
      if answerCell.identifier != identifier {
        answerCell.isCorrect = false
      }
    }
    correctAnswer = identifier
  }
  
}

extension CreateQuestionContainerView: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let pollResultsCell = UINib(nibName: "AnswerTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "answerCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath) as! AnswerTableViewCell
    cell.identifier = answerIdentifier[indexPath.item]
    cell.delegate = self
    cell.isCorrect = false
    cell.answerField.addTarget(cell, action: #selector(AnswerTableViewCell.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
}


