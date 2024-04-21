//
//  ViewController.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/20/24.
//

import UIKit
import AVFoundation
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    private var audioRecorder: AVAudioRecorder?
    private var audioSession = AVAudioSession.sharedInstance()
    private var audioPlayer: AVAudioPlayer?
    
    
    
    private let recordButton = CustomButton(title: "Record",hasBackground: true, fontsize: .big, buttonColor: .systemGreen)
    private let stopButton = CustomButton(title: "Stop",hasBackground: true, fontsize: .big, buttonColor: .systemRed)
    private let playButton = CustomButton(title: "Play",hasBackground: true, fontsize: .big, buttonColor: .blue)
    private let speakButton = CustomButton(title: "Speak",hasBackground: true, fontsize: .big, buttonColor: .blue)
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    private let utterance = AVSpeechUtterance(string: "Hello world! My name is Yahia Salman and I am stupid!")
    


    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.setupUI()
        self.setupRecorder()
        let voices = AVSpeechSynthesisVoice.speechVoices()
        for voice in voices {
            print("\(voice.language) - \(voice.name)")
        }
        recordButton.addTarget(self, action: #selector(startRecording), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopRecording), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        speakButton.addTarget(self, action: #selector(speak), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//        utterance.voice = AVSpeechSynthesisVoice(identifier: "Grandma")
//        utterance.voice = AVSpeechSynthesisVoice.speechVoices()[155]

    }
    
    private func setupUI(){
        self.view.addSubview(recordButton)
        self.view.addSubview(stopButton)
        self.view.addSubview(playButton)
        self.view.addSubview(speakButton)
        
        self.recordButton.translatesAutoresizingMaskIntoConstraints = false
        self.stopButton.translatesAutoresizingMaskIntoConstraints = false
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.speakButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            self.recordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.recordButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.recordButton.widthAnchor.constraint(equalToConstant: 150),
            self.recordButton.heightAnchor.constraint(equalToConstant: 25),
            
            self.stopButton.topAnchor.constraint(equalTo: self.recordButton.bottomAnchor, constant: 20),
            self.stopButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stopButton.widthAnchor.constraint(equalToConstant: 150),
            self.stopButton.heightAnchor.constraint(equalToConstant: 25),
            
            self.playButton.topAnchor.constraint(equalTo: self.stopButton.bottomAnchor, constant: 20),
            self.playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.playButton.widthAnchor.constraint(equalToConstant: 150),
            self.playButton.heightAnchor.constraint(equalToConstant: 25),
            
            self.speakButton.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 20),
            self.speakButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.speakButton.widthAnchor.constraint(equalToConstant: 150),
            self.speakButton.heightAnchor.constraint(equalToConstant: 25),
            
            
        
        
        ])
    }
    
    func setupRecorder() {
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)

            let settings = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVSampleRateKey: 44100, // Standard CD-quality sample rate
                AVNumberOfChannelsKey: 1, // Mono audio
                AVLinearPCMBitDepthKey: 16, // 16-bit depth
                AVLinearPCMIsBigEndianKey: false, // Little-endian
                AVLinearPCMIsFloatKey: false, // PCM data is in integers, not floats
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]

            // Setup the path to save audio
            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")

            // Initialize the recorder
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.prepareToRecord()
        } catch {
            print("Failed to set up the recorder: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print(paths[0])
        return paths[0]
    }
    
    @IBAction func startRecording() {
        if let recorder = audioRecorder {
            recorder.record()
            print("Recording started")
        } else {
            print("Recorder not initialized")
        }
    }

    @IBAction func stopRecording() {
        audioRecorder?.stop()
        print("Recording stopped")
    }

    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")
        
        if FileManager.default.fileExists(atPath: audioFilename.path) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                audioPlayer?.play()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("there is no recent recording")
        }
    }
    
    @objc func speak(){
        do {
            try audioSession.setCategory(.playback, mode: .default, options: .duckOthers)
            try audioSession.setActive(false)
            speechSynthesizer.speak(self.utterance)
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }

    

    @objc func sendEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail services are not available")
            return
        }

        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self

        // Configure the fields of the interface.
        composeVC.setToRecipients(["yahia.salman.04@gmail.com"])
        composeVC.setSubject("Audio File")
        composeVC.setMessageBody("Here's the recording.", isHTML: false)

        // Attach the audio file
        if let audioData = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent("recording.wav")) {
            composeVC.addAttachmentData(audioData, mimeType: "audio/wav", fileName: "recording.wav")
        }

        // Present the view controller modally.
        self.present(composeVC, animated: true)
    }

    // MARK: - Mail Composer Delegate



}

func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
}

