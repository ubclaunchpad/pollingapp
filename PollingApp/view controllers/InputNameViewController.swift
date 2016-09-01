//
//  InputNameViewController.swift
//  PollingApp
//
//  Created by Jon Mercer on 2/6/16.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import UIKit
import FirebaseAuth

class InputNameViewController: UIViewController {
  var container: InputNameView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(InputNameViewController.dismissKeyboard))
    
    view.addGestureRecognizer(tap)
    
    addContainerToVC()
    
    container?.backgroundColor = colors.green
    container?.inputNameTextField.delegate = container
  }
  
  func submit (name: String){
    
    checkChars(name)
    self.container!.submitButton.hidden = true
    self.container!.loadingView.startAnimating()
    if ModelInterface.sharedInstance.isValidName(name) == false {
      let alert = UIAlertController(title: "\(alertMessages.invalid)", message:"",
                                    preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "\(alertMessages.confirm)",
        style: UIAlertActionStyle.Default, handler: nil))
      self.container!.submitButton.hidden = false
      self.container!.loadingView.stopAnimating()
      self.presentViewController(alert, animated: true, completion: nil)
      
    }
    
    let udid = UIDevice.currentDevice().identifierForVendor?.UUIDString
    var userID:String?
    FIRAuth.auth()?.createUserWithEmail("\(name)\(launchpadEmail)", password: udid!) { (user, error) in
      if error == nil {
        NSUserDefaults.standardUserDefaults().setObject("\(name)", forKey: "username")
        NSUserDefaults.standardUserDefaults().setObject("\(udid)", forKey: "password")
        userID = user?.uid
        currentID = (user?.uid)!
        print(currentID)
        NSUserDefaults.standardUserDefaults().setObject("\(userID!)", forKey: "userID")
        ModelInterface.sharedInstance.setUserName(name, userID: userID!)
        currentUser = name
        self.performSegueWithIdentifier(Segues.toMainApp, sender: self)
      } else {
        let alert = UIAlertController(title: alertMessages.usernameIsTaken, message:"", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: alertMessages.confirm, style: UIAlertActionStyle.Default, handler: nil))
         self.container!.submitButton.hidden = false
        self.container!.loadingView.stopAnimating()
        self.presentViewController(alert, animated: true, completion: nil)
        
      }
    }
  }
  
  // MARK: - Helper methods
  func checkChars(name: String) { //TODO: move this into a utils classs.
    if name.characters.count == 0 {
      let alert = UIAlertController(title: "\(alertMessages.empty)", message:"", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "\(alertMessages.confirm)", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  func addContainerToVC() {
    Log.debug("this is debug")
    Log.info("this is info")
    Log.warn("this is warn")
    Log.error("this is error")
    Log.test("this is test")
    container = InputNameView.instanceFromNib(
      CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    container?.delegate = self
    view.addSubview(container!)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}

// MARK: - InputeNameView Delegate -

extension InputNameViewController: InputNameViewDelegate {
  func displayConfirmationMessage (name: String) {
    self.dismissKeyboard()
    Log.debug("Submit button pressed")
    let confirmAlert = UIAlertController(title: "\(alertMessages.confirmName)\(name)", message: "\(alertMessages.nameMessage)", preferredStyle: UIAlertControllerStyle.Alert)
    confirmAlert.addAction(UIAlertAction(title: "\(alertMessages.no)", style: .Default, handler: { (action: UIAlertAction!) in confirmAlert.dismissViewControllerAnimated(true, completion: nil)
    }))
    confirmAlert.addAction(UIAlertAction(title: "\(alertMessages.yes)", style: .Cancel, handler: { (action: UIAlertAction!) in
      self.submit(name)
    }))
    presentViewController(confirmAlert, animated: true, completion: nil)
  }
}

// MARK: - UITextField Delegate -

extension InputNameView: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    let name = inputNameTextField.text
    delegate?.displayConfirmationMessage(name!)
    return false
  }
}

