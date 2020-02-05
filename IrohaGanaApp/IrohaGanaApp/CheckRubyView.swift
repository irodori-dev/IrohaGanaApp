//
//  CheckRubyView.swift
//  IrohaGanaApp
//
//  Created by aokita on 2020/02/05.
//  Copyright © 2020 irodori. All rights reserved.
//

import UIKit

class CheckRubyView: UIView {

    //MARK: -- IBOutlet ------------------------------

    @IBOutlet weak var _inputTextArea: UIView!

    @IBOutlet weak var _inputTextView: UITextView!

    @IBOutlet weak var _countLabel: UILabel!
    
    @IBOutlet weak var _outputTextArea: UIView!

    @IBOutlet weak var _rubyTextView: UITextView!
    
    @IBOutlet weak var _creditImage: UIImageView!

    
    //MARK: -- lifecycle ------------------------------

    override init(frame: CGRect) {
        super.init(frame: frame)
        self._loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self._loadNib()
    }
    
    //MARK: -- private method ------------------------------

    private func _loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
        self._setupViews()
    }
    
    private func _setupViews(){
        
        let url: URL? = URL(string: "http://u.xgoo.jp/img/sgoo.png")
        do {
            let data: Data = try Data(contentsOf: url!)
            let image: UIImage? = UIImage(data: data)
            self._creditImage.image = image
         } catch let err {
            print("🚨 error : \(err.localizedDescription)")
         }
        
        self._inputTextArea.layer.borderColor = IrohaGanaColor.SHINKU.cgColor
        self._inputTextArea.layer.borderWidth = 2.0
        self._inputTextArea.layer.cornerRadius = 16.0
        self._inputTextArea.layer.masksToBounds = false
        self._inputTextArea.layer.shadowColor = UIColor.darkGray.cgColor
        self._inputTextArea.layer.shadowOpacity = 0.4
        self._inputTextArea.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self._inputTextArea.layer.shadowRadius = 5
        
        self._rubyTextView.isEditable = false
        self._rubyTextView.isSelectable = false

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
        self.endEditing(true)
        
        HiraganaAPI.GetRubyString(
            text: _inputTextView.text,
            callback: {[weak self] (success:Bool, resultText: String) -> Void in
                if success == true {
                    DispatchQueue.main.async {
                        self?._rubyTextView.text = resultText
                    }
                }
            }
        )
    }
}

