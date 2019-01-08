//
//  SportNewsDetailViewViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/7/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class SportNewsDetailViewViewController: UIViewController {
    var sportNewsDetails: SportNews!{
        didSet {
            DispatchQueue.main.async {
                
            }
        }
    }
    
    var sportNews: SportArticles!

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsHeadLine: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsPublishedDate: UILabel!
    @IBOutlet weak var NewsContent: UITextView!
    @IBOutlet weak var linkToFullNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getEventDetail()
        setDetailView()
        // Do any additional setup after loading the view.
    }
    
    func getEventDetail(){
        SoccerLiveAPIClient.sportNews {(error, sportNews) in
            if let error = error {
                print("Error: \(error)")
            } else if let sportNews = sportNews {
                self.sportNewsDetails = sportNews
                
            }
        }
        
      
    }
    
    
    
    func setDetailView(){
        
        for news in (sportNewsDetails.articles){
            sportNews = news
            newsHeadLine.text = sportNews.title
            newsSource.text = sportNews.source.name
            newsAuthor.text = sportNews.author
            newsPublishedDate.text = sportNews.publishedAt
            NewsContent.text = sportNews.content
            linkToFullNews.text = sportNews.url
        }
        
        
        
    }
    
    
    

}
