//
//  LogoViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 29/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit

class LogoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let viewControl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome") as! WelcomeViewController
            self.present(viewControl, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
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
