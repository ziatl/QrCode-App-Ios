//
//  WelcomeViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 24/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var viewLogin: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewLogin.layer.cornerRadius = self.viewLogin.frame.height/20.0;
        self.viewLogin.layer.masksToBounds = true;
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
