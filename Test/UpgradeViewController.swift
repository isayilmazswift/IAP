//
//  UpgradeViewController.swift
//  Test
//
//  Created by İsa Yılmaz on 20.03.2021.
//

import StoreKit
import UIKit

class UpgradeViewController: UIViewController, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    
    var myPruduct: SKProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        
    }
    
    
    @IBAction func DidTapBuy(_ sender: Any) {
        
        guard let myProduct = myPruduct else {return}
        
        if SKPaymentQueue.canMakePayments(){
            let payment = SKPayment(product: myProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        }
        
    }
    
    func fetchProducts(){
        //com.isayilmaz.test.removeads
        
        let request = SKProductsRequest(productIdentifiers: ["com.isayilmaz.test.removeads"])
        request.delegate = self
        request.start()
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                // no operations
                
                break
                
            case .purchased, .restored:
                
                // Unlock Items
                
                UserDefaults.standard.set(true, forKey: "ads_removed")
                
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                
                break
                
            case .failed, .deferred:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
                
            default:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
            }
        }
        
        
    }
    
}


extension UpgradeViewController {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            self.myPruduct = product
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.productIdentifier)
            print(product.price)
        }
    }
    
    
}
