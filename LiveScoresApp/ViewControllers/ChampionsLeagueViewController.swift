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
    
    var groupA = [GroupStats]()
    var groupB = [GroupStats]()
    var groupC = [GroupStats]()
    var groupD = [GroupStats]()
    var groupE = [GroupStats]()
    var groupF = [GroupStats]()
    var groupG = [GroupStats]()
    var groupH = [GroupStats]()
    
    var allLeagueGroups:[[GroupStats]] = /*[groupA,groupB,groupC,groupD,groupE,groupF,groupG,groupH]*/[[]]
    
    
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
        championsLeagueTableView.dataSource = self
        allLeagueGroups = [groupA,groupB,groupC,groupD,groupE,groupF,groupG,groupH]
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
            
            for (key, leagueNumber) in self.leagueDictionary {
            
            SoccerLiveAPIClient.championsLeagueGroupTable(groupID: leagueNumber) { (error, data) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    self.championsLeagueGroupss = data
                    dump(self.championsLeagueGroupss)
                }
            }
            
                for group in self.championsLeagueGroupss {
                    if group.league_name == "Group A"{
                        self.groupA.append(group)
                    } else if group.league_name == "Group B"{
                         self.groupB.append(group)
                    } else if group.league_name == "Group C" {
                        self.groupC.append(group)
                    } else if group.league_name == "Group D"{
                        self.groupD.append(group)
                    } else if group.league_name == "Group E" {
                        self.groupE.append(group)
                    } else if group.league_name == "Group F"{
                        self.groupF.append(group)
                    } else if group.league_name == "Group G" {
                        self.groupG.append(group)
                    } else if group.league_name == "Group H" {
                        self.groupH.append(group)
                    }
                   
                }
         
            
        }
    }

   
}
}


extension ChampionsLeagueViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLeagueGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = championsLeagueTableView.dequeueReusableCell(withIdentifier: "ChampionsLeagueCell", for: indexPath)
        let league = allLeagueGroups[indexPath.row]
    
//        cell.textLabel?.text = league.league_name
        return cell
        
    }
    
    
}
