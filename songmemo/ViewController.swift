//
//  ViewController.swift
//  songmemo
//
//  Created by testuser1 on 2018-12-09.
//  Copyright © 2018 songmemo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {

    var recordingSession:AVAudioSession!
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var recordingsTableView: UITableView!
    
    @IBAction func record(_ sender: Any) {
        // Check if we have an active recorder
        if audioRecorder == nil {

            let filename = getDocumentsURL().appendingPathComponent("\(Date().timeIntervalSince1970 * 1000).m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            // Start audio recording
            do {
                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                
                buttonLabel.setTitle("Stop Recording", for: .normal)
            }
            catch {
                displayAlert(title: "Oops!", message: "Recording audio failed.")
            }
            
        }
        else {
            // Stop audio recording
            audioRecorder.stop()
            audioRecorder = nil
            recordingsTableView.reloadData()
            
            buttonLabel.setTitle("Start Recording", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting up session
        recordingSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                print ("Accepted")
            }
        }
    }
    
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAudioFiles().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let audioCell = tableView.dequeueReusableCell(withIdentifier: "audioCell", for: indexPath) as! TableViewAudioCell
        
        let audioFileURL = getAudioFiles()[indexPath.row]
        let audioFileModifiedDate = getFileModifiedDate(url: audioFileURL)?.toString(dateFormat: "YYYY-MM-dd")
        let (audioFileMinutes, audioFileSeconds) = getAudioFileDuration(url: audioFileURL)
        
        audioCell.audioFileName.text = String(getFileName(url: audioFileURL))
        audioCell.audioFileDate.text = audioFileModifiedDate
        audioCell.audioFileDuration.text = String(format: "%d:%02d", audioFileMinutes, audioFileSeconds)
  
        return audioCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = getAudioFiles()[indexPath.row]
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        }
        catch {
            displayAlert(title: "Oops!", message: "Failed to play audio.")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFile(url: getAudioFiles()[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

