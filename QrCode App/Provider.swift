//
//  Provider.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 10/11/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import Foundation
import AVFoundation
class Provider {
    func _setAudioSession(active: Bool) {
        if !isHeadphonesConnected() {
            do {
                
                
                let audioSession = AVAudioSession.sharedInstance()
                
                let avopts:AVAudioSessionCategoryOptions = [
                    .defaultToSpeaker
                ]
                
                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: avopts)
            } catch {
                print("IGNORE!! - error while setting audioSession status")
            }
        }
        
    }
    func isHeadphonesConnected() -> Bool{
        let routes = AVAudioSession.sharedInstance().currentRoute
        return routes.outputs.contains(where: { (port) -> Bool in
            port.portType == AVAudioSessionPortHeadphones
        })
    }
}
