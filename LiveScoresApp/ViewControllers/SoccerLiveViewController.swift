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
    @IBOutlet weak var ballImage: UIImageView!
    
    
    
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
    
    private func setCellBackground(){
    ballImage.image = UIImage.init(named: "ball")
    }
    
    
    
    
    
    var leagueStanding = [TeamStandings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesCollection.delegate = self
        leaguesCollection.dataSource = self
        title = "Leagues"
        preferedLeague()
        setCellBackground()
        images = createImages()
        imageScrolView.delegate = self
        setUpScrollView(slide: images)
        SoccerLiveAPIClient.preferedLeagues { (error,data) in
            if let error = error {
                print("error: \(error)")
            } else if data != nil {
                
            }
        }
        
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
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
        let image8: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image8.imageAnimation.image = UIImage(named: "aguero")
        let image9: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image9.imageAnimation.image = UIImage(named: "bolt")
        let image10: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image10.imageAnimation.image = UIImage(named: "crd")
        let image11: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image11.imageAnimation.image = UIImage(named: "mecci")
        let image12: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image12.imageAnimation.image = UIImage(named: "suarez")
        let image13: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image13.imageAnimation.image = UIImage(named: "salah")
        let image14: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image14.imageAnimation.image = UIImage(named: "juveee")
        let image15: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image15.imageAnimation.image = UIImage(named: "ronaldoo")
        let image16: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image16.imageAnimation.image = UIImage(named: "mussa")
        let image17: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image17.imageAnimation.image = UIImage(named: "musaa")
        let image18: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image18.imageAnimation.image = UIImage(named: "ddd")
        let image19: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image19.imageAnimation.image = UIImage(named: "mesci")
        let image20: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image20.imageAnimation.image = UIImage(named: "salahh")
        let image21: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image21.imageAnimation.image = UIImage(named: "messi")
        let image22: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image22.imageAnimation.image = UIImage(named: "suarezz")
        let image23: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image23.imageAnimation.image = UIImage(named: "usain")
        let image24: Animation = Bundle.main.loadNibNamed("BackgroundViewAnimation", owner: self, options: nil)?.first as! Animation
        image24.imageAnimation.image = UIImage(named: "lionnel")
        
        
        return [image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12,image13,image14,image15,image16,image17,image18,image19,image20,image21,image22,image23,image24]
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
            UIView.animate(withDuration: 0, delay: 3, options: UIView.AnimationOptions.curveEaseOut, animations: {
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


extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let premireVC = storyboard.instantiateViewController(withIdentifier: "premierLeague") as! LeagueTableViewController
            navigationController?.pushViewController(premireVC, animated: true)
            
            
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let championsLeagueVC = storyboard.instantiateViewController(withIdentifier: "ChampionsLeague") as! ChampionsLeagueViewController
         navigationController?.pushViewController(championsLeagueVC, animated: true)
        default:
            print("whoops")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 200, height: 200)
    }
    
    
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPreferedLeagues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = leaguesCollection.dequeueReusableCell(withReuseIdentifier: "LeagueCell", for: indexPath) as? LeaguesCollectionViewCell else {return UICollectionViewCell()}
        
        let leagueToSet = myPreferedLeagues.sorted()[indexPath.row]

        cell.leagueName.text = leagueToSet
        
        return cell
        
    }
    
    
}


