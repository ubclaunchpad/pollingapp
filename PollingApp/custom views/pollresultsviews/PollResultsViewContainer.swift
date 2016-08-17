//
//  pollresultsviews.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit


protocol PollResultsViewContainerDelegate {
  func goBackToCampaign()
  func presentConfirmationVaraible()
}
class PollResultsViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var resultsTableView: UITableView!
  @IBOutlet weak var totalAnswersLabel: UILabel!
  @IBOutlet weak var question: UILabel!
  
  private var answers: [AnswerText] = []
  private var correctAnswer: AnswerText = ""
  private var totalNumberOfAnswers: Int = 0
  private var numberOfResponsesPerAnswer: [Int] = []
  private var questionText = ""
  private var yourAnswer = ""
  private var yourAnswerNumOfRespones = 0
  var delegate: PollResultsViewContainerDelegate?
  
  class func instanceFromNib(frame: CGRect) -> PollResultsViewContainer {
    let view = UINib(nibName: "PollResultsViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollResultsViewContainer
    view.frame = frame
    view.resultsTableView.delegate = view
    view.resultsTableView.dataSource = view
    view.resultsTableView.allowsSelection = false
    view.resultsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    view.resultsTableView.backgroundColor = UIColor.clearColor()
    view.resultsTableView.opaque = false
    return view
  }
  
  //TODO:IPA-132 Move this logic to VC or model
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    
    let pollResultsCell = UINib(nibName: "PollResultsTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "resultsCell")
    let cell = self.resultsTableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath) as! PollResultsTableViewCell
    
    let answer = answers[indexPath.row]
    
    cell.setAnswerText(answer)
    
    if answer == correctAnswer {
      cell.setCorrectAnswer()
    }
    
    
    if(totalNumberOfAnswers != 0){
      let results:Double = MathUtil.convertTallyResultsToPercentage(Double(numberOfResponsesPerAnswer[indexPath.row]), denominator: Double(totalNumberOfAnswers))
      cell.setBarGraph(results, isYourAnswer: yourAnswer == answer, isCorrect: correctAnswer == answer)
      cell.SetTallyLabel(numberOfResponsesPerAnswer[indexPath.row], result: results)
    } else {
      cell.setBarGraph(0, isYourAnswer: yourAnswer == answer, isCorrect: correctAnswer == answer)
      cell.SetTallyLabel(0, result: 0)
    }
    
    
    cell.backgroundColor = UIColor.clearColor()
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell
    
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return answers.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 68
  }
  
  func setQuestionLabelText (questionText: QuestionText){
    question.text = questionText
  }
  
  func setAnswers (Answers: [AnswerText]){
    answers = Answers
    print(answers.count)
  }
  
  func setCorrectAnswer (rightAnswer:AnswerText){
    correctAnswer = rightAnswer
  }
  
  func setTotalNumberOfAnswers (totalNumOfAnswers:Int){
    totalNumberOfAnswers = totalNumOfAnswers
    totalAnswersLabel.text = ("\(StringUtil.fillInString(totalVotes, time: totalNumberOfAnswers))")
  }
  
  func setYourAnswer (yourAnswer:String) {
    self.yourAnswer = yourAnswer
  }
  
  func setNumberOfResponsesForAnswer (NumResponses:[Int]){
    numberOfResponsesPerAnswer = NumResponses
  }
}
