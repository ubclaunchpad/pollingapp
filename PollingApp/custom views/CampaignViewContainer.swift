//
//  CampaignViewContainer.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CampaignViewContainerDelegate {
  func questionSelected(question: Question)
  func newQuestionSelected()
  func resultsButtonSelected(question: Question)
  func refreshQuestions()
}

class CampaignViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var roomName: UILabel!
  
  @IBAction func refresh(sender: AnyObject) {
    delegate?.refreshQuestions()
  }
  private var questions:[Question] = []
  private var expiredQuestions:[Question] = []
  private var yourQuestions:[Question] = []
  private var answeredQuestions:[Question] = []
  
  var delegate: CampaignViewContainerDelegate?
  
  @IBAction func newQuestionPressed(sender: AnyObject) {
    delegate?.newQuestionSelected()
  }
  
  class func instancefromNib(frame: CGRect) -> CampaignViewContainer {
    let view = UINib(nibName: "CampaignViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CampaignViewContainer
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    return view
  }
  
  func setRoomNameTitle(name: String) {
    roomName.text = name;
  }
  
  func setQuestions(questions: [Question]) {
    self.questions = questions
  }
  
  func setExpiredQuestions (expiredQuestions: [Question]) {
    self.expiredQuestions = expiredQuestions
  }
  func setYourQuestions(yourQuestions: [Question]) {
    self.yourQuestions = yourQuestions
  }
  
  func setAnsweredQuestion(answeredQuestions : [Question]) {
    self.answeredQuestions = answeredQuestions
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (section == 0) {
      return yourQuestions.count
    } else if (section == 1) {
      return answeredQuestions.count
    }else if (section == 2) {
      return questions.count
    } else {
      return expiredQuestions.count
    }
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let nib_name = UINib(nibName: "CampaignViewTableViewCell", bundle: nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "campaignCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("campaignCell", forIndexPath: indexPath) as! CampaignViewTableViewCell
    cell.delegate = self
    
    var templistQuestions = [Question]()
    
    if (indexPath.section == 0) {
      templistQuestions = yourQuestions
    } else if (indexPath.section == 1) {
      templistQuestions = answeredQuestions
    } else if (indexPath.section == 2)  {
      templistQuestions = questions
    } else {
      templistQuestions = expiredQuestions
    }
    
    cell.setQuestionText( templistQuestions[indexPath.row].questionText)
    cell.setAnsweredBackground(templistQuestions[indexPath.row].isExpired)
    
    if (templistQuestions[indexPath.row].author == currentUser) {
      cell.setAuthorText("Yours")
    } else {
      cell.setAuthorText( templistQuestions[indexPath.row].author)
    }
    cell.setExpiryMessage( templistQuestions[indexPath.row].expireMessage)
    cell.setFieldQuestion(templistQuestions[indexPath.row])
    
     cell.hideResultsLabel(templistQuestions[indexPath.row].isExpired)
    
    
    
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 90
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var selectedQuestion:Question
    if indexPath.section == 0 {
       selectedQuestion = yourQuestions[indexPath.row]
    } else if indexPath.section == 1 {
      selectedQuestion = answeredQuestions[indexPath.row]
    } else if indexPath.section == 2 {
      selectedQuestion = questions[indexPath.row]
    } else {
      selectedQuestion = expiredQuestions[indexPath.row]
    }
    
    delegate?.questionSelected(selectedQuestion)
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if (section == 0) {
      return "Questions You Created"
    } else if (section == 1) {
      return "Questions You Answered"
    } else if (section == 2) {
      return "Unanswered Questions"
    } else {
      return "Expired Questions"
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 4
  }
}

extension CampaignViewContainer: CampaignViewTableViewCellDelegate {
  func resultsButtonSelected(question: Question) {
    delegate?.resultsButtonSelected(question)
  }
  
}
