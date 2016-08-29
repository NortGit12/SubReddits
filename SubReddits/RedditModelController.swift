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
    
    static let baseSubRedditURL = NSURL(string: "http://www.reddit.com/r")
    static let apiKey = "7b2b5b9ad167c9ae42d676ce275982d8"
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func getSubReddits(searchTerm: String, completion: ((resultsDict: [String : String]) -> Void)? = nil) {
        
        // Unwrap the URL and process the URL Parameters
        
        guard let url = baseSubRedditURL?.URLByAppendingPathComponent(searchTerm).URLByAppendingPathExtension("json") else { return }
        
        // Make the network request
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            guard let data = data
                , responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                , jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : AnyObject]
                else { return }
            
            print("jsonDictionary = \(jsonDictionary)")
            
            
            
            if error != nil {
                
                print("Error: \(error)")
//                completion?(resultsDict: nil)
                
            } else if responseDataString.containsString("error") {
                
                print("Error: \(responseDataString)")
//                completion?(resultsDict: nil)
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), {
                    print("Get succeeded")
                    
//                    let weather = Weather(dictionary: jsonDictionary)
//                    
//                    print("weather = \(weather?.descriptionString)")
                    
                    if let completion = completion {
                        
//                        completion(resultsDict: dict)
                    }
                })
            }
        }
    }
    
}