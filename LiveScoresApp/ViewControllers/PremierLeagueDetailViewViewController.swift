//
//  PremierLeagueDetailViewViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/5/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class PremierLeagueDetailViewViewController: UIViewController {
    @IBOutlet weak var match: UILabel!
    var leagueEventt: Events!
  
    
    @IBOutlet weak var teamsFormation: UILabel!
    @IBOutlet weak var goalScorer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateEvents()
    }
    
 
    func updateEvents(){
    
        match.text = "\(leagueEventt.match_hometeam_name)  VS  \(leagueEventt.match_awayteam_name)"
        
    }
}


