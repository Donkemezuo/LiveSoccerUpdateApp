//
//  ChampionsLeagueViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/2/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import AVFoundation

class ChampionsLeagueViewController: UIViewController {
    @IBOutlet weak var championsLeagueTableView: UITableView!
    var groupss = ["Group A","Group B","Group C","Group D","Group E","Group F","Group G","Group H"]
    @IBOutlet weak var championsLeagueImage: UIImageView!
    
    var groupA = [GroupStats]()
    var groupB = [GroupStats]()
    var groupC = [GroupStats]()
    var groupD = [GroupStats]()
    var groupE = [GroupStats]()
    var groupF = [GroupStats]()
    var groupG = [GroupStats]()
    var groupH = [GroupStats]()
    var backgroundSong = AVAudioPlayer()
    
    var allLeagueGroups:[[GroupStats]] = [[]] {
        didSet {
            DispatchQueue.main.async {
            }
          
        }
    }
    
    
    
    var championsLeagueGroupss = [GroupStats](){
        didSet {
            DispatchQueue.main.async {
           self.championsLeagueTableView.reloadData()
            }
        }
    }
    
    
    var leagueDictionary = [String:String] ()
    
    var championsLeagueGroups = [ChampionsLeagueGroups]() {
        didSet {
            DispatchQueue.main.async {
                self.championsLeagueTableView.reloadData()

            }        }
    }
    
    func setBackgroundView(){
        championsLeagueImage.image = UIImage.init(named: "champp")
    }
    
    func setLeagueSong(){
        do {
            backgroundSong = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "mp3")!))
            backgroundSong.prepareToPlay()
            backgroundSong.play()
        } catch {
            fatalError()
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let centralView = storyBoard.instantiateViewController(withIdentifier: "mainVC") as! ViewController
        present(centralView, animated: true, completion: nil)
        backgroundSong.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        championsLeagueTableView.dataSource = self
        championsLeagueTableView.delegate = self
        setBackgroundView()
        setLeagueSong()
        getLeagueData()
        title = "Champions League Group"
}
func getLeagueData() {
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
            
            for (_, leagueNumber) in self.leagueDictionary {
                
                SoccerLiveAPIClient.championsLeagueGroupTable(groupID: leagueNumber) { (error, data) in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let data = data {
                        self.championsLeagueGroupss = data
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
                        
                        self.allLeagueGroups = [self.groupA,self.groupB,self.groupC,self.groupD,self.groupE,self.groupF,self.groupG,self.groupH]
                    }
                    
                }
            }
            
        }
        
    }
    
    
}


extension ChampionsLeagueViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLeagueGroups[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = championsLeagueTableView.dequeueReusableCell(withIdentifier: "ChampionsLeagueCell", for: indexPath)
        let league = allLeagueGroups[indexPath.section]
        let groupToDisplay = league.sorted{$0.overall_league_PTS > $1.overall_league_PTS}[indexPath.row]
        cell.textLabel?.text = groupToDisplay.team_name
        cell.detailTextLabel?.text = groupToDisplay.overall_league_PTS
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return allLeagueGroups.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if allLeagueGroups[section].count != 0 {
        return allLeagueGroups[section][0].league_name
        } else {
            return ""
        }
}
}
