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
    let save = UserDefaults.standard
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
        let listAction = UIAlertAction(title: "Liste des codes qr ", style: .default, handler: {(action) -> Void in
            let viewControl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "liste") as! ListCodeViewController
            self.present(viewControl, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in
            
        })
        
        alert.addAction(listAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func actionDisconnet(_ sender: Any) {
        let alert = UIAlertController(title: "Information", message: "Voulez vous vous deconnecter ?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: {(void) in
            let viewCOntroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome")
            self.present(viewCOntroller, animated: true, completion: nil)
            UserDefaults.standard.removeObject(forKey: "id")
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    

}

