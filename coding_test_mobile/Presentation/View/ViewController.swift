//
//  ViewController.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 2023/11/29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate{
    
    @IBOutlet weak var editTransmissionAmount: UITextField!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var labelInfomation: UILabel!
    @IBOutlet weak var labelExchangeRate: UILabel!
    @IBOutlet weak var labelCurrentTime: UILabel!
    
    private let currencyNames: [String] = Currency.nameValues
    private let currencies: [String] = Currency.values
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUi()
    }
    
    override func viewWillLayoutSubviews() {
        self.setSelectedPickerViewStyle()
        self.setUITextFieldStyle()
    }

    private func initializeUi() {
        self.editTransmissionAmount.delegate = self
        self.pickerCurrency.delegate = self
        self.pickerCurrency.dataSource = self
        
        self.labelCurrency.text = "\(currencyNames[0])"
        self.labelExchangeRate.text = String(format: "exchange_rate".localized, "0 \(currencies[0])")
    }
    
    private func setSelectedPickerViewStyle() {
        let selectiedView = self.pickerCurrency.subviews[1]
        selectiedView.backgroundColor = .clear
        
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: selectiedView.frame.width, height: 0.8))
        let bottomLine = UIView(frame: CGRect(x: 0, y: selectiedView.frame.height, width: selectiedView.frame.width, height: 0.8))

        topLine.backgroundColor = UIColor.lightGray
        bottomLine.backgroundColor = UIColor.lightGray
        
        selectiedView.addSubview(topLine)
        selectiedView.addSubview(bottomLine)
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

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let seletedCurrency: String = currencyNames[row]
        
        self.labelCurrency.text = "\(seletedCurrency)"
        self.labelExchangeRate.text = String(format: "exchange_rate".localized, "0 \(currencies[row])")
        
    }
}
