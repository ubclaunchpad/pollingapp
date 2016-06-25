//
//  PollAdminViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.


import UIKit



final class PollAdminViewController: UIViewController {
    
    private var answerIDDictionary = [AnswerText: AnswerID]()
    private var min:Int = 0
    private var sec = 0
    private var seconds = 0
    private var timer = NSTimer()
    private var answers:[AnswerText] = []
    private var correctAnswers:[AnswerText] = []
    private var sumuserresults = 0;
    private var answerIDs:[AnswerID] = []
    private var numsubmitforeachAns:[[NSString:Int]] = [[:]]
    private var questionID:QuestionID = ""
    private var questionText:QuestionText = ""
    
    var container: PollAdminViewContainer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // add your container class to view
        container = PollAdminViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
        answerIDs = ModelInterface.sharedInstance.getSelectedQuestion().AIDS
        
        ModelInterface.sharedInstance.processAnswerData(answerIDs) { (listofAllAnswers) in
            self.fillInTheFields(listofAllAnswers)
            
            self.questionID = ModelInterface.sharedInstance.getSelectedQuestion().QID
//            self.sumuserresults = ModelInterface.sharedInstance.getSumOfUsersThatSubmittedAnswers(self.questionID)
            self.createTimer(ModelInterface.sharedInstance.getCountdownSeconds())
            
            self.container?.delegate = self
            self.container?.setQuestionText(self.questionText)
            self.container?.setAnswers(self.answers)
            self.container?.setCorrectAnswers(self.correctAnswers)
            
            self.container?.AnswerTable.reloadData()
        }
        
    }
    
    func fillInTheFields (listofAllAnswers: [Answer]) {
        self.questionText = ModelInterface.sharedInstance.getSelectedQuestion().questionText
        let size = listofAllAnswers.count
        for i in 0 ..< size  {
            let tempAnswer = listofAllAnswers[i].answerText
            self.answerIDDictionary[tempAnswer] = self.answerIDs[i]
            self.answers.append(tempAnswer)
            if (listofAllAnswers[i].isCorrect) {
                self.correctAnswers.append(tempAnswer)
            }
            else {
                self.correctAnswers.append("not correct")
            }
        }
        
    }
    
    func createTimer (startingTime: Int) {
        seconds = startingTime
        let min_temp:Int = seconds/60
        let sec_temp = seconds-60*(min_temp)
        container?.updateTimerLabel(sec_temp, mins: min_temp)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(PollUserViewController.updateTimer)),userInfo: nil, repeats: true)
        
    }
    
    func updateTimer() {
        if(seconds>0) {
            seconds -= 1
            min = seconds/60
            sec = seconds - 60*min
            container?.updateTimerLabel(sec,mins: min)
        } else {
            timer.invalidate()
            // TODO: SEGUE to next view
        }
    }
    
}

extension PollAdminViewController: PollAdminViewContainerDelegate {
    
    func segueToResult() {
        let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
        print("SegueToResult");
    }
    
    func segueToCampaign() {
        let nextRoom =  ModelInterface.sharedInstance.segueToQuestionsScreen()
        ModelInterface.sharedInstance.removeQuestion(questionID)
        performSegueWithIdentifier(nextRoom, sender: self)
        print("SegueToCampaign");
    }
}
