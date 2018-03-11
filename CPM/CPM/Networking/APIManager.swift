//
//  APIManager.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    static let shared = APIManager()
    private var session = URLSession(configuration: .default)
    private let baseUrl = "https://api.github.com/"
    //Using static OAuth Token for demo purposes. This token would be acquired via login flow that is defined by whatever the service requirements are
    private let testAPIToken = "0e3e6e10d8e05bbc228462d260b29a733cedf990"
    
    //MARK: - Search
    private var searchTask: URLSessionDataTask?
    private let searchPath = "search/repositories"
    func searchForReposWith(username:String?, completion:(([CPRepository]?,CPError?)->())?){
        searchTask?.cancel()
        if var urlComponents = URLComponents(string: baseUrl+searchPath){
            urlComponents.query = "q=user:\(username ?? "")"
            guard let url = urlComponents.url else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("Bearer \(testAPIToken)", forHTTPHeaderField: "Authorization")
            
            searchTask = session.dataTask(with: urlRequest){ data, response, error  in
                if error != nil{
                    completion?(nil,CPError(title: "Data Task Error", message: error?.localizedDescription, code: nil))
                }else if let data = data, let response = response as? HTTPURLResponse{
                    if response.statusCode == 200{
                        do{
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any?]
                            completion?(CPRepository.arrayOfRepositoriesWith(array: jsonResponse?["items"] as? [[String:Any?]]),nil)
                        }catch{
                            completion?(nil,CPError(title: "JSON Error", message: error.localizedDescription, code: nil))
                        }
                    }else{
                        completion?(nil,CPError(title: "HTTP Error", message: nil, code: response.statusCode))
                    }
                }
            }
        }
        searchTask?.resume()
    }
}
