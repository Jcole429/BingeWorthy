//
//  DiscoverHomeController.swift
//  BingeWorthy
//
//  Created by Justin Cole on 1/3/19.
//  Copyright © 2019 Jcole. All rights reserved.
//

import UIKit
import SwiftyJSON

class DiscoverHomeController: UIViewController {
    let movieTableView : UITableView = UITableView()
    
    var movies : [Movie] = [Movie]()

    var sortType : MovieServer.SortType = .popularity
    
    convenience init(sortType : MovieServer.SortType) {
        self.init()
        
        self.sortType = sortType
        
        self.setup()
    }
    
    func setup() {
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        self.movieTableView.register(NewMoviesTableViewCell.self, forCellReuseIdentifier:
        "NewMovieCell")
        self.movieTableView.rowHeight = UITableView.automaticDimension
        self.movieTableView.estimatedRowHeight = 100
        
        self.view.addSubview(self.movieTableView)
        self.movieTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.sortType {
        case .popularity:
            self.title = "Popular Movies"
        case .releaseDate:
            self.title = "New Releases"
        }
        
        self.load()
    }
    
    func load() {
        MovieServer.shared.discover(by: self.sortType, success: { movies in
            self.movies = movies
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }, failure: {
            print("FAILED")
        })
    }
}

extension DiscoverHomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ movieTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ movieTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMovie = movies[indexPath.row]
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "NewMovieCell") as! NewMoviesTableViewCell
        
        cell.setContent(movie: currentMovie)

        return cell
    }

    func tableView(_ movieTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoController = DiscoverInfoController(nibName: nil, bundle: nil)
        infoController.selectedMovie = self.movies[indexPath.item]
        self.navigationController?.pushViewController(infoController, animated: true)
    }
}
