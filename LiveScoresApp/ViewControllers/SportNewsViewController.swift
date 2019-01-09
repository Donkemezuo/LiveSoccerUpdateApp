//
//  SportNewsViewController.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/7/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class SportNewsViewController: UIViewController {
    @IBOutlet weak var sportNewsTableView: UITableView!
    
    var sportNews: SportNews?{
        didSet {
            DispatchQueue.main.async {
                self.sportNewsTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getSportNews()
    self.sportNewsTableView.dataSource = self
        self.sportNewsTableView.delegate = self
    }
    
    func getSportNews(){
        SoccerLiveAPIClient.sportNews { (appError, sportNews) in
            if let appError = appError {
                print("Error: \(appError)")
            } else if let sportNews = sportNews {
                self.sportNews = sportNews
                dump(self.sportNews)
                
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let news = sportNewsTableView.indexPathForSelectedRow, let newsInfo = segue.destination as? SportNewsDetailViewViewController else {return}
        let newss = sportNews?.articles[news.row]
       newsInfo.sportsArticle = newss
    }

}

extension SportNewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportNews?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sportNewsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? SportNewsCellTableViewCell else {return UITableViewCell()}
        let sportNewss = sportNews?.articles[indexPath.row]
        cell.newsHeadLine.text = sportNewss?.title
        cell.newsDescription.text = "Trending: \(sportNewss!.description)"
        
        ImageHelper.shared.fetchImage(urlString: sportNewss?.urlToImage.absoluteString ?? "") { (error, data) in
            if let error = error {
                print("Error: \(error)")
            } else if let image = data {
                cell.headLineImage.image = image
            }
        }
        return cell
    }
    
    
}

extension SportNewsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
