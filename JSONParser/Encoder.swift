//
//  Encoder.swift
//  JSONParser
//
//  Created by Andrew on 11/10/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Foundation

struct Movie: Codable {
    enum MovieGenere: String, Codable {
        case horror, skifi, comedy, adventure, animation
    }
    
    var name : String
    var moviesGenere : [MovieGenere]
    var rating : Int
}

let upMovie = Movie(name: "Up", moviesGenere: [.comedy , .adventure, .animation], rating : 4)

func encodeJSON() -> Data? {
    do {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(upMovie)
        let jsonString = String(data: jsonData, encoding: .utf8)
        print("JSON String : " + jsonString!)
        return jsonData
    }
    catch let error {
        print("Error: ", error)
        return nil
    }
//    return nil
}

func decodeJSON(jsonData: Data) {
    do {
        let jsonDecoder = JSONDecoder()
        let movie = try jsonDecoder.decode(Movie.self, from: jsonData)
        print("Name : \(movie.name)")
        print("Rating : \(movie.rating)")
    }
    catch let error {
        print("Error: ", error)
    }
}


