//
//  EmotionRegulatorController.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/20/24.
//

import UIKit
import AVFoundation

class EmotionRegulatorController: UIViewController {
    
    // MARK: Properties
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var countdownTimer: Timer?
    private var countdown:Int = 3
    private var exercise: Int
    private var numSquats: Int
    private var numCrunches: Int
    private var numLeftCurls: Int
    private var numRightCurls: Int
    private var numPushups: Int
    private var numPress: Int
    let randomNumber: Int = Int.random(in: 0...6)
    private var audioPlayer: AVAudioPlayer?
    var correctSoundURL: URL?
    var incorrectSoundURL: URL?
    
    private let emotionBank: [String] = ["Anger", "Happy", "Disgust", "Sadness", "Fear", "Neutral", "Surprise"]
    private var currentEmotion: Int = 0
    
    
    private let questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.text = "Press Start then Copy the Emoji Below"
        questionLabel.numberOfLines = 2
        questionLabel.font = .systemFont(ofSize: 20)
        questionLabel.textAlignment = .center
        return questionLabel
    }()
    
    private let emotionLabel: UIImageView = {
        
        let emotionLabel = UIImageView()
        
//        emotionLabel.text = "Step 1: Answer the question in detail. \n \nStep 2: Ask a question back."
//        emotionLabel.numberOfLines = 3
//        emotionLabel.textAlignment = .center
//        emotionLabel.font = .systemFont(ofSize: 20)
        return emotionLabel
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.isHidden = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemMint // Color as per design
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: Initialization
    init(exercise: Int) {
        self.exercise = exercise
        self.numSquats = 0
        self.numCrunches = 0
        self.numLeftCurls = 0
        self.numRightCurls = 0
        self.numPushups = 0
        self.numPress = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        button.isHidden = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed // Color as per design
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let countdownLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.isHidden = true
        return label
    }()
    
    func startCountdown() {
        
        self.countdown = 3
        self.countdownLabel.isHidden = false
        self.startButton.isHidden = true
        countdownLabel.text = "\(self.countdown)" // Initialize with the starting value
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        if self.countdown > 1 {
            self.countdown -= 1
            countdownLabel.text = "\(self.countdown)"
        } else {
//            countdownLabel.text = "Done"
            countdownLabel.isHidden = true
            countdownTimer?.invalidate()
            countdownTimer = nil
            startButton.isHidden = false
            self.checkCorrectAnswer(intendedEmotion: self.emotionBank[self.currentEmotion])
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Code to execute after 1 second
                self.setupImage()
            }
            
        }
    }
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupUI()
        self.setupAudio()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = CGRect(x: 0, y: 0, width: view.bounds.width * 0.8, height: view.bounds.height * 0.50)
        previewLayer?.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY + 70)
        previewLayer?.cornerRadius = 20
    }
    
    private func setupAudio() {
        guard let correctSoundPath = Bundle.main.path(forResource: "ding", ofType: "mp3"),
              let incorrectSoundPath = Bundle.main.path(forResource: "wahwahwah", ofType: "mp3") else {
            print("Error loading sound files")
            return
        }
        correctSoundURL = URL(fileURLWithPath: correctSoundPath)
        incorrectSoundURL = URL(fileURLWithPath: incorrectSoundPath)
    }
    
    private func checkCorrectAnswer(intendedEmotion: String){
        let urlString = "\(Constants.baseURL)/get_students"

        // Create URL object1
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }
        

        // Create URLSession
        let session = URLSession(configuration: .default)
        

        // Create a data task
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error)")
                return
            }

            // Check if response contains data
            guard let responseData = data else {
                print("Error: Did not receive data")
                return
            }

            do {
                // Parse JSON data
                if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                    print(json)
//                     Extract the message value
                    if let message = json["Yahia"] as? String {
                        DispatchQueue.main.async{
                            if(intendedEmotion.lowercased() == "sadness"){
                                if(message == "sad"){
                                    print("yay")
                                    self.playSound(soundURL: self.correctSoundURL)
                                } else{
                                    print(intendedEmotion.lowercased())
                                    print("Message: \(message)")
                                    self.playSound(soundURL: self.incorrectSoundURL)
                                }
                            }
                            else if(intendedEmotion.lowercased() == "anger"){
                                if(message == "angry"){
                                    print("yay")
                                    self.playSound(soundURL: self.correctSoundURL)
                                } else{
                                    print(intendedEmotion.lowercased())
                                    print("Message: \(message)")
                                    self.playSound(soundURL: self.incorrectSoundURL)
                                }
                            }
                            else if(intendedEmotion.lowercased() == message){
                                print("yay")
                                self.playSound(soundURL: self.correctSoundURL)
                            } else{
                                print(intendedEmotion.lowercased())
                                print("Message: \(message)")
                                self.playSound(soundURL: self.incorrectSoundURL)
                            }
                        }
                        
                    } else {
                        print("Error: Message value not found in JSON")
                    }
                } else {
                    print("Error: Unable to parse JSON data")
                }
            } catch {
                print("Error Fortnite: \(error)")
            }
        }

        // Start the data task
        task.resume()
    }
    
    
    // MARK: Setup Functions
    private func setupCamera() {
        if let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            } catch {
                print("Error setting up capture device: \(error.localizedDescription)")
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
            captureSession.startRunning()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white // Set background color as needed
        
        // Add subviews
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(countdownLabel)
        self.view.addSubview(questionLabel)
        self.view.addSubview(emotionLabel)
        
        // Set up constraints
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        emotionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            questionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.questionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.questionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            
            emotionLabel.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: 30),
//            self.emotionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
//            self.emotionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.emotionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.emotionLabel.widthAnchor.constraint(equalToConstant: 100),
            self.emotionLabel.heightAnchor.constraint(equalToConstant: 100),
            // Constraints for the start button
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Constraints for the stop button
            stopButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 100),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Constraints for the countdown label
            countdownLabel.centerYAnchor.constraint(equalTo: startButton.centerYAnchor),
            countdownLabel.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
            countdownLabel.widthAnchor.constraint(equalToConstant: 50),
            countdownLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        self.setupImage()
    }
    
    @objc func setupImage(){
        
        let randomNumber = Int.random(in: 0...6)
        self.currentEmotion = randomNumber
        let imageName = emotionBank[currentEmotion]
        self.emotionLabel.image = UIImage(named: imageName)
    }
    
    private func saveExerciseDataToMongoDB(exerciseName: String, completeReps: Int, partialReps: Int) {}
        
        // MARK: Action Handlers
    @objc private func startButtonTapped() {
        let urlString = "\(Constants.baseURL)/StartRecognizingEmotion"

        // Create URL object1
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }
        

        // Create URLSession
        let session = URLSession(configuration: .default)
        
        print("here")

        // Create a data task
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error)")
                return
            }

            // Check if response contains data
            guard let responseData = data else {
                print("Error: Did not receive data")
                return
            }

            do {
                // Parse JSON data
                if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                    // Extract the message value
                    if let message = json["message"] as? String {
                        DispatchQueue.main.async{
                            self.startButton.isHidden = true
//                            self.stopButton.isHidden = false
//                            self.countdownLabel.isHidden = false
                            self.startCountdown()
                            // Print the real message
                            print("Message: \(message)")
                        }
                        
                    } else {
                        print("Error: Message value not found in JSON")
                    }
                } else {
                    print("Error: Unable to parse JSON data")
                }
            } catch {
                print("Error: \(error)")
            }
        }

        // Start the data task
        task.resume()
    }
    
    @objc func didTapStopButton() {}
    
    private func playSound(soundURL: URL?) {
            if let url = soundURL {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                } catch {
                    print("Couldn't load sound file")
                }
            }
        }
    
    // MARK: Utility Functions
    public static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {}
    
    
}

