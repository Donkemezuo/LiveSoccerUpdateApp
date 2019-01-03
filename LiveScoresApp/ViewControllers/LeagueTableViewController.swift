//
//  LeagueTableViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/1/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class LeagueTableViewController: UIViewController {
    
       var topLeagues = ["Premier League", "Champions League", "Europa League", "Spanish League", "Bundesliga","Italy"]

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueTableView: UITableView!
    
    var leagueStanding = [TeamStandings]() {
        didSet {
            leagueTableView.reloadData()
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTableView.dataSource = self
        getData()
        title = "Premier League Table"
    
        backgroundView()
    }
    
    func getData() {
        SoccerLiveAPIClient.premierLeagueTable { (error, leagueStanding) in
            if let error = error {
                print("Error: \(error)")
            } else if let leagueStanding = leagueStanding{
                DispatchQueue.main.async {
                    self.leagueStanding = leagueStanding
                }
                
            }
        }
    }
    
    func backgroundView(){
        leagueImage.image = UIImage.init(named: "ELPLogo")
    }
    
}



extension LeagueTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueStanding.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard
            let cell = leagueTableView.dequeueReusableCell(withIdentifier: "LeagueTableCell", for: indexPath)
            //as? LeagueTableViewCell else {return UITableViewCell()}
        
        let leagueStandings = leagueStanding[indexPath.row]
        cell.detailTextLabel?.text = "Points: \( leagueStandings.overall_league_PTS)"
        cell.textLabel?.text = leagueStandings.team_name
        return cell
    }
    
    
}
