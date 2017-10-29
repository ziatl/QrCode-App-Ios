//
//  ViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 24/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnList: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnList.layer.cornerRadius = btnList.frame.height / 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

