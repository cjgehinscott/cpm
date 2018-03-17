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
    
    //MARK: - Login
    private let clientId = "95dc07dac2b48835f6ae"
    private let clientSecret = "9f50232137383acae7bdcb11c1e9b447159cf792"
    private let redirectURI = "cpm://oauth-callback"
    
    func hasAccessToken()->Bool{
        return UserDefaults.standard.string(forKey: kBearerToken) != nil
    }
    
    private func getAccessToken()->String{
        return UserDefaults.standard.string(forKey: kBearerToken) ?? ""
    }
    
    private func setAccessToken(with accessToken:String){
        UserDefaults.standard.set("Bearer \(accessToken)", forKey: kBearerToken)
    }
    
    func launchOauthAuthorization(){
        guard let url = URL.init(string:"https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=repo&state=TEST_STATE") else { return }
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options:[:] , completionHandler: nil)
        }
    }
    /*
     * Handle Authorization redirect from GitHub post
     * @param url (required) url response from Safar web browser with response code
     */
    func handleAuthorizationRedirect(_ url:URL){
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var code:String?
        if let queryItems = components?.queryItems{
            for queryItem in queryItems{
                if (queryItem.name.lowercased() == "code"){
                    code = queryItem.value
                    break
                }
            }
        }
        if let receievedCode = code{
            fetchAccessToken(with: receievedCode)
        }
    }
    
    func fetchAccessToken(with code: String){
        let accessTokenTask: URLSessionTask?
        guard let accessTokenUrl = URL.init(string:"https://github.com/login/oauth/access_token") else{ return }
        let postString = "client_id=\(clientId)&client_secret=\(clientSecret)&code=\(code)"
        var urlRequest = URLRequest(url: accessTokenUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postString.data(using: .utf8)
        urlRequest.httpShouldHandleCookies = true
        accessTokenTask = session.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "nil error description")
                return
            }
            guard let responseString = String(data: data, encoding: .utf8) else { return }
            if let accessToken = OauthHelper.parse(tokenString: responseString){
             self?.setAccessToken(with: accessToken)
            }
        })
        accessTokenTask?.resume()
    }
    
    //MARK: - Search
    private var searchTask: URLSessionDataTask?
    private let searchPath = "search/repositories"
    func searchForReposWith(username:String?, completion:(([CPRepository]?,CPError?)->())?){
        searchTask?.cancel()
        if var urlComponents = URLComponents(string: baseUrl+searchPath){
            urlComponents.query = "q=user:\(username ?? "")"
            guard let url = urlComponents.url else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue(getAccessToken(), forHTTPHeaderField: "Authorization")
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
