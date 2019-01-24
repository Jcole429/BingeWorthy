//
//  HomeController.swift
//  BingeWorthy
//
//  Created by Justin Cole on 1/21/19.
//  Copyright © 2019 Jcole. All rights reserved.
//

import UIKit
import SnapKit

class HomeController : UIViewController {
    override func viewDidLoad() {
        self.title = "BingeIt"
        
        let wrap = UIView()
        self.view.addSubview(wrap)
        wrap.snp.makeConstraints { make in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        
        let popularButton = UIButton()
        wrap.addSubview(popularButton)
        popularButton.backgroundColor = UIColor.black
        popularButton.setTitle("Popular Movies", for: .normal)
        popularButton.addTarget(self, action: #selector(self.loadPopular), for: .touchUpInside)
        popularButton.snp.makeConstraints { make in
            make.left.equalTo(wrap)
            make.top.equalTo(wrap)
            make.right.equalTo(wrap)
        }
        
        let newButton = UIButton()
        self.view.addSubview(newButton)
        newButton.backgroundColor = UIColor.black
        newButton.setTitle("New Releases", for: .normal)
        newButton.addTarget(self, action: #selector(self.loadNew), for: .touchUpInside)
        self.view.addSubview(newButton)
        newButton.snp.makeConstraints { make in
            make.left.equalTo(wrap)
            make.bottom.equalTo(wrap)
            make.right.equalTo(wrap)
            make.top.equalTo(popularButton.snp.bottom).offset(10)
        }
    }
    
    @objc func loadPopular(sender: UIButton) {
        let listController = DiscoverHomeController(sortType: .popularity)
        self.navigationController?.pushViewController(listController, animated: true).self
    }
    
    @objc func loadNew(sender: UIButton) {
        let listController = DiscoverHomeController(sortType: .releaseDate)
        self.navigationController?.pushViewController(listController, animated: true)
    }
}
