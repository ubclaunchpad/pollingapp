//
//  NameModelExtension.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

extension ModelInterface: NameModelProtocol {
  
  func setUserName(name: String) -> SegueName {
    return Segues.toMainApp
  }
}
