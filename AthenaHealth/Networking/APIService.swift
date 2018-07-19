//
//  APIService.swift
//  AthenaHealth
//
//  Created by Saurabh Gupta on 19/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    static let standard = APIService()
    
    private func request(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders?, completionHandler: @escaping ([String: Any]?, Error?) -> Void) {
        let request = Alamofire.request(url, method: method, parameters: parameters, headers: headers).responseJSON { (response) in
            guard response.result.isSuccess else {
                completionHandler(nil, response.result.error)
                
                return
            }
            
            guard let value = response.result.value as? [String: Any] else {
                completionHandler(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Malformed data received"]))
                
                return
            }
            
            completionHandler(value, nil)
        }
        debugPrint(request)
    }

    func getRecords(completionHandler: @escaping ((Record?, Error?) -> Void)) {
        let url = "https://gist.githubusercontent.com/omkarImagene/74626336e35b3ff27aea6a26543778bf/raw/56e5af11a8e15fa67c056dbbcc67f4695eb6fa5e/Assignment"
        
        request(url: url, method: .get, parameters: nil, headers: nil) { (response, error) in
            if let error = error {
                completionHandler(nil, error)
                
                return
            }
            
            if let response = response {
                let statusCode = response["statusCode"] as? String
                let statusMessage = response["statusMessage"] as? String
                if statusCode != "SCS" && statusMessage != "Success" {
                    completionHandler(nil, NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Response"]))
                    
                    return
                }
        
                let value = response["reply"]
                do {
                    let data = try JSONSerialization.data(withJSONObject: value as Any, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    var records = try decoder.decode(Record.self, from: data)
                    
                    completionHandler(records, nil)
                } catch let error {
                    print("Error: ", error)
                    completionHandler(nil, error)
                }
            }
        }
    }
}
