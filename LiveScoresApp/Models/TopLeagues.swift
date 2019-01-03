//
//  TopLeagues.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 12/29/18.
//  Copyright © 2018 EnProTech Group. All rights reserved.
//

import Foundation

struct TopLeagues:Codable {
    var leagues: [TopLeaguesDetails]
}
struct TopLeaguesDetails: Codable {
    var country_id: String
    var country_name: String
}





