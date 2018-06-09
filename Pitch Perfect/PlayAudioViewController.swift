//  PlayAudioViewController.swift
//  Pitch Perfect
//  Created by Vivekananda Cherukuri on 29/09/2017.
//  Copyright © 2017 Flying Fish Studios. All rights reserved.
//
import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {

    var recordedAudioURL:URL? = nil
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var chipMunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
   
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        reverbButton.imageView?.contentMode = .scaleAspectFit
//        vaderButton.imageView?.contentMode = .scaleAspectFit
//        echoButton.imageView?.contentMode = .scaleAspectFit
//        chipMunkButton.imageView?.contentMode = .scaleAspectFit
//        reverbButton.imageView?.contentMode = .scaleAspectFit
//        snailButton.imageView?.contentMode = .scaleAspectFit
//        rabbitButton.imageView?.contentMode = .scaleAspectFit
//
//        setupAudio()
        
        let videoURL = URL(string: "https://mnmedias.api.telequebec.tv/m3u8/29880.m3u8")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // configureUI(.notPlaying)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
        stopAudio()
        
    }
  
    //MARK: Play and Stop Sound Functions.
    
    @IBAction func playSoundForButton(_ sender: Any) {
        switch(ButtonType(rawValue: (sender as AnyObject).tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
   
    @IBAction func stopAudioTapped(_ sender: Any) {
        stopAudio()
    }
    
}
