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
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data, error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                       dataResponse, options: [])
//                print(jsonResponse)
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                      return
                }
//                print(jsonArray)
                
                guard let title = jsonArray[0]["title"] as? String else { return }
                print(title) 
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        

    }


}

