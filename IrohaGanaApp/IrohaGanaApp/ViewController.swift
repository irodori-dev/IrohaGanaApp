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
    
    @IBOutlet private weak var _inputTextView: UITextView!

    @IBOutlet private weak var _resultTextLabel: UILabel!

    @IBOutlet private weak var _creditImage: UIImageView!

    
    //MARK: -- lifecycle ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupViews()
    }


    //MARK: -- private method ------------------------------

    private func _setupViews() {
        let url: URL? = URL(string: "http://u.xgoo.jp/img/sgoo.png")
        do {
            let data: Data = try Data(contentsOf: url!)
            let image: UIImage? = UIImage(data: data)
            self._creditImage.image = image
         } catch let err {
            print("🚨 error : \(err.localizedDescription)")
         }
        
        self._inputTextView.layer.borderColor = UIColor.magenta.cgColor
        self._inputTextView.layer.borderWidth = 1.0
        self._inputTextView.layer.cornerRadius = 8.0
        self._inputTextView.layer.masksToBounds = true
        
        self._setupKeyboard()
    }
    
    private func _setupKeyboard() {

        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        kbToolBar.barStyle = UIBarStyle.default
        kbToolBar.sizeToFit()

        let space = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: self,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.done,
            target: self, action: #selector(_doneButtonTapped)
        )
         
        kbToolBar.items = [space, doneButton]

        self._inputTextView.inputAccessoryView = kbToolBar
    }
    
    @objc private func _doneButtonTapped() {
        self.view.endEditing(true)
        
        HiraganaAPI.GetRubyString(
            text: _inputTextView.text,
            callback: {[weak self] (success:Bool, resultText: String) -> Void in
                if success == true {
                    DispatchQueue.main.async {
                        self?._resultTextLabel.text = resultText
                    }
                }
            }
        )
    }
}
