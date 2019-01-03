//
//  ChampionsLeagueViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/2/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class ChampionsLeagueViewController: UIViewController {
    @IBOutlet weak var championsLeagueTableView: UITableView!
    var groupss = ["Group A","Group B","Group C","Group D","Group E","Group F","Group G","Group H"]
    
    var championsLeagueGroupss = [GroupStats](){
        didSet {
            DispatchQueue.main.async {
                self.championsLeagueTableView.reloadData()
            }
        }
    }
    
    var value = String()
    
    var leagueDictionary = [String:String] ()
    
    var championsLeagueGroups = [ChampionsLeagueGroups]() {
        didSet {
            DispatchQueue.main.async {
                self.championsLeagueTableView.reloadData()

            }        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SoccerLiveAPIClient.championsLeague { (error, leagueGroups) in
            if let error = error {
                print("AppError: \(error)")
            } else if let championsLeagueGroup = leagueGroups {
                self.championsLeagueGroups = championsLeagueGroup
            
            for group in self.championsLeagueGroups {
    
                if self.groupss.contains(group.league_name){
                    self.leagueDictionary[group.league_name] = group.league_id
                }
                
                
            }
              
            }
            
        }
championsLeagueTableView.dataSource = self
        for (key, leagueNumber) in leagueDictionary {
            
            SoccerLiveAPIClient.championsLeagueGroupTable(groupID: leagueNumber) { (error, leagueGroup) in
                
            }
            
         
            
        }
    }

   
}



//static func
//
//NetworkHelper.performDataTask(urlString: <#T##String#>, httpMethod: <#T##String#>, completionHandler: <#T##(Error?, Data?) -> Void#>)




extension ChampionsLeagueViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championsLeagueGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = championsLeagueTableView.dequeueReusableCell(withIdentifier: "ChampionsLeagueCell", for: indexPath)
        let league = championsLeagueGroups[indexPath.row]
        cell.textLabel?.text = league.league_name
        return cell
        
    }
    
    
}
