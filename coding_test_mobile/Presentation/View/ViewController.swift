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
    private var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData()
        initializeUi()
        subscribeViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // self.pickerCurrency.subviews 가 생성된 이후에 호출
        setSelectedPickerViewStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.editTransmissionAmount.delegate = nil
        self.pickerCurrency.delegate = nil
        self.pickerCurrency.dataSource = nil
    }

    @objc func doneButtonTapped() {
        viewModel.fetchLive()
        view.endEditing(true)
    }
    
    private func initializeUi() {
        self.editTransmissionAmount.delegate = self
        self.pickerCurrency.delegate = self
        self.pickerCurrency.dataSource = self
        
        self.labelCurrency.text = "\(currencyNames[0])"
        self.labelInfomation.text = "infomation_default".localized
        self.labelCurrentTime.text = viewModel.timestemp
        
        self.setUITextFieldStyle()
    }
    
    private func subscribeViewModel() {
        viewModel.onCompleted = { [weak self] _ in
            DispatchQueue.main.async {
                self?.labelCurrentTime.text = self?.viewModel.timestemp
                
                guard let currency = self?.viewModel.currentCurrency else { return }
                let exchangeRate = self?.viewModel.getExchangeRate(currency: currency) ?? 0
            
                self?.labelExchangeRate.text = String(format: "exchange_rate".localized, "\(NumberFormatUtil.convertNumberToFormatText(number: exchangeRate)) \(currency)")
                self?.labelInfomation.text = self?.viewModel.getLabelInfomation(recievedAmount: self?.editTransmissionAmount.text)
            }
        }
    }
    
    private func setSelectedPickerViewStyle() {
        let selectiedView = self.pickerCurrency.subviews[1] // subviews[1] : 선택된 뷰
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
    
    private func initializeData() {
        viewModel = AppDIContainer.shared.resolveService(MainViewModel.self)
        viewModel.fetchLive()
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
        
        labelCurrency.text = "\(seletedCurrency)"
        viewModel.changeCurrency(currency: currencies[row])
        
        let exchangeRate = viewModel.getExchangeRate(currency: currencies[row]) ?? 0
        
        labelExchangeRate.text = String(format: "exchange_rate".localized, "\(NumberFormatUtil.convertNumberToFormatText(number: exchangeRate)) \(currencies[row])")
        
        labelInfomation.text = viewModel.getLabelInfomation(recievedAmount: editTransmissionAmount.text)
    }
}
