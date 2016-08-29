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
    
    static let parentDataKey = "data"
    static let childrenKey = "children"
    static let childElementDataKey = "data"
    static let titleKey = "title"
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func getSubReddits(searchTerm: String, completion: ((results: [String]?) -> Void)? = nil) {
        
        // Unwrap the URL and process the URL Parameters
        
        guard let url = baseSubRedditURL?.URLByAppendingPathComponent(searchTerm).URLByAppendingPathExtension("json") else { return }
        
        // Make the network request
        NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: nil) { (data, error) in
            
            guard let data = data
                , responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                , jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : AnyObject]
                else { return }
            
            print("\njsonDictionary = \(jsonDictionary)")
            
            guard let dataDictionary = jsonDictionary[RedditModelController.parentDataKey] as? [String : AnyObject] else { return }
            
            print("\n\ndataDictionary = \(dataDictionary)")
            
            guard let childrenDictionaryArray = dataDictionary[childrenKey] as? [[String: AnyObject]] else { return }
            
            print("\n\nchildrenDictionaryArray = \(childrenDictionaryArray)")
            
            var titlesArray = [String]()
            for child in childrenDictionaryArray {
                
                guard let elementDictionary = child[RedditModelController.childElementDataKey] as? [String : AnyObject]
                    , title = elementDictionary[RedditModelController.titleKey] as? String
                    else { break }
                
                titlesArray.append(title)
            }
            
            print("titlesArray = \(titlesArray)")
            
            if error != nil {
                
                print("Error: \(error)")
                
                if let completion = completion {
                    completion(results: nil)
                }
                
            } else if responseDataString.containsString("error") {
                
                print("Error: \(responseDataString)")
                
                if let completion = completion {
                    completion(results: nil)
                }
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), {
                    print("Get succeeded")
                    
                    if let completion = completion {
                        
                        completion(results: titlesArray)
                    }
                })
            }
        }
    }
    
}