//
//  SoccerLiveAPIClient.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 12/29/18.
//  Copyright © 2018 EnProTech Group. All rights reserved.
//

import Foundation

final class SoccerLiveAPIClient {
    
    static func soccerLeagues(completionHandler: @escaping (Error?,[TopLeaguesDetails]?) -> Void){
        let urlString = "https://apifootball.com/api/?action=get_leagues&country_id=&APIkey=\(SecretKeys.APIKey)"
        NetworkHelper.performDataTask(urlString: urlString, httpMethod:"GET") { (error, data) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let topLeagues = try JSONDecoder().decode([TopLeaguesDetails].self, from: data)
                    completionHandler(nil,topLeagues)
                    print("Number of leagues = \(topLeagues.count)")
                } catch {
                    completionHandler(error, nil)
                    print("decoding error: \(error)")
                }
            }
        }
    }
    
    static func preferedLeagues(completionHandler: @escaping (Error?, [PreferedLeagueDetails]?) -> Void){
        let urlString = "https://apifootball.com/api/?action=get_leagues&APIkey=\(SecretKeys.APIKey)"
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let preferedLeagues = try JSONDecoder().decode([PreferedLeagueDetails].self, from: data)
                    completionHandler(nil, preferedLeagues)
                    print("Number of leagues = \(preferedLeagues.count)")
                } catch {
                    completionHandler(error, nil)
                }
            }
        }
    }
    
    
    static func premierLeagueTable(completionHandler: @escaping(Error?,[TeamStandings]?) -> Void){
        let urlString = "https://apifootball.com/api/?action=get_standings&league_id=62&APIkey=\(SecretKeys.APIKey)"
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let leagueTable = try JSONDecoder().decode([TeamStandings].self, from: data)
                    completionHandler(nil, leagueTable)
                    print("League standing is \(leagueTable.count)")
                } catch {
                    completionHandler(error, nil)
                }
            }
        }
    }
    
    static func championsLeague(completionHandler: @escaping (Error?, [ChampionsLeagueGroups]?) -> Void){
        let urlString = "https://apifootball.com/api/?action=get_leagues&country_id=163&APIkey=\(SecretKeys.APIKey)"
        
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let championsLeagueGroups = try JSONDecoder().decode([ChampionsLeagueGroups].self, from: data)
                    completionHandler(nil, championsLeagueGroups)
                } catch {
                    completionHandler(error,nil)
                }
            }
        }
    }
    
    static func championsLeagueGroupTable(groupID:String, completionHandler: @escaping(Error?,[GroupStats]?) -> Void){
        let urlString = "https://apifootball.com/api/?action=get_standings&league_id=\(groupID)&APIkey=\(SecretKeys.APIKey)"
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                dump(data)
                do{
                    let groups = try JSONDecoder().decode([GroupStats].self, from: data)
                    completionHandler(nil, groups)
                } catch {
                    completionHandler(error, nil)
                }
            }
        }
    }
    
}
