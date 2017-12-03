//
//  ListCodeViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 29/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
class ListCodeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tbvlistCode: UITableView!
    var table = [String]()
    
    var lecteur = AVSpeechUtterance()
    var synth = AVSpeechSynthesizer()
    let save = UserDefaults.standard

    @IBOutlet weak var lblLangue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getList((Int)(save.value(forKey: "id") as! String)!)
        Provider()._setAudioSession(active: true)
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
        let texte = table[indexPath.row].couper(longFin: 2)
        
        cell.lblCode.text = texte
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
        let texte = table[sender.tag].couper(longFin: 2)
        lecteur = AVSpeechUtterance(string: texte)
        lecteur.voice = AVSpeechSynthesisVoice(language: Provider.getLangue(lg: table[sender.tag].couper(longDeb: 2)))
        lecteur.rate = 0.4
        lblLangue.isHidden = false
        lblLangue.text = "Langue "+Provider.getLangue(lg: table[sender.tag].couper(longDeb: 2))
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
    
    func getList(_ id:Int){
        let parameter:Parameters = ["id":id]
        Alamofire.request("http://pridux.net/mobile/list_scan.php", method: .post,parameters:parameter).validate(){request, response, data in
            return .success
            }.responseJSON() { response in
                if let rep = response.result.value as? [String:Any] {
                    debugPrint(" Inscription \(rep) ")
                    if let codes = rep["data"] as? [[String:Any]] {
                        for code in codes {
                            for (key,value) in code {
                                if key == "instruction" {
                                    self.table.append(value as! String)
                                }
                            }
                            self.tbvlistCode.reloadData()
                        }
                    }
                }
                
                
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
