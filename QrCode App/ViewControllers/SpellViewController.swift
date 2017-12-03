//
//  SpellViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 29/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class SpellViewController: UIViewController {

    @IBOutlet weak var txvCode: UITextView!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var lecteur = AVSpeechUtterance()
    var synth = AVSpeechSynthesizer()
    var textGet:String = ""
    let save = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        btnList.layer.cornerRadius = btnList.frame.height / 2
        btnSave.layer.cornerRadius = btnList.frame.height / 2
        txvCode.layer.borderWidth = CGFloat(2.0)
        
        //txvCode.layer.borderColor = UIColor.blue.cgColor
        txvCode.text = textGet.couper(longFin: 2)
        //
       self.lecteur = AVSpeechUtterance(string: txvCode.text)
        spell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func actionSave(_ sender: UIButton) {
        if synth.isSpeaking {
            synth.stopSpeaking(at: .immediate)
        }
        let alert = UIAlertController(title: "Confirmation", message: "Enregistrer ce code qr ?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: {(void) in
            let id = (Int)(UserDefaults.standard.value(forKey: "id") as! String)!
            //enregistrement du code
            self.save(id: id, texte: self.textGet)
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func save (id:Int,texte:String){
        let parameter:Parameters = ["id_user":id,"instruction":texte]
        Alamofire.request("http://pridux.net/mobile/save_scan.php", method: .post,parameters:parameter).validate(){request, response, data in
            return .success
            }.responseJSON() { response in
                let rep = response.result.value as? Bool
                debugPrint(" Resultat \(rep!) ")
                if rep! {
                    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "liste") as! ListCodeViewController
                    self.present(viewController, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Erreur", message: "Erreur lors de l'enregistrement", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
    
    @IBAction func actionReplay(_ sender: UIButton) {
       spell()
    }
    func spell() {
        if synth.isSpeaking {
            synth.stopSpeaking(at: .immediate)
        }
        lecteur = AVSpeechUtterance(string: txvCode.text)
        lecteur.voice = AVSpeechSynthesisVoice(language: Provider.getLangue(lg: textGet.couper(longDeb: 2)))
        lecteur.rate = 0.4
        synth.speak(lecteur)
    }
    
    @IBAction func actionMenu(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Liste des codes qr", style: .default, handler: {(action) -> Void in
            
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
