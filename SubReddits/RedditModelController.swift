//
//  RedditModelController.swift
//  SubReddits
//
//  Created by Jeff Norton on 8/29/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import Foundation

class RedditModelController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    static let baseURL = NSURL(string: "http://www.reddit.com/.json")
    static let apiKey = "7b2b5b9ad167c9ae42d676ce275982d8"
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func getSubReddits(searchTerm: String, completion: (() -> Void)? = nil) {
        
        // Unwrap the URL and process the URL Parameters
        
        guard let url = baseURL else { return }
        
        let urlParameters = ["q": searchTerm, "appid": apiKey]
        
        // Make the network request
        NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            
            guard let data = data
                , responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                , jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : AnyObject]
                else { return }
            
            print("jsonDictionary = \(jsonDictionary)")
            
//            if error != nil {
//                
//                print("Error: \(error)")
//                completion?(weather: nil)
//            } else if responseDataString.containsString("error") {
//                
//                print("Error: \(responseDataString)")
//                completion?(weather: nil)
//            } else {
//                
//                dispatch_async(dispatch_get_main_queue(), {
//                    print("Get succeeded")
//                    
//                    let weather = Weather(dictionary: jsonDictionary)
//                    
//                    print("weather = \(weather?.descriptionString)")
//                    
//                    if let completion = completion {
//                        
//                        completion()
//                    }
//                })
//            }
        }
    }
    
}