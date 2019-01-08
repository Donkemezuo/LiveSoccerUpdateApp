//
//  PremierLeagueDetailViewViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/5/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class PremierLeagueDetailViewViewController: UIViewController {
    @IBOutlet weak var datePickerView: UIPickerView!
    
    var leagueEventt: TeamStandings!

    var names = ["Raymond","Lion","Legend","Living"]
    
    var teamStandingg = [TeamStandings]()
    var upcomingMatches = [Events]()
    var date = [String]() {
        didSet {
            
        }
    }

    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamHomeWins: UILabel!
    @IBOutlet weak var teamAwayWins: UILabel!
    @IBOutlet weak var teamHomeDraws: UILabel!
    @IBOutlet weak var teamAwayDraws: UILabel!
    @IBOutlet weak var teamHomeLoss: UILabel!
    @IBOutlet weak var teamAwayLoss: UILabel!
    @IBOutlet weak var teamGF: UILabel!
    @IBOutlet weak var teamGA: UILabel!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getLeagueData()
        setDetailView()
        getUpcomingMatches()
        datePickerView.delegate = self
        datePickerView.dataSource = self
   
    }
    
    
    func getLeagueData(){
        SoccerLiveAPIClient.premierLeagueTable { (error, teamStandings) in
            if let error = error {
                print("Error: \(error)")
            } else if let teamStanding = teamStandings {
                self.teamStandingg = teamStanding
            }
        }
    }
    
    
    func setDetailView(){
        teamName.text = "\(leagueEventt.team_name) FC"
        teamHomeWins.text = "Home Wins: \(leagueEventt.home_league_W)"
        teamAwayWins.text = "Away Wins: \(leagueEventt.away_league_W)"
        teamHomeDraws.text = "Home Draws: \(leagueEventt.home_league_D)"
        teamAwayDraws.text = "Away Draws:\(leagueEventt.away_league_D)"
        teamHomeLoss.text = "Home Loss: \(leagueEventt.home_league_L)"
        teamAwayLoss.text = "Away Loss: \(leagueEventt.away_league_L)"
        teamGF.text = "Season Goals: \(leagueEventt.overall_league_GF)"
        teamGA.text = "Goals Conseded: \(leagueEventt.overall_league_GF)"
        
        switch leagueEventt.team_name {
        case "Liverpool":
            teamImage.image = UIImage.init(named: "liv")
        case "Manchester City":
            teamImage.image = UIImage.init(named: "man")
        case "Tottenham Hotspur":
            teamImage.image = UIImage.init(named: "tot")
        case "Chelsea":
            teamImage.image = UIImage.init(named: "chel")
        case "Arsenal":
            teamImage.image = UIImage.init(named: "ar")
        case "Manchester United":
            teamImage.image = UIImage.init(named: "maU")
        case "Leicester City":
            teamImage.image = UIImage.init(named: "lei")
        case " watford":
            teamImage.image = UIImage.init(named: "wat")
        case "Wolverhampton Wanderers":
            teamImage.image = UIImage.init(named: "wol")
        case "West Ham United":
            teamImage.image = UIImage.init(named: "wes")
        case "Everton":
            teamImage.image = UIImage.init(named: "eventon")
        case "AFC Bournemouth":
            teamImage.image = UIImage.init(named: "afc")
        case "Brighton &amp; Hove Albion":
            teamImage.image = UIImage.init(named: "bri")
        case "Crystal Palace":
            teamImage.image = UIImage.init(named: "crystal")
        case "Newcastle United":
            teamImage.image = UIImage.init(named: "new")
        case "Burnley":
            teamImage.image = UIImage.init(named: "burn")
        case "Cardiff City":
            teamImage.image = UIImage.init(named: "cardif")
        case "Southampton":
            teamImage.image = UIImage.init(named: "south")
        case "Fulham":
            teamImage.image = UIImage.init(named: "full")
        case "Huddersfield Town":
            teamImage.image = UIImage.init(named: "hudder")

        
        default:
            print("Team has no image")
        
        
        
        }
        
        

    }
    
    
    
    func getUpcomingMatches(){
        
        SoccerLiveAPIClient.premierLeagueEvents { (error, matchDay) in
            if let error = error{
                print("Error: \(error)")
            } else if let matchDay = matchDay{
                for Date in matchDay {
                    if !self.date.contains(Date.match_date){
                    self.date.append(Date.match_date)
                }
            }
        }
        }
        
    }
   


}

extension PremierLeagueDetailViewViewController: UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return date.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return date[row]
    }
    
    
}
