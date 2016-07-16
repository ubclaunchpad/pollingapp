//
//  Constants.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

typealias QuestionID = String
typealias QuestionText = String
typealias AnswerID = String
typealias AnswerText = String
typealias Author = String
typealias SegueName = String
typealias RoomID = String

var currentUser:Author = ""; //TODO: this should persist on phone restart

var okayNameCharacters : Set<Character> =
  Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)


var launchpadEmail:String = "@ubclaunchpad.com"
var numberOfAnswers:String = "Number of users that answered: %1%"

var charactersToAvoid : [Character] =
  Array("#[]*".characters)

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
  static let moment = 300
}

enum UIDaysRemaining {
  static let singularDay = "Day Left"
  static let pluralDay = "Days Left"
}

enum UITimeRemaining {
  static let endedMoments = "Poll ended a couple moments ago"
  static let endsMoments = "Poll ends in a couple moments"
  static let endedMinutes = "Poll ended %1% minutes ago"
  static let endsMinutes = "Poll ends in %1% minutes"
  static let endedHour = "Poll ended %1% hour ago"
  static let endsHour = "Poll ends in %1% hour"
  static let endedHours = "Poll ended %1% hours ago"
  static let endsHours = "Poll ends in %1% hours"
  static let endsDays = "Poll ends in %1% days"
  static let endsDay = "Poll ends in %1% day"
  static let timerMinutes = "Minutes: %1%"
  static let timerMinute = "Minute: %1%"
  static let timerHours = "Hours: %1%"
  static let timerHour = "Hour: %1%"
}

enum alertMessages {
  static let invalid = "Invalid Name"
  static let empty = "Please enter your name"
  static let emptyQuestions = "Please fill in all fields and set timer"
  static let confirm = "OK"
}

enum correct {
  static let isCorrect = "Correct"
  static let notCorrect = "not Correct"
}
