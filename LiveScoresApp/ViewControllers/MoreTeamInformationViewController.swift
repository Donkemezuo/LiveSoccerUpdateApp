//
//  MoreTeamInformationViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/10/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class MoreTeamInformationViewController: UIViewController {
    @IBOutlet weak var monthlyMatches: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    var date:String?
    var teamName: String?
    var gamesForTheMonth = [Events]() {
        didSet{
            DispatchQueue.main.async {
                self.monthlyMatches.reloadData()
                
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
       monthlyMatches.dataSource = self
        monthlyMatches.delegate = self
        setImage()
    }

    func getMatchDates() -> (String,String) {
    
        switch date {
        case "August":
            return ("2018-08","2018-09")
        case "September":
            return("2018-09","2018-10")
        case "October":
            return("2018-10","2018-11")
        case "November":
            return ("2018-11","2018-12")
        case "December":
            return("2018-12","2019-01")
        case "January":
            return("2019-01","2019-02")
            
        case "February":
            return("2019-02","2019-03")
        case "March":
            return ("2019-03","2019-04")
        case "April":
            return ("2019-04","2019-05")
        case "May":
            return ("2019-05","2019-06")
        case "June":
            return ("2019-06","2019-07")
        case "July":
            return ("2019-07","2019-08")
            
        default:
            return ("League is over for the season","Starting soon")
        }
    }
    
    func setImage(){
        image.image = UIImage.init(named: "elp")
    }
    
    
    func getData(){
        let formattedDate = getMatchDates()
        SoccerLiveAPIClient.premierLeagueMatches(FromDate: formattedDate.0, ToDate: formattedDate.1) { (error, date) in
            if let error = error {
                print("Error:\(error)")
            } else if let date = date {
                self.gamesForTheMonth = date.filter{$0.match_hometeam_name == self.teamName || $0.match_awayteam_name == self.teamName}
            }
        }
    }
    
}

extension MoreTeamInformationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesForTheMonth.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = monthlyMatches.dequeueReusableCell(withIdentifier: "MonthlyCell", for: indexPath)
        let month = gamesForTheMonth[indexPath.row]
        cell.textLabel?.text = "\(month.match_hometeam_name) VS \(month.match_awayteam_name)"
        cell.detailTextLabel?.text = month.match_date
        return cell
    }
}

extension MoreTeamInformationViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
