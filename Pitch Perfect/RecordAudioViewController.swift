//
//  ReordAudioViewController.swift
//  Pitch Perfect
//  Created by Vivekananda Cherukuri on 29/09/2017.
//  Copyright © 2017 Flying Fish Studios. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController,AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    @IBOutlet var recordingStatusLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.switchLabelsAndButtons(isRecording: false)
    }
    
    func switchLabelsAndButtons(isRecording: Bool) {
       
        recordingStatusLabel.text = isRecording ? "Recording in progress" : "Tap to record"
        recordButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
    
    }
   
    // MARK: ACTION Functions
    @IBAction func startRecording(_ sender: Any) {
        
        self.switchLabelsAndButtons(isRecording: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedPitchPerfectVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    
    // MARK: Navigation Functions

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
            
            if flag {
                performSegue(withIdentifier: "showPlaySoundView", sender: audioRecorder.url)
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Recording failed.", preferredStyle: .alert)
                
                let errorAction = UIAlertAction(
                title: "OK", style: UIAlertActionStyle.default) { (action) in
                    // ...
                }
                alert.addAction(errorAction)
                self.present(alert, animated: true, completion: nil)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPlaySoundView" {
            let playAudioVC = segue.destination as! PlayAudioViewController
            let recordedAudioUrl = sender as! URL!
            playAudioVC.recordedAudioURL = recordedAudioUrl
        }
    }

}

