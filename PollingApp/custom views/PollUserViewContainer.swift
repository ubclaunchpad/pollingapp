//
//  PollUserViewContainer.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol PollUserViewContainerDelegate {
    func answerSelected(answer: Answer)
    
}

class PollUserViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    private var answers:[Answer] = []
    
    var selectedAnswer: String = ""
    
    var delegate: PollUserViewContainerDelegate?
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    class func instanceFromNib(frame: CGRect) -> PollUserViewContainer {
        let view = UINib(nibName: "PollUserViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollUserViewContainer
        view.frame = frame
        view.tableView.delegate = view
        view.tableView.dataSource = view
        
        return view
    }
    
    func setAnswers(Answers: [Answer]){
        answers = Answers
        
    }
    
    func setQuestionText(questionText: Question) {
        question.text = questionText
    }
    
    func updateTimerLabel(secs: Int, mins: Int) {
        if (mins==0){
            timerLabel.text = "\(secs)"
        } else {
            if secs<10{
                timerLabel.text = "\(mins):0\(secs)"
            } else {
                timerLabel.text = "\(mins):\(secs)"
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let nib_name = UINib(nibName: "AnswerViewTableViewCell", bundle:nil)
        tableView.registerNib(nib_name, forCellReuseIdentifier: "answerCell")
        let cell = self.tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath) as! AnswerViewTableViewCell
        cell.setAnswerText(answers[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
        //TODO: set tableView Cell size based on content size
    }
    
}

extension PollUserViewContainer: AnswerViewTableViewCellDelegate {
    func answerSelected(answer: Answer) {
        print(answer)
        delegate?.answerSelected(answer)
        
    }
}
