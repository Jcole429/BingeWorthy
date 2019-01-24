//
//  MovieServer.swift
//  BingeWorthy
//
//  Created by Justin Cole on 1/21/19.
//  Copyright © 2019 Jcole. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MovieServer : NSObject {
    static let shared = MovieServer()
    
    let apiKey = "371a3c62884c6929f5fe873042af9157"
    let baseUrl = "https://api.themoviedb.org/3"
    
    enum SortType : String {
        case
        releaseDate     = "release_date",
        popularity      = "popularity"
    }
    
    func discover(by sortType : SortType, releaseDate : Date? = nil, success: @escaping ([Movie]) -> Void, failure: @escaping () -> Void) {
        var url = "\(self.baseUrl)/discover/movie?region=US&sort_by=\(sortType.rawValue).desc&api_key=\(self.apiKey)"
        
        if sortType == .releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateStr = dateFormatter.string(from: releaseDate ?? Date())

            url += "&release_date.lte=\(dateStr)"
        }

        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(_):
                if let blob = response.result.value, let json = JSON(blob).dictionary, let jsonMovies = json["results"]?.array {
                    var movies = [Movie]()
                    
                    for jsonMovie in jsonMovies {
                        let movie = Movie(json: jsonMovie)
                        movies.append(movie)
                    }
                
                    success(movies)
                } else {
                    failure()
                }
            case .failure(_):
                failure()
            }
        }
    }
}
