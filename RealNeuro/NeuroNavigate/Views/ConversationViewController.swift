//
//  ConversationViewController.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/20/24.
//

import UIKit
import AVFoundation

class ConversationViewController: UIViewController {
    
    // MARK: Properties
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var countdownTimer: Timer?
    private var countdown = 3
    private var exercise: Int
    private var numSquats: Int
    private var numCrunches: Int
    private var numLeftCurls: Int
    private var numRightCurls: Int
    private var numPushups: Int
    private var numPress: Int
    
    private let questionBank = [
        "What did you do today?",
        "How are you?",
        "Tell me about your favorite subject?",
        "What is your favorite food?",
        "Who is your best friend?",
        "What games do you like to play?",
        "Did anything make you happy today?",
        "Did anything upset you today?",
        "What is your favorite book?",
        "What do you like to do in your free time?",
        "Can you describe your favorite movie?",
        "What's your favorite animal?",
        "Do you have a favorite song?",
        "What was the best part of your day?",
        "What did you eat for lunch?",
        "Do you like to draw? What do you draw?",
        "What is your favorite season and why?",
        "Do you prefer to spend time indoors or outdoors?",
        "What subjects do you like at school?",
        "Is there a place you would like to visit?",
        "What are you good at?",
        "What makes you laugh?",
        "Can you tell me about your family?",
        "What's your favorite holiday?",
        "What chores do you do at home?",
        "Do you have any hobbies?",
        "Do you play any sports?",
        "What’s your favorite thing to do on the weekend?",
        "Can you tell me about a show you like to watch?",
        "What kind of clothes do you feel most comfortable in?"
    ]

    
    private var numberCur: Int = 0
    
    
    private let questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.text = "What did you do today?"
        questionLabel.numberOfLines = 2
        questionLabel.font = .systemFont(ofSize: 30)
        questionLabel.textAlignment = .center
        return questionLabel
    }()
    
    private let stepsLabel: UILabel = {
        let stepsLabel = UILabel()
        stepsLabel.text = "Step 1: Answer the question in detail. \n \nStep 2: Ask a question back."
        stepsLabel.numberOfLines = 3
        stepsLabel.textAlignment = .center
        stepsLabel.font = .systemFont(ofSize: 20)
        return stepsLabel
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
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupUI()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = CGRect(x: 0, y: 0, width: view.bounds.width * 0.8, height: view.bounds.height * 0.50)
        previewLayer?.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY + 70)
        previewLayer?.cornerRadius = 20
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
        self.view.addSubview(stepsLabel)
        
        // Set up constraints
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            questionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.questionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.questionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            
            stepsLabel.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: 30),
            self.stepsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.stepsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
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
            countdownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownLabel.widthAnchor.constraint(equalToConstant: 100),
            countdownLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func saveExerciseDataToMongoDB(exerciseName: String, completeReps: Int, partialReps: Int) {}
        
        // MARK: Action Handlers
    @objc private func startButtonTapped() {
        let urlString = "\(Constants.baseURL)/StartInterview"

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
                            self.stopButton.isHidden = false
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
    
    @objc func didTapStopButton() {
        let urlString = "\(Constants.baseURL)/EndConversation"

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
                    print(json)
                    // Extract the message value
                    if let message = json["result"] as? String {
                        DispatchQueue.main.async{
                            
                            // Print the real message
                            self.startButton.isHidden = false
                            self.stopButton.isHidden = true
                            self.numberCur = self.numberCur + 1
                            self.questionLabel.text = self.questionBank[self.numberCur]
                            
                            let randomInt = Int.random(in: 1...2)
                            
                            if(self.numberCur % 2 == 0){
                                ConversationViewController.showBasicAlert(on: self, title: "Great Work", message: "That was a great response! You answered the question and you asked a question back!")

                            } else {
                                ConversationViewController.showBasicAlert(on: self, title: "Good Work", message: "That was a good response! You answered the question great. Just don't forget to ask a question too!")

                            }
                                                        // Print the real message
//                            print("Message: \(message)")
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
    
    // MARK: Utility Functions
    public static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
    
    
}

