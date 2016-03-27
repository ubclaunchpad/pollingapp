//
//  FirstViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CampaignsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  let campaignViewContainer: CampaignViewContainer
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    campaignViewContainer = CampaignViewContainer()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    campaignViewContainer = CampaignViewContainer()
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    tableView.delegate = self
//    tableView.dataSource = self
    populateCampaigns()
  }
  
  override func viewWillLayoutSubviews() {
    var buffer: CGFloat = 0

    if let tabBarController = self.tabBarController {
      buffer = tabBarController.tabBar.bounds.height
    }
    campaignViewContainer.updateSubviewsForNewOrientation(view.bounds.width, height: view.bounds.height, buffer: buffer)
  }
  
  func populateCampaigns() {
    // TODO: Create model to handle data. Have the model return questions even if they are hardcoded (like below) for now
    var questions: [Question] = []
    for i in 0..<20 {
      questions += ["Question \(i+1)"]
    }
    campaignViewContainer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    campaignViewContainer.populateCampaignViews(questions)
    view.addSubview(campaignViewContainer)
  }
  
}


extension CampaignsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    cell.textLabel?.text = "Question"
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return 5
  }
}

extension CampaignsViewController: UITableViewDelegate {
  
}

