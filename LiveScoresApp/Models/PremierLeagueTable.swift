//
//  PremierLeagueTable.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 12/29/18.
//  Copyright © 2018 EnProTech Group. All rights reserved.
//

import Foundation


struct PremierLeagueTable: Codable {
    var leagueTable:[TeamStandings]
}

struct TeamStandings: Codable {
    var league_id: String
    var league_name: String
    var team_name: String
    var overall_league_position: String
    var overall_league_payed: String
    var overall_league_W: String
    var overall_league_D: String
    var overall_league_L: String
    var overall_league_PTS: String
    var overall_league_GF: String
    var overall_league_GA: String
}
