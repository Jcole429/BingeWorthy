//
//  MovieTableViewCell.swift
//  BingeWorthy
//
//  Created by Justin Cole on 10/14/18.
//  Copyright © 2018 Jcole. All rights reserved.
//

import UIKit
import Haneke
import SnapKit

class NewMoviesTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel
    var releaseDateLabel: UILabel
    var popularityLabel: UILabel
    var movieImageImageView: UIImageView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.titleLabel = UILabel()
        self.releaseDateLabel = UILabel()
        self.popularityLabel = UILabel()
        self.movieImageImageView = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.movieImageImageView)
        
        let wrap = UIView()
        self.contentView.addSubview(wrap)
        
        let format = HNKCacheFormat(name: "original")
        format?.scaleMode = .none
        self.movieImageImageView.hnk_cacheFormat = format
        self.movieImageImageView.contentMode = .scaleAspectFit
        self.movieImageImageView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(5)
            make.top.equalTo(self.contentView).offset(5)
            make.bottom.equalTo(self.contentView).offset(5)
            make.width.equalTo(80)
        }

        wrap.snp.makeConstraints { make in
            make.left.equalTo(self.movieImageImageView.snp.right).offset(5)
            make.right.equalTo(self.contentView).offset(5)
            make.top.equalTo(self.contentView).offset(5)
            make.bottom.equalTo(self.contentView).offset(5)
        }
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.numberOfLines = 0
        wrap.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(wrap)
            make.right.equalTo(wrap)
            make.top.equalTo(wrap)
        }
        
        self.releaseDateLabel.font = UIFont.systemFont(ofSize: 14)
        wrap.addSubview(self.releaseDateLabel)
        self.releaseDateLabel.snp.makeConstraints { make in
            make.left.equalTo(wrap)
            make.right.equalTo(wrap)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
        }
        
        self.popularityLabel.font = UIFont.systemFont(ofSize: 14)
        wrap.addSubview(self.popularityLabel)
        self.popularityLabel.snp.makeConstraints { make in
            make.left.equalTo(wrap)
            make.right.equalTo(wrap)
            make.top.equalTo(self.releaseDateLabel.snp.bottom).offset(5)
            make.bottom.equalTo(wrap).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(movie: Movie){
        if let posterPath = movie.posterPath {
            if let posterUrl = NSURL(string: "http://image.tmdb.org/t/p/w185\(posterPath)"), let url = posterUrl.absoluteURL {
                self.movieImageImageView.hnk_setImage(from: url, placeholder: UIImage(named: "placeholder"), success: { [weak self] (image: UIImage?) in
                    guard let strongSelf = self else { return }
                    
                    if let image = image {
                        strongSelf.movieImageImageView.image = image
                    }
                }, failure: { error in
                    if let error = error {
                        print(error)
                    }
                })
            }
        }
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = "Release Date: \(movie.releaseDate ?? "Unknown")"
        self.popularityLabel.text = "Popularity: \(movie.popularity)"
    }
    
}
