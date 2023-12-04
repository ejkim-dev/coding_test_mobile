//
//  MainViewModel.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/1/23.
//

import Foundation

class MainViewModel: NSObject {
    private let liveUseCase: LiveUseCase
    
    private var live: Live? {
        didSet {
            if let live {
                onCompleted(live)
            }
        }
    }
    
    var timestemp: String {
        return DateFormatUtil.getTodayDateTime(timestamp: live?.timestamp)
    }
    
    var currentCurrency: String = Currency.krw.rawValue
    
    var onCompleted: (Live) -> Void = { _ in }
    
    init(liveUseCase: LiveUseCase) {
        self.liveUseCase = liveUseCase
    }

    func fetchLive() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.liveUseCase.fetchLive() { [weak self] result in
                switch result {
                case .success(let data):
                    self?.live = data
                    print("======== success!!")
                case .failure(let e):
                    switch e {
                    case .error(message: let msg):
                        print("======== messege : \(msg)")
                    case .parseError:
                        print("======== parseError")
                    case .unauthorized(message: let msg):
                        print("======== unauthorized : \(msg)")
                    }
                }
            }
        }
    }
    
    func getExchangeRate(currency: String) -> Double? {
        return live?.getExchangeRate(currency: currency)
    }
    
    func changeCurrency(currency: String) {
        self.currentCurrency = currency
    }
    
    func getLabelInfomation(recievedAmount: String?) -> String {
        let recievedAmount = self.calculateRecievedAmount(recievedAmount: recievedAmount) 
        
        if recievedAmount >= 0 {
            return String(format: "infomation".localized, "\(NumberFormatUtil.convertNumberToFormatText(number: recievedAmount)) \(currentCurrency)")
        } else {
            return "infomation_error".localized
        }
    }
    
    private func calculateRecievedAmount(recievedAmount: String?) -> Double {
        guard let recievedAmount else { return -1 }
        guard let amount = Double(recievedAmount) else { return -1 }
        if amount > 10000 { return -1 }
        
        let exchangeRate = live?.getExchangeRate(currency: currentCurrency) ?? -1
        
        return amount * exchangeRate
    }
}
