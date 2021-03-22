//
//  ViewController.swift
//  Test
//
//  Created by İsa Yılmaz on 20.03.2021.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaults.standard.bool(forKey: "ads_removed") {
            // Show ads
        }
        
        else {
            //ads
        }
        
        // Do any additional setup after loading the view.
    }


    @IBAction func didTapRemoveAds(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "upgrade") else {
            return
        }
        
        vc.title = "Remove Ads"
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

