//
//  Movie.swift
//  BingeWorthy
//
//  Created by Justin Cole on 10/14/18.
//  Copyright © 2018 Jcole. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    let id : Int
    let title : String
    let isAdult : Bool
    let popularity : Float
    var voteCount : Int
    var isVideo : Bool
    var voteAverage : Float

    var posterPath : String?
    var overview : String?
    var releaseDate : String?
    var genreIds : [Int]
    var originalTitle : String?
    var originalLanguage : String?
    var backdropPath : String?
    
    init (id : Int, title : String, posterPath : String? = nil, isAdult : Bool = false, overview : String? = nil, releaseDate : String? = nil, genreIds :[Int] = [Int](), originalTitle : String? = nil, originalLanguage : String? = nil, backdropPath : String? = nil, popularity : Float = 0, voteCount : Int = 0, isVideo : Bool = true, voteAverage : Float = 0) {
        self.posterPath = posterPath
        self.isAdult = isAdult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.id = id
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.isVideo = isVideo
        self.voteAverage = voteAverage
    }
    init(json: JSON) {
        self.posterPath = json["poster_path"].string
        self.isAdult = json["adult"].bool ?? false
        self.overview = json["overview"].string
        self.releaseDate = json["release_date"].string
        self.genreIds = (json["genre_ids"].arrayObject as? [Int]) ?? [Int]()
        self.id = json["id"].intValue
        self.originalTitle = json["original_title"].string
        self.originalLanguage = json["original_language"].string
        self.title = json["title"].string ?? "NoName"
        self.backdropPath = json["backdrop_path"].string
        self.popularity = json["popularity"].float ?? 0
        self.voteCount = json["vote_count"].int ?? 0
        self.isVideo = json["video"].bool ?? true
        self.voteAverage = json["vote_average"].float ?? 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.isAdult = aDecoder.decodeBool(forKey: "adult")
        self.isVideo = aDecoder.decodeBool(forKey: "video")
        self.popularity = aDecoder.decodeFloat(forKey: "popularity")
        self.voteCount = aDecoder.decodeInteger(forKey: "vote_count")
        self.voteAverage = aDecoder.decodeFloat(forKey: "vote_average")
        
        let genreIdsStr = aDecoder.decodeObject(forKey: "genre_ids") as! String
        self.genreIds = genreIdsStr.components(separatedBy: ";").compactMap{ Int($0) }
        
        self.posterPath = aDecoder.decodeObject(forKey: "poster_path") as? String
        self.overview = aDecoder.decodeObject(forKey: "overview") as? String
        self.releaseDate = aDecoder.decodeObject(forKey: "release_date") as? String
        self.originalTitle = aDecoder.decodeObject(forKey: "original_title") as? String
        self.originalLanguage = aDecoder.decodeObject(forKey: "original_language") as? String
        self.backdropPath = aDecoder.decodeObject(forKey: "backdrop_path") as? String
    }
}

extension Movie : NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.isAdult, forKey: "adult")
        aCoder.encode(self.isVideo, forKey: "video")
        aCoder.encode(self.popularity, forKey: "popularity")
        aCoder.encode(self.voteCount, forKey: "vote_count")
        aCoder.encode(self.voteAverage, forKey: "vote_average")
        
        let genreIdsStr = genreIds.map { String($0) }.joined(separator: ";")
        aCoder.encode(genreIdsStr, forKey: "genre_ids")
        
        if let posterPath = self.posterPath {
            aCoder.encode(posterPath, forKey: "poster_path")
        }
        if let overview = self.overview {
            aCoder.encode(overview, forKey: "overview")
        }
        if let releaseDate = self.releaseDate {
            aCoder.encode(releaseDate, forKey: "release_date")
        }
        if let originalTitle = self.originalTitle {
            aCoder.encode(originalTitle, forKey: "original_title")
        }
        if let originalLanguage = self.originalLanguage {
            aCoder.encode(originalLanguage, forKey: "original_language")
        }
        if let backdropPath = self.backdropPath {
            aCoder.encode(backdropPath, forKey: "backdrop_path")
        }
    }
}
