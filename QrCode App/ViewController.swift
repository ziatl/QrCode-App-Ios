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
    @IBAction func actionMenu(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        let listAction = UIAlertAction(title: "List des code-barres ", style: .default, handler: {(action) -> Void in
            let viewControl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "liste") as! ListCodeViewController
            self.present(viewControl, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in
            
        })
        
        alert.addAction(listAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func actionWeb(_ sender: UIBarButtonItem) {
        guard let url = URL(string: "http://pridux.net") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }


}

