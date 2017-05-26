//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Tom Munhoven on 26/05/2017.
//  Copyright © 2017 Tom Munhoven. All rights reserved.
//

import UIKit

// Require this library for using microphone
import AVFoundation

class SoundViewController: UIViewController {
    
    // Outlets from VC
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var soundName: UITextField!
    
    // Other global variables
    var audioRecorder : AVAudioRecorder? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        
    }
    
    func setupRecorder() {
        
        // encapsulate in do-try-catch loop to support AV functions throws
        
        do {
            
            // Create an audio session
            
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord) // want to play and record
            try session.overrideOutputAudioPort(.speaker) // use speaker and not headphones
            try session.setActive(true)
            
            // Create URL for audio file
            
            // Set home directory as working directory
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"] // set file name
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)! // construct complete path to file
            
            print("####################")
            print(audioURL)
            print("####################")
            
            // Create settings for audio recorder object
            
            var settings : [String : Any ] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)   // File format
            settings[AVSampleRateKey] = 44100.0   // Sampling Rate
            settings[AVNumberOfChannelsKey] = 2   // Stereo quality
            
            // Create audiorecorder object
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()

        } catch let error as NSError {
            
            print("Error in AV function call: \(error)")
            
        }

    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            
            audioRecorder?.stop()   // Stop Recording
            
            recordButton.setTitle("Record", for: .normal)   // Change button to "Record"
            
        } else {
            
            audioRecorder?.record() // Start Recording
            
            recordButton.setTitle("Stop", for: .normal)   // Change button to "Stop"
            
        }
        
    }
    
    @IBAction func playTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        
        
    }
    
    
}
