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
    
    var sportsArticle: SportArticles?
    
    
    var sportNews = [SportArticles]()

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsHeadLine: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsPublishedDate: UILabel!
    @IBOutlet weak var NewsContent: UITextView!
    @IBOutlet weak var linkToFullNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailView()
    }
    
    func setDetailView(){
        if let article = sportsArticle {
            self.newsHeadLine.text = article.title
            
            newsSource.text = "Source: \(article.source.name)"
            newsAuthor.text = "Author: \(article.author)"
            newsPublishedDate.text = "Published Date: \(article.publishedAt)"
             NewsContent.text = article.content
            linkToFullNews.text = "Link to full article \( article.url ?? "no link")"
            ImageHelper.shared.fetchImage(urlString: article.urlToImage.absoluteString ) { (error, data) in
                if let error = error {
                    print("Error: \(error)")
                } else if let image = data {
                    self.newsImage.image = image
                }
            }
        }
    
        
      
        }
    
        
        
    }
    
    
    


