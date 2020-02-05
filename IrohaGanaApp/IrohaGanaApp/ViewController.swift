//
//  ViewController.swift
//  IrohaGanaApp
//
//  Created by aokita on 2020/02/03.
//  Copyright © 2020 irodori. All rights reserved.
//

import UIKit

///
/// メイン画面
///
class ViewController: UIViewController {
    
    //MARK: -- IBOutlet ------------------------------

    
    //MARK: -- lifecycle ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupViews()
    }

    //MARK: -- private method ------------------------------

    private func _setupViews() {

        self.navigationController?.navigationBar.barTintColor = IrohaGanaColor.SHINKU
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "HiraKakuProN-W6", size: 18) ?? UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor:UIColor.white
        ]
//        self.navigationController?.navigationBar.barTintColor = UIColor.white
//        self.navigationController?.navigationBar.tintColor = IrohaGanaColor.SHINKU
//        self.navigationController?.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.font: UIFont(name: "HiraKakuProN-W6", size: 18) ?? UIFont.systemFont(ofSize: 18),
//            NSAttributedString.Key.foregroundColor:IrohaGanaColor.SHINKU
//        ]

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks,
            target: self,
            action: #selector(helpBarButtonTapped(_:))
        )
    }
    
    @objc func helpBarButtonTapped(_ sender: UIBarButtonItem) {
        print("🐷 ----- helpBarButtonTapped")
    }
}
