//
//  CheckRubyView.swift
//  IrohaGanaApp
//
//  Created by aokita on 2020/02/05.
//  Copyright © 2020 irodori. All rights reserved.
//

import UIKit

//
//
//
protocol RubyViewDelegate: AnyObject {
    func requestRuby(text: String)
}


//
// ルビ表示.
//
class CheckRubyView: UIView {

    //MARK: -- IBOutlet ------------------------------

    @IBOutlet weak var _inputTextArea: UIView!

    @IBOutlet weak var _inputTextView: UITextView!

    @IBOutlet weak var _inputClearButton: UIButton!

    @IBOutlet weak var _rubyButton: UIButton!

    @IBOutlet weak var _countLabel: UILabel!

    @IBOutlet weak var _outputTextArea: UIView!

    @IBOutlet weak var _outputClearButton: UIButton!

    @IBOutlet weak var _rubyTextView: UITextView!
    
    @IBOutlet weak var _creditImage: UIImageView!

    //MARK: -- properties ------------------------------

    weak var delegate: RubyViewDelegate? = nil
    
    
    //MARK: -- lifecycle ------------------------------

    override init(frame: CGRect) {
        super.init(frame: frame)
        self._loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self._loadNib()
    }
    
    
    //MARK: -- IBAction ------------------------------

    @IBAction func _tappedRubyButton(_ sender: Any) {
        self._requestRuby(text: self._inputTextView.text)
    }
    
    @IBAction func _tappedInputClearButton(_ sender: Any) {
        self._inputTextView.text = ""
    }
    
    @IBAction func _tappedOutputClearButton(_ sender: Any) {
        self._rubyTextView.text = ""
    }

    //MARK: -- public method ------------------------------
    
    public func showRuby(ruby: String) {
        self._rubyTextView.text = ruby
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
            IrohaGanaLog.Error("\(err.localizedDescription)")
         }
        
        self._inputTextArea.layer.borderColor = IrohaGanaColor.SHINKU.cgColor
        self._inputTextArea.layer.borderWidth = 2.0
        self._inputTextArea.layer.cornerRadius = 16.0
        self._inputTextArea.layer.shadowColor = UIColor.darkGray.cgColor
        self._inputTextArea.layer.shadowOpacity = 0.4
        self._inputTextArea.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self._inputTextArea.layer.shadowRadius = 5

        self._inputClearButton.tintColor = IrohaGanaColor.SHINKU
        self._inputClearButton.layer.borderColor = IrohaGanaColor.SHINKU.cgColor
        self._inputClearButton.layer.borderWidth = 1.0
        self._inputClearButton.layer.cornerRadius = 8.0
        self._inputClearButton.contentEdgeInsets = UIEdgeInsets.init(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        
        self._rubyButton.setTitleColor(IrohaGanaColor.SHINKU, for: .normal)
        self._rubyButton.tintColor = IrohaGanaColor.SHINKU
        self._rubyButton.layer.borderColor = IrohaGanaColor.SHINKU.cgColor
        self._rubyButton.layer.borderWidth = 1.0
        self._rubyButton.layer.cornerRadius = 8.0
        self._rubyButton.contentEdgeInsets = UIEdgeInsets.init(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        
        self._outputClearButton.tintColor = UIColor.white
        self._outputClearButton.backgroundColor = IrohaGanaColor.SHINKU
        self._outputClearButton.layer.borderColor = IrohaGanaColor.SHINKU.cgColor
        self._outputClearButton.layer.borderWidth = 1.0
        self._outputClearButton.layer.cornerRadius = 8.0
        self._outputClearButton.contentEdgeInsets = UIEdgeInsets.init(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        
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
    
    private func _requestRuby(text: String?){
        self.endEditing(true)

        guard let text: String = text, text.isEmpty==false else {
            IrohaGanaLog.Debug("no text.")
            return
        }
        self.delegate?.requestRuby(text: text)
    }
    
    @objc private func _doneButtonTapped() {
        self._requestRuby(text: self._inputTextView.text)
    }
}

