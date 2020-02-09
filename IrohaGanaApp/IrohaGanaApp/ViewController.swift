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
class ViewController: UIViewController, RubyViewDelegate {
    
    //MARK: -- IBOutlet ------------------------------

    @IBOutlet weak var _checkRubyView: CheckRubyView!
    
    //MARK: -- properties ------------------------------

    private var _activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    //MARK: -- lifecycle ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupViews()

        if UserDefaults.standard.bool(forKey: "is_show_coachmark") == false {
            UserDefaults.standard.set(true, forKey: "is_show_coachmark")
            self._showCoachMark()
        }
    }
    
    //MARK: -- public method ------------------------------

    func requestRuby(text: String) {
        self.view.isUserInteractionEnabled = false
        self._activityIndicatorView.startAnimating()

        HiraganaAPI.RequestRuby(
            text: text,
            callback: {[weak self] (success:Bool, ruby: String) -> Void in
                
                DispatchQueue.main.async {
                    self?._activityIndicatorView.stopAnimating()
                    self?.view.isUserInteractionEnabled = true

                    if success == true {
                        self?._checkRubyView.showRuby(ruby: ruby)
                    } else {
                        self?._showAlert(title: "エラー", message: "ルビの取得に失敗しました")
                    }
                }
            }
        )
    }

    private func _showAlert(title:String, message:String) {
        let alertController = UIAlertController(
            title: "",
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil)
        )
        self.present(alertController, animated: true)
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
            action: #selector(coachMarkButtonTapped(_:))
        )
        
        self._activityIndicatorView.center = view.center
        self._activityIndicatorView.color = IrohaGanaColor.SHINKU
        self.view.addSubview(self._activityIndicatorView)

        self._checkRubyView.delegate = self
    }
    
    private func _showCoachMark()  {
        let storyboard: UIStoryboard = UIStoryboard(name: "CoarchMark", bundle: nil)
        let coarchMark: CoarchMarkViewController = storyboard.instantiateViewController(identifier: "coarchMark") as! CoarchMarkViewController
        
        coarchMark.modalPresentationStyle = .overFullScreen
        coarchMark.modalTransitionStyle = .crossDissolve
        
        self.present(coarchMark, animated: false, completion: nil)
    }
    
    @objc func coachMarkButtonTapped(_ sender: UIBarButtonItem) {
        self._showCoachMark()
    }
}
