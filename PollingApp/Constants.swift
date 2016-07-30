//
//  Constants.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation
import UIKit

typealias QuestionID = String
typealias QuestionText = String
typealias AnswerID = String
typealias AnswerText = String
typealias Author = String
typealias SegueName = String
typealias RoomID = String

var currentUser:Author = "" //TODO: this should persist on phone restart
var currentID  = ""
var okayNameCharacters : Set<Character> =
  Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)


var launchpadEmail: String = "@ubclaunchpad.com"
var numberOfAnswers: String = "Number of users that answered: %1%"
var tallyString: String = "Tally: %1%"

var charactersToAvoid : [Character] =
  Array("#[]*".characters)

let setTimerValues:[Int] = [1, -1, 5, -5, 15, -15, 60, -60]

let calendar = NSCalendar.currentCalendar()

enum colors {
  static let green = UIColor(red: 28/255.0, green: 165/255.0, blue: 122/255.0, alpha: 1)
  static let lightGreen = UIColor(red: 226/255.0, green: 250/255.0, blue: 218/255.0, alpha: 1)
  static let barGraphColour = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
}

enum Segues {
  static let toMainApp = "showMainApp"
  static let toQuestionsScreen = "toQuestionsScreen"
  static let toPollUserViewController = "toPollUserViewController"
  static let toCreateQuestionView = "toCreateQuestionView"
  static let toPollAdminScreen = "toPollAdminScreen"
  static let toPollResultsView = "toPollResultsView"
  static let toPollAdminVCFromCampaign = "toPollAdminVCFromCampaign"
}

enum UIStringConstants {
  static let lessThanOneDayLeft = "Less than one day"
  static let notCorrect = "notCorrect"
}

enum UITimeConstants {
  static let oneDayinSeconds = 86400
  static let oneHourinSeconds = 3600
  static let oneMinuteinSeconds = 60
  static let oneHourinMinutes = 60
  static let moment = 300
}

enum UIDaysRemaining {
  static let singularDay = "Day Left"
  static let pluralDay = "Days Left"
}

enum UITimeRemaining {
  static let endedMoments = "Ended a couple moments ago"
  static let endsMoments = "Ends in a couple moments"
  static let endedMinutes = "Ended %1% minutes ago"
  static let endsMinutes = "%1% minutes"
  static let endedHour = "Ended %1% hour ago"
  static let endsHour = "%1% hour"
  static let endedHours = "Ended %1% hours ago"
  static let endsHours = "%1% hours"
  static let endsDays = "%1% days"
  static let endsDay = "%1% day"
  static let timerMinutes = "Minutes: %1%"
  static let timerMinute = "Minute: %1%"
  static let timerHours = "Hours: %1%"
  static let timerHour = "Hour: %1%"
  static let timerTextHourMinute = "Question will end in %1% hour and %2% minute, at %3%"
  static let timerTextHoursMinute = "Question will end in %1% hours and %2% minute, at %3%"
  static let timerTextHourMinutes = "Question will end in %1% hour and %2% minutes, at %3%"
  static let timerTextHoursMinutes = "Question will end in %1% hours and %2% minutes, at %3%"
  static let timerTextMinutes = "Question will end in %1% minutes, at %2%"
  static let timerTextMinute = "Question will end in %1% minute, at %2%"
}

enum alertMessages {
  static let invalid = "Invalid Name"
  static let empty = "Please enter your name"
  static let emptyQuestions = "Please fill in all fields and set timer"
  static let confirm = "Ok"
  static let yes = "YES"
  static let no = "NO"
  static let confirmName = "Pleaes confirm that your name is "
  static let nameMessage = "You will not be able to change your name at a later time"
  static let confirmation = "Confirmation"
  static let confirmationMessage = "Are you sure you want to delete your quesiton?"
  static let duplicateAnswer = "One or more of your answers are the same"
  static let noRevoting = "You have already selected this answer. Choose a different answer"
  static let usernameIsTaken = "Please choose another name. This name is already taken."
}

enum correct {
  static let isCorrect = "Correct"
  static let notCorrect = "not Correct"
}

enum imageNames {
  static let setIncorrect = "SetIncorrect"
  static let setCorrect = "SetCorrect"
}

enum cellDimensions {
  static let pollAdminCellHeight:CGFloat = 58
}
