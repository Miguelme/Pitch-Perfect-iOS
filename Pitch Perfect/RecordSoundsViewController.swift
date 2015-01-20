//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Miguel Fagundez on 1/19/15.
//  Copyright (c) 2015 Miguel Fagundez. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    // Properties to record audio
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    // Outlets
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }
    
    
// MARK: Record and stop recording actions
    /*
        Records the audio from the phone
    */
    @IBAction func recordAudio(sender: UIButton) {
        
        // It updates the display
        recordingInProgress.hidden = false
        recordButton.enabled = false
        stopButton.hidden = false
        
        // Setting the parameters for the recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    /*
        Implements the stop button and sets parameter
        accordingly to the AVAudioRecorder
    */
    @IBAction func stopRecordingAudio(sender: UIButton) {
        recordingInProgress.hidden = true
        recordButton.enabled = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    

    
// MARK: AVAudioRecorderDelegate
    /*
        After the audio is recorded it performs the segue, and set the data as the sender
    */
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            recordedAudio = RecordedAudio()
            recordedAudio.filePath = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else {
            println("Recording wasn't succesfull")
        }
    }
    
// MARK: Segue methods
    /*
    It sets the data to the next screen so it can be played
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
    }

}

