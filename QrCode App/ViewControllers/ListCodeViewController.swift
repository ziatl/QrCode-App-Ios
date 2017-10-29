//
//  ListCodeViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 29/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit
import AVFoundation
class ListCodeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tbvlistCode: UITableView!
    var table = ["You have some problems. Please stay at home.","You can not go now."," Toto is a medicine against stress Instructions.  Do not consume when it snows .Take care of the dose"]
    
    var lecteur = AVSpeechUtterance()
    var synth = AVSpeechSynthesizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        synth.stopSpeaking(at: .immediate)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvlistCode.dequeueReusableCell(withIdentifier: "cell") as! ListTableViewCell
        cell.lblCode.text = table[indexPath.row]
        cell.btnSpell.tag = indexPath.row
        cell.btnSpell.addTarget(self, action: #selector(actionSpell), for: .touchUpInside)
        return cell
        
    }
    
    @IBAction func actionSpell(_ sender: UIButton) {
//        sender.superview?.backgroundColor = UIColor.darkGray
//        sender.superview?.alpha = CGFloat(0.4)
        if synth.isSpeaking {
            synth.stopSpeaking(at: .immediate)
        }
        lecteur = AVSpeechUtterance(string: table[sender.tag])
        lecteur.voice = AVSpeechSynthesisVoice(language: "en-EN")
        lecteur.rate = 0.4
        
        synth.speak(lecteur)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("jjkdfffdkdfkfdjkdfjkfd")
    }
    
    @IBAction func actionMenu(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        let listAction = UIAlertAction(title: "📷 Scan code", style: .default, handler: {(action) -> Void in
            let viewControl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "scan") as! ScanViewController
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

    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
