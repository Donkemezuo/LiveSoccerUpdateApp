//
//  LeagueEvents.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 12/29/18.
//  Copyright © 2018 EnProTech Group. All rights reserved.
//

import Foundation



struct LeagueEvents: Codable{
    var actions: [Events]
}

struct Events: Codable{
    var match_id: String
    var country_id: String
    var country_name: String
    var league_id: String
    var league_name: String
    var match_date: String
    var match_status: String
    var match_time: String
    var match_hometeam_name: String
    var match_hometeam_score: String
    var match_awayteam_name: String
    var match_awayteam_score: String
    var match_hometeam_halftime_score: String
    var match_awayteam_halftime_score: String
    var match_hometeam_extra_score: String
    var match_awayteam_extra_score: String
    var match_hometeam_penalty_score: String
    var match_awayteam_penalty_score: String
    var match_hometeam_system: String
    var match_awayteam_system: String
    var match_live: String
    var goalscorer: [GoalScorerInformation]
    var cards: [CardInformation]
    var lineup: Team
    var statistics: Gamestatistics
}

struct GoalScorerInformation: Codable {
    var time: String
    var home_scorer: String
    var score: String
    var away_scorer: String
}

struct CardInformation: Codable{
    var time: String
    var home_fault: String
    var card: String
    var away_fault: String
}

struct Team: Codable {
    var home: LineUpInformation
    var away: LineUpInformation
}

struct LineUpInformation: Codable {
    var starting_lineups :[LineUpDetails]
    var substitutes: [SubstitutionDetails]
    var substitutions: [SubstitutionsInfo]
}
struct LineUpDetails: Codable {
    var lineup_player: String
    var lineup_number: String
    var lineup_position: String
}
struct SubstitutionDetails: Codable {
    var lineup_player: String
    var lineup_number: String
    var lineup_position: String
    
}

struct SubstitutionsInfo: Codable {
    var lineup_player: String
    var lineup_number: String
    var lineup_position: String
    var lineup_time: String
}

struct Gamestatistics: Codable{
    var type: String
    var home: String
    var away: String
}
