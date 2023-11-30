//
//  ViewController.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 2023/11/29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var editTransmissionAmount: UITextField!
    @IBOutlet weak var pickerCurrency: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUi()
    }

    private func initializeUi() {
        self.editTransmissionAmount.delegate = self
        self.setUITextFieldStyle()
        
        let currenies = Currency.allCases
            .map {
                switch $0 {
                case .krw(let value), .jpy(let value), .php(let value):
                    return value
                }
            }
        
        self.pickerCurrency.tintColor = .clear
    }
    
    private func setUITextFieldStyle() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0.0))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.items = [doneButton, flexibleSpace]
        
        self.editTransmissionAmount.borderStyle = .none
        self.editTransmissionAmount.layer.borderColor = UIColor.lightGray.cgColor
        self.editTransmissionAmount.layer.borderWidth = 2.0
        self.editTransmissionAmount.inputAccessoryView = toolbar
        self.editTransmissionAmount.leftView = paddingView
        self.editTransmissionAmount.leftViewMode = .always
        self.editTransmissionAmount.rightView = paddingView
        self.editTransmissionAmount.rightViewMode = .always
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}
