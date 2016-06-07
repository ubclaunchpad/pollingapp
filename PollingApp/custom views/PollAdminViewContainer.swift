//
//  PollAdminUserViewContainer.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-04-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit


protocol PollAdminViewContainerDelegate  {
    func segueToResult()
    func segueToCampaign()
}

class PollAdminViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var answers:[Answer] = []
    private var correctAnswers:[Answer] = []
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var timer: UILabel!

    @IBOutlet weak var AnswerTable: UITableView!
    
    var delegate: PollAdminViewContainerDelegate?

    
    
    @IBAction func goToResult(sender: AnyObject) {
        delegate?.segueToResult();
    }
    
    @IBAction func goToCampaign(sender: AnyObject) {
        delegate?.segueToCampaign();
    }
    
    class func instanceFromNib(frame: CGRect) -> PollAdminViewContainer {
        let view = UINib(nibName: "PollAdminViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollAdminViewContainer
        view.frame = frame
        view.AnswerTable.delegate = view
        view.AnswerTable.dataSource = view
        
        return view
    }
    
    
    func setAnswers(Answers: [Answer]){
        answers = Answers
        
    }
    
    func setCorrectAnswers(Answers: [Answer]){
        correctAnswers = Answers
   }
    
    
    
    func setQuestionText(questionText: Question) {
        question.text = questionText
    }

    func updateTimerLabel(secs: Int, mins: Int) {
        if (mins==0){
            timer.text = "\(secs)"
        } else {
            if secs<10{
                timer.text = "\(mins):0\(secs)"
            } else {
                timer.text = "\(mins):\(secs)"
            }
        }
        
    }
    
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let nib_name = UINib(nibName: "AnswerAdminTableViewCell", bundle:nil)
        tableView.registerNib(nib_name, forCellReuseIdentifier: "answeradminCell")
        let cell = self.AnswerTable.dequeueReusableCellWithIdentifier("answeradminCell", forIndexPath: indexPath) as! AnswerAdminTableViewCell
        cell.setAnswerText(answers[indexPath.row]);
        cell.setisCorrect(correctAnswers[indexPath.row]);
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
        //TODO: set tableView Cell size based on content size
    }
    
    
    
    
    

    
    
}
