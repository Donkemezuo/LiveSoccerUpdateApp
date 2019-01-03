//
//  SoccerLeaguesModel.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 12/29/18.
//  Copyright © 2018 EnProTech Group. All rights reserved.
//

import Foundation

struct Soccer: Codable {
    var soccerLeagues: [Leagues]
}

struct Leagues: Codable {
    var country_id: String
    var country_name: String
    var league_id: String
    var league_name: String
}
