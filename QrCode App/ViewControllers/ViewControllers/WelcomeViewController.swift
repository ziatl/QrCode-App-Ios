//
//  WelcomeViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 24/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit
import Alamofire

class WelcomeViewController: UIViewController {
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var txfLogin: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var txfPasswordRepeat: UITextField!
    let save = UserDefaults.standard
    var action = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        action = 0
        self.viewLogin.layer.cornerRadius = self.viewLogin.frame.height/20.0;
        self.viewLogin.layer.masksToBounds = true;
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        btnLogin.layer.cornerRadius = btnLogin.frame.height / 2
        btnCreate.layer.borderColor = UIColor.blue.cgColor
        btnCreate.layer.borderWidth = 1.0
        btnCreate.layer.cornerRadius = btnCreate.frame.height / 2
        txfPasswordRepeat.isHidden = true
        if let id = save.value(forKey: "id") {
            print(id)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var inscBtnLogText = "Connexion"
    var inscBtnCreateText = "Créer"
    
    var inscLblLogText = "Se connecter"
    var inscLblCreateText = "Créer un compte"
    @IBAction func createAction(_ sender: Any) {
        if self.action == 0 {
            btnLogin.setTitle(inscBtnCreateText, for: .normal)
            btnCreate.setTitle(inscLblLogText, for: .normal)
            lblInformation.text = "Inscription"
            txfPasswordRepeat.isHidden = false
            self.action = 1
        }else{
            btnLogin.setTitle(inscBtnLogText, for: .normal)
            btnCreate.setTitle(inscLblCreateText, for: .normal)
            lblInformation.text = "Connexion"
            txfPasswordRepeat.isHidden = true
            self.action = 0
        }
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        if action == 0 {
            print("essaie de connexion")
            if validation() {
                
                login(username: txfLogin.text!,password: txfPassword.text!)
            }
        }
        if action == 1 {
            print("essaie d inscription")
            if validation() {
                
                createAccount(username: txfLogin.text!,password: txfPassword.text!)
            }
        }
    }
    
    func login(username:String,password:String) {
        let parameter:Parameters = ["username":username,"password":password]
        Alamofire.request("http://pridux.net/mobile/login.inc.php", method: .post,parameters:parameter).validate(){request,response,data  in
            return .success
            }.responseJSON() { response in
                //Recuperation de la reponse
                if let rep = response.result.value as? [String:Any] {
                    //Recuperation des donnees de l utilisateur
                    if let data = rep["data"] as? [String:Any] {
                        let isConnect = data["isConnected"] as? Int
                        if isConnect == 1 {
                            print(data)
                            let id = data["id"]

                            //Ajout de l id user en memoire
                            self.save.set(id!, forKey: "id")
                            let alert = UIAlertController(title: "Inscription", message: "Connexion effectuée avec succes !!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler:{(void) in
                                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menu")
                                self.present(viewController, animated: true, completion: nil)
                            })
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        } else{
                            let alert = UIAlertController(title: "Erreur login", message: "Email ou mot de passe incorrect", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    //fin rep
                }
                
        }
        
    }
    
    func createAccount(username:String,password:String) {
        let parameter:Parameters = ["username":username,"password":password]
        Alamofire.request("http://pridux.net/mobile/registration.php", method: .post,parameters:parameter).validate(){request, response, data in
            return .success
            }.responseJSON() { response in
                let rep = response.result.value as? Bool
                debugPrint(" Inscription \(rep!) ")
                if rep! {
                    let alert = UIAlertController(title: "Felicitation", message: "Bienvenue sur VoixRX. Veuillez vous connecter à votre espace", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.btnLogin.setTitle(self.inscBtnLogText, for: .normal)
                    self.btnCreate.setTitle(self.inscLblCreateText, for: .normal)
                    self.lblInformation.text = "Connexion"
                    self.txfPasswordRepeat.isHidden = true
                    self.action = 0
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Erreur inscription", message: "Erreur lors de la creation de compte, veuillez reessayer.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
    
    func validation() -> Bool{
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        alert.addAction(okAction)
        if txfLogin.text == "" || !isValid(txfLogin.text!){
            alert.title = "Erreur de saisie"
            alert.message = "Saisir un email valid svp"
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if (txfPassword.text! == "" || ((txfPassword.text)?.count)! < 8){
            alert.title = "Erreur mot de passe"
            alert.message = "Saisir un mot de passe d'au moins 8 caracteres"
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if (action == 1) {
            if txfPassword.text != txfPasswordRepeat.text {
                alert.title = "Mot de passe non identique"
                alert.message = "Les deux mot de passe doivent étre identique"
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        
        
        return true
        
    }
    
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
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
