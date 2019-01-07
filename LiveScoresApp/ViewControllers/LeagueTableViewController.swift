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
    
    var leagueEvent = [Events](){
        didSet{
            DispatchQueue.main.async {
                self.leagueTableView.reloadData()
                
            }
        }
    }
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTableView.dataSource = self
        getData()
        title = "Premier League Table"
        backgroundView()
        getEventsData()
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
    
    func getEventsData(){
        SoccerLiveAPIClient.premierLeagueEvents { (appError, leagueEvents) in
            if let appError = appError{
                print("Error: \(appError)")
            } else if let leagueEvents = leagueEvents {
                self.leagueEvent = leagueEvents
                
            }
            
        }
    }
    
    
    func backgroundView(){
        leagueImage.image = UIImage.init(named: "ELPLogo")
    }
    
    
    @IBAction func Back(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let centralView = storyBoard.instantiateViewController(withIdentifier: "mainVC") as! ViewController
        present(centralView, animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let eventIndexPath = leagueTableView.indexPathForSelectedRow, let eventsDetails = segue.destination as? PremierLeagueDetailViewViewController else {return}
        let event = leagueEvent[eventIndexPath.row]
        eventsDetails.leagueEventt = event
    }
    
    
}

extension LeagueTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueStanding.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = leagueTableView.dequeueReusableCell(withIdentifier: "LeagueTableCell", for: indexPath)
        
        let leagueStandings = leagueStanding.sorted{$0.overall_league_PTS > $1.overall_league_PTS}[indexPath.row]
        cell.detailTextLabel?.text = "Points: \( leagueStandings.overall_league_PTS)"
        cell.textLabel?.text = leagueStandings.team_name
        return cell
    }
    
}
