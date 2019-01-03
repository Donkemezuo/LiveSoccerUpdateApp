//
//  ViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 12/29/18.
//  Copyright © 2018 EnProTech Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leaguesCollection: UICollectionView!
   
    @IBOutlet weak var imageScrolView: UIScrollView!
 
    
    
    var topLeagues = ["Premier League", "Champions League", "Europa League", "Spanish League", "Bundesliga","Italy"]

    
    
    
    var myPreferedLeagues: Set<String> = [] {
        didSet {
            DispatchQueue.main.async {
                self.leaguesCollection.reloadData()
            }
        }

    }
    
    private var allMyLeagues = [PreferedLeagueDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.leaguesCollection.reloadData()
            }
        }
    }
    
    private var premierLeagueTeams = [TeamStandings](){
        didSet {
            DispatchQueue.main.async {
                self.leaguesCollection.reloadData()
            }
        }
    }
    
    
    
    
    
    var leagueStanding = [TeamStandings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesCollection.delegate = self
        leaguesCollection.dataSource = self
        title = "Leagues"
        preferedLeague()
        images = createImages()
        imageScrolView.delegate = self
        setUpScrollView(slide: images)
        SoccerLiveAPIClient.preferedLeagues { (error,data) in
            if let error = error {
                print("error: \(error)")
            } else if data != nil {
                
            }
        }
        
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    
    private func leagueTable (){
        SoccerLiveAPIClient.premierLeagueTable { (error, tableStanding) in
            if let error = error {
                print("Error: \(error)")
            } else if let table = tableStanding {
                self.premierLeagueTeams = table
                

            }
        }
    }
    
    
    var images: [Animation] = []
    
    func createImages() -> [Animation] {
        
        let image1: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image1.imageAnimation.image = UIImage(named: "soccer1")
        
        let image2: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image2.imageAnimation.image = UIImage(named: "soccer2")
        let image3: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image3.imageAnimation.image = UIImage(named: "soccer3")
        let image4: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image4.imageAnimation.image = UIImage(named: "soccer4")
        let image5: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image5.imageAnimation.image = UIImage(named: "soccer5")
        let image6: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image6.imageAnimation.image = UIImage(named: "soccer6")
        let image7: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image7.imageAnimation.image = UIImage(named: "soccer7")
        
        return [image1,image2,image3,image4,image5,image6,image7]
    }
    
    var offset: CGFloat = 0
    
    
    @objc func autoScroll (){
        let totalOffset = CGFloat(createImages().count - 1) * self.view.bounds.size.width
        if offset == totalOffset {
            offset = 0
        } else  {
            offset += self.view.bounds.size.width
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0, delay: 5, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.imageScrolView.contentOffset.x = CGFloat(self.offset)
            }, completion: nil)
        }
    }
    
    
    func setUpScrollView(slide:[Animation]){
        imageScrolView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageScrolView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        imageScrolView.isPagingEnabled = true
        
        for i in 0..<slide.count{
            slide[i].frame = CGRect(x: view.frame.width * CGFloat(i), y:0, width: view.frame.width, height: view.frame.height)
            imageScrolView.addSubview(slide[i])
        }
        
    }
    
    
    private func preferedLeague() {
        SoccerLiveAPIClient.preferedLeagues { (error, preferedLeague) in
            if let error = error {
                print("Error: \(error)")
            } else if let leagues = preferedLeague{
                self.allMyLeagues = leagues
                
                for league in self.allMyLeagues {
                    if self.topLeagues.contains(league.country_name){
                        self.myPreferedLeagues.insert(league.country_name)
                        
                     
                    }
                }
                
                for league in self.allMyLeagues {
                    if self.topLeagues.contains(league.league_name) {
                        self.myPreferedLeagues.insert(league.league_name)
                    }
                }
            }
        }
    }
    
  
}


extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let premireVC = storyboard.instantiateViewController(withIdentifier: "premierLeague") as! LeagueTableViewController
            present(premireVC, animated: true, completion: nil)
            
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let championsLeagueVC = storyboard.instantiateViewController(withIdentifier: "ChampionsLeague") as! ChampionsLeagueViewController
            present(championsLeagueVC, animated: true, completion: nil)
        default:
            print("whoops")
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPreferedLeagues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = leaguesCollection.dequeueReusableCell(withReuseIdentifier: "LeagueCell", for: indexPath) as? LeaguesCollectionViewCell else {return UICollectionViewCell()}
        
        let leagueToSet = myPreferedLeagues.sorted()[indexPath.row]
        cell.backgroundColor = .yellow
        cell.leagueName.text = leagueToSet
        
        return cell
        
    }
    
    
}


