//
//  CoachMarkViewController.swift
//  IrohaGanaApp
//
//  Created by aokita on 2020/02/06.
//  Copyright © 2020 irodori. All rights reserved.
//

import UIKit

//
// コーチマーク画面.
//
class CoarchMarkViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: -- IBOutlet ------------------------------

    @IBOutlet var _baseView: UIView!
    

    //MARK: -- lifecycle ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupViews()
    }
    

    //MARK: -- private method ------------------------------

    private func _setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped(_:)))
        tapGesture.delegate = self

        self._baseView.addGestureRecognizer(tapGesture)
    }
    
    @objc func screenTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
