//
//  ScanViewController.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 25/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import UIKit
import AVFoundation
class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet var videoPreview: UIView!
    @IBOutlet weak var btnAnnuler: UIButton!
    @IBOutlet weak var imgQr: UIImageView!
    var codeBar = String()
    let avCaptureSession = AVCaptureSession()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try scanQRCode()
        } catch {
            print("Failed to scan the QR/Barcode.")
        }
        btnAnnuler.layer.cornerRadius = btnAnnuler.frame.height / 2
        Provider()._setAudioSession(active: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum error: Error {
        case noCameraAvailable
        case videoInputInitFail
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects:[Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                codeBar = machineReadableCode.stringValue!
                showCode(codeBar)
            }
        }
    }
    
    func scanQRCode() throws {
        
        
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("No camera.")
            throw error.noCameraAvailable
        }
        
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
            print("Failed to init camera.")
            throw error.videoInputInitFail
        }
        
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = videoPreview.bounds
        self.view.layer.addSublayer(avCaptureVideoPreviewLayer)
        videoPreview.frame = view.layer.bounds
        videoPreview.bringSubview(toFront: btnAnnuler)
        videoPreview.bringSubview(toFront: imgQr)
        self.view.bringSubview(toFront: videoPreview)
        avCaptureSession.startRunning()
    }
    
    func showCode(_ code:String){
        let alert = UIAlertController(title: "Code", message: "Le code Bar scanné : \(codeBar)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default){(action:UIAlertAction!) in
            self.avCaptureSession.stopRunning()
            let viewContr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "save") as! SpellViewController
            viewContr.textGet = self.codeBar
            self.present(viewContr, animated: true, completion: nil)

        }
        let cancelAction = UIAlertAction(title: "Reprendre", style: .cancel){(action:UIAlertAction!) in
            
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion:nil)
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                codeBar = machineReadableCode.stringValue!
                showCode(codeBar)
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
