//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Miguel Fagundez on 1/19/15.
//  Copyright (c) 2015 Miguel Fagundez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        recordButton.enabled = false
        stopButton.hidden = false
        // TODO: Record audio from user
        println("Recording Audio")
    }

    @IBAction func stopRecordingAudio(sender: UIButton) {
        recordingInProgress.hidden = true
    }
}

