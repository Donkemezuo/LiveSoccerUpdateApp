//
//  NetworkHelper.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 12/29/18.
//  Copyright © 2018 EnProTech Group. All rights reserved.
//

import Foundation

final class NetworkHelper{
    static func performDataTask(urlString:String,httpMethod:String, completionHandler: @escaping (Error?, Data?) -> Void) {
        guard let url = URL.init(string: urlString) else {
            print("badUrl: \(urlString)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completionHandler(error, nil)
            }
            
            if let response = response as? HTTPURLResponse{
                print(" response statuse is \(response.statusCode)")
            }
            if let data = data {
                completionHandler(nil, data)
            }
            
            }.resume()
    }
}
