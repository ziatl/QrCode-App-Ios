//
//  SpellViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 29/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit
import AVFoundation

class SpellViewController: UIViewController {

    @IBOutlet weak var txvCode: UITextView!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var lecteur = AVSpeechUtterance()
    var synth = AVSpeechSynthesizer()
    var textGet:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        btnList.layer.cornerRadius = btnList.frame.height / 2
        btnSave.layer.cornerRadius = btnList.frame.height / 2
        txvCode.layer.borderWidth = CGFloat(2.0)
        
        txvCode.layer.borderColor = UIColor.blue.cgColor
        txvCode.text = textGet
        
        //
       self.lecteur = AVSpeechUtterance(string: txvCode.text)
        spell()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
       spell()
    }
    func spell() {
        if synth.isSpeaking {
            synth.stopSpeaking(at: .immediate)
        }
        lecteur = AVSpeechUtterance(string: txvCode.text)
        lecteur.voice = AVSpeechSynthesisVoice(language: "en-EN")
        lecteur.rate = 0.4
        synth.speak(lecteur)
    }
    
    @IBAction func actionMenu(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "List des code-barres ", style: .default, handler: {(action) -> Void in
            
            })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in
            
        })
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        synth.stopSpeaking(at: .immediate)
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
