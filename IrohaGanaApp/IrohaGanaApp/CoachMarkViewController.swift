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
    @IBOutlet weak var _navigationBar: UINavigationBar!

    @IBOutlet weak var _inputTextArea: UIView!
    @IBOutlet weak var _rubyTextView: UITextView!
    @IBOutlet weak var _rubyButton: UIButton!
    
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
        
        self._navigationBar.setBackgroundImage(UIImage(), for: .default)
        self._navigationBar.shadowImage = UIImage()
        
        self._inputTextArea.layer.borderColor = UIColor.white.cgColor
        self._inputTextArea.layer.borderWidth = 2.0
        self._inputTextArea.layer.cornerRadius = 16.0
        
        self._rubyTextView.isEditable = false
        self._rubyTextView.isSelectable = false
        
        self._rubyButton.setTitleColor(UIColor.white, for: .normal)
        self._rubyButton.tintColor = UIColor.white
        self._rubyButton.layer.borderColor = UIColor.white.cgColor
        self._rubyButton.layer.borderWidth = 1.0
        self._rubyButton.layer.cornerRadius = 8.0
        self._rubyButton.contentEdgeInsets = UIEdgeInsets.init(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        
        self._rubyButton.isUserInteractionEnabled = false

    }
    
    @objc func screenTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
