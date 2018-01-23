//
//  ViewController.swift
//  SCOptionPageDemo
//
//  Created by abon on 2018/1/19.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    
    @IBAction func buttonClick1(_ sender: UIButton) {
        
        let vc = SCMenuPageViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func buttonClick2(_ sender: UIButton) {
        
        let vc = SCOptionPageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

