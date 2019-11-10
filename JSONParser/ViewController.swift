//
//  ViewController.swift
//  JSONParser
//
//  Created by Andrew on 11/10/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJSON(from: "https://andrew11us.github.io/data.json")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            self.label.text = self.users[0].title
        }
    }
    
    func parseJSON(from: String) {
        
        // Getting JSON page URL
        guard let url = URL(string: from) else { return }
        
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
                
                // MARK: add code to acquire data from JSON array
                print(jsonArray)
                for item in jsonArray {
                    self.users.append(User(item))
                }
                // parse users using compactMap
                self.users = jsonArray.compactMap{ (dictionary)  in
                    return User(dictionary)
                }
                
                
            } catch let parsingError {
                print("Error: ", parsingError)
            }
        }
        task.resume()
    }
    
    
    
}

