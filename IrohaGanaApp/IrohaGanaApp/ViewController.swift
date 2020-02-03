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
    
    @IBOutlet private weak var _creditImage: UIImageView!
    
    //MARK: -- lifecycle ------------------------------

    override func viewDidLoad() {

        super.viewDidLoad()

        // TODO 🐷 zantei
        HiraganaAPI.GetRubyString()

        self._setupViews()
    }

    //MARK: -- private method ------------------------------

    private func _setupViews() {
        let url = URL(string: "http://u.xgoo.jp/img/sgoo.png")
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            self._creditImage.image = image
         }catch let err {
            print("🚨 error : \(err.localizedDescription)")
         }
    }
}
