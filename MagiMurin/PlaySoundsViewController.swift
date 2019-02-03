//
//  PlaySoundsViewController.swift
//  MagiMurin
//
//  Created by Cornelius Yan Mintareja on 19/01/19.
//  Copyright © 2019 Cornelius Yan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    var rate: Float = 1
    var pitch: Float = 0
    var echo: Bool = false
    var reverb: Bool = false

    var snailColor = UIColor(red: 21/255, green: 165/255, blue: 21/255, alpha: 1.0)
    var rabbitColor = UIColor(red: 247/255, green: 157/255, blue: 0/255, alpha: 1.0)
    var chipmunkColor = UIColor(red: 50/255, green: 171/255, blue: 220/255, alpha: 1.0)
    var vaderColor = UIColor(red: 25/255, green: 25/255, blue: 112/255, alpha: 1.0)
    var echoColor = UIColor(red: 202/255, green: 1/255, blue: 35/255, alpha: 1.0)
    var reverbColor = UIColor(red: 209/255, green: 31/255, blue: 161/255, alpha: 1.0)

    var playing: Bool = false
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            if rate == 0.5 {
                rate = 1
                formatBorder(sender: snailButton, hide: true)
            } else {
                rate = 0.5
                formatBorder(sender: snailButton, hide: false)
                formatBorder(sender: rabbitButton, hide: true)
            }
        case .fast:
            if rate == 1.75 {
                rate = 1
                formatBorder(sender: rabbitButton, hide: true)
            } else {
                rate = 1.75
                formatBorder(sender: rabbitButton, hide: false)
                formatBorder(sender: snailButton, hide: true)
            }
        case .chipmunk:
            if pitch == 1000 {
                pitch = 0
                formatBorder(sender: chipmunkButton, hide: true)
            } else {
                pitch = 1000
                formatBorder(sender: chipmunkButton, hide: false)
                formatBorder(sender: vaderButton, hide: true)
            }
        case .vader:
            if pitch == -1000 {
                pitch = 0
                formatBorder(sender: vaderButton, hide: true)
            } else {
                pitch = -1000
                formatBorder(sender: vaderButton, hide: false)
                formatBorder(sender: chipmunkButton, hide: true)
            }
        case .echo:
            if echo {
                formatBorder(sender: echoButton, hide: true)
            } else {
                formatBorder(sender: echoButton, hide: false)
            }
            echo = !echo
        case .reverb:
            if reverb {
                formatBorder(sender: reverbButton, hide: true)
            } else {
                formatBorder(sender: reverbButton, hide: false)
            }
            reverb = !reverb
        }

    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        if playing {
            stopAudio()
            configureUI(.notPlaying)
        } else {
            playSound(rate: rate, pitch: pitch, echo: echo, reverb: reverb)
            configureUI(.playing)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        
        setBorder(sender: snailButton,color: snailColor)
        setBorder(sender: rabbitButton,color: rabbitColor)
        setBorder(sender: chipmunkButton,color: chipmunkColor)
        setBorder(sender: vaderButton, color: vaderColor)
        setBorder(sender: echoButton,color: echoColor)
        setBorder(sender: reverbButton,color: reverbColor)
    }
    
    func formatBorder(sender: UIButton, hide: Bool){
        if hide {
            sender.layer.borderWidth = 0
        } else {
            sender.layer.borderWidth = 4
        }
    }
    
    func setBorder(sender: UIButton,color: UIColor){
        sender.layer.borderColor = color.cgColor
        sender.layer.cornerRadius = 40
        sender.layer.masksToBounds = true
        sender.layer.borderWidth = 0
    }
    
}
