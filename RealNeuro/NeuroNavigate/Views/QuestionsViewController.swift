//
//  QuestionsViewController.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/21/24.
//

import UIKit
import AVFoundation

class QuestionsViewController: UIViewController {
    
    private var questionLabel: UILabel!
    private var button1: UIButton!
    private var button2: UIButton!
    private var currentQuestion: String = ""
    private var currentCorrectAnswer: String = ""
    private var audioPlayer: AVAudioPlayer?
    var correctSoundURL: URL?
    var incorrectSoundURL: URL?
    
    
    private let questionsAndAnswers: [(question: String, correct: String, incorrect: String)] = [
        ("Sally dropped her toy, what emotion should we feel for Sally?", "sad", "amused"),
        ("Bob just won an award, what should we say to Bob?", "congratulations", "that's nice"),
        ("Tom is crying because he lost his book, how should we feel?", "sympathetic", "indifferent"),
        ("Lucy is laughing at a funny joke, how should we react?", "laugh with her", "ignore"),
        ("Max can't find his shoes and is late, what emotion does he feel?", "frustrated", "annoyed"),
        ("Emma gave her friend a gift, how might her friend feel?", "happy", "confused"),
        ("Jake's pet ran away, how should we respond to Jake?", "with comfort", "distract him"),
        ("Lily solved a hard math problem, what should we say to Lily?", "great job", "that's normal"),
        ("Sam spilled his juice all over the floor, how might Sam feel?", "embarrassed", "amused"),
        ("Zoe scored the winning goal, what should we do?", "cheer for her", "say nothing"),
        ("Mia is hiding because she is scared of thunder, how should we comfort her?", "reassure her", "tell her to stop"),
        ("Olivia is dancing because she's excited, how should we react?", "dance with her", "watch silently"),
        ("Ethan is whispering because he's in a library, what should we do?", "whisper back", "speak normally"),
        ("Ava looks confused during a lesson, what could we ask her?", "do you need help?", "why don't you get it?"),
        ("Noah laughed when he fell down, how should we respond?", "laugh if he's laughing too", "ignore him"),
        ("Grace is crying because her ice cream fell, what emotion should we feel?", "compassionate", "indifferent"),
        ("Liam found a lost dog and returned it, what should we tell Liam?", "that was kind", "okay"),
        ("Sophia is frowning at her broken toy, how might Sophia feel?", "upset", "bored"),
        ("Mason is sharing his snack with a friend, how should the friend feel?", "grateful", "uninterested"),
        ("Isabella is jumping up and down with joy, what should we do?", "celebrate with her", "ask her to calm down"),
        ("Aiden is building a tower and it keeps falling, what might Aiden feel?", "frustrated", "happy"),
        ("Ella received a postcard from a friend, how should Ella feel?", "pleased", "unimpressed"),
        ("Logan is giving directions to a lost tourist, what should we think of Logan?", "helpful", "nosy"),
        ("Chloe won a prize at the science fair, how should we react?", "congratulate her", "ignore"),
        ("Lucas is quiet and not eating his lunch, what might he be feeling?", "sad or upset", "not hungry"),
        ("Charlotte is giggling because she's being tickled, how should we react?", "smile or giggle along", "tell her to be quiet"),
        ("Henry is looking at a broken vase he didn't break, how might he feel?", "worried", "pleased"),
        ("Amelia is petting a puppy gently, how should the puppy feel?", "comfortable", "annoyed"),
        ("Oliver is apologizing for a mistake, how should we respond?", "forgive him", "criticize him"),
        ("Evelyn is drawing a picture for her mom, how should her mom feel?", "proud", "indifferent")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.setupAudio()
        setupViews()
        displayNewQuestion()
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
    
    
    private func setupViews() {
        questionLabel = UILabel()
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        button1 = createStyledButton()
        button2 = createStyledButton()
        
        self.view.addSubview(questionLabel)
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            questionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            button1.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            button1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button1.widthAnchor.constraint(equalToConstant: 200),
            button1.heightAnchor.constraint(equalToConstant: 50),
            
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            button2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button2.widthAnchor.constraint(equalToConstant: 200),
            button2.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func createStyledButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 1
        button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    private func displayNewQuestion() {
        let randomIndex = Int(arc4random_uniform(UInt32(questionsAndAnswers.count)))
        let questionData = questionsAndAnswers[randomIndex]
        
        currentQuestion = questionData.question
        currentCorrectAnswer = questionData.correct
        
        questionLabel.text = currentQuestion
        
        // Randomly assign correct and incorrect answers to buttons
        if Bool.random() {
            button1.setTitle(questionData.correct, for: .normal)
            button2.setTitle(questionData.incorrect, for: .normal)
        } else {
            button1.setTitle(questionData.incorrect, for: .normal)
            button2.setTitle(questionData.correct, for: .normal)
        }
    }
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        if let answer = sender.title(for: .normal) {
            if answer == currentCorrectAnswer {
                playSound(soundURL: correctSoundURL)
                displayNewQuestion()
            } else {
                playSound(soundURL: incorrectSoundURL)
                // Keep the same question
            }
        }
    }
    
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
}
