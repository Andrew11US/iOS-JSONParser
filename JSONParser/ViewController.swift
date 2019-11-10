//
//  ViewController.swift
//  JSONParser
//
//  Created by Andrew on 11/10/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting JSON page URL
        guard let url = URL(string: "https://andrew11us.github.io/data.json") else { return }
        
        // Setting up URLSessioin
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Checking if dataResponse in not empty
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do {
                // Try JSONSerializatioin to get JSON object
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                // Downcasting JSON to [String:Any] array
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                // Trying to acquire data from first element of an array for a key "title"
                guard let title = jsonArray[0]["title"] as? String else { return }
                print(title)
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        
    }
    
    
}

