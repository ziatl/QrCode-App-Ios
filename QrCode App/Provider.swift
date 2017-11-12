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
extension String {
    mutating func couper(longDeb:Int) -> String {
        let lengh = self.sorted().count - longDeb
        let start = self.index(self.startIndex, offsetBy: 0)
        let end = self.index(self.endIndex, offsetBy: -lengh)
        let range = start..<end
        return String(self[range])
    }
    mutating func couper(longFin:Int) -> String {
        let start = self.index(self.startIndex, offsetBy: longFin)
        let end = self.index(self.endIndex, offsetBy: -0)
        let range = start..<end
        return String(self[range])
    }
}

