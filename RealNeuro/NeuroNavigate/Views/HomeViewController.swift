//
//  HomeViewController.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/20/24.
//

import UIKit

class HomePageViewController: UIViewController {
    
    
    private let welcomeLabel: UIImageView = {
       let welcomeLabel = UIImageView(image: UIImage(named: "ACTUALNEW"))
//        welcomeLabel.text = "HELLO YAHIA"
//        welcomeLabel.textColor = .systemRed
//        welcomeLabel.font = .systemFont(ofSize: 50)
        
        return welcomeLabel
    }()
    
    private let welcomeLabel2: UILabel = {
        let welcomeLabel2 = UILabel()
        welcomeLabel2.text = "Let's Learn!"
        welcomeLabel2.textColor = .black
//        welcomeLabel2.font = .systemFont(ofSize: 30)
        welcomeLabel2.font = .boldSystemFont(ofSize: 30)
        
        return welcomeLabel2
    }()
    
//    private let conversationButton: UIButton = {
//        let conversationButton = UIButton()
//        conversationButton.backgroundColor = UIColor(cgColor: CGColor(red: 255/255, green: 146/255, blue: 1/255, alpha: 1))
//        conversationButton.layer.cornerRadius = 10
////        conversationButton.setImage(UIImage(systemName: "sun.min"), for: .normal)
////        conversationButton.imageView?.contentMode = .
//        return conversationButton
//    }()
    
    private let newWorkoutImage: UIImageView = {
        let newWorkoutImage = UIImageView(image: UIImage(systemName: "mouth.fill"))
        newWorkoutImage.tintColor = .white
        return newWorkoutImage
    }()
    
//    private let oldWorkoutButton: UIButton = {
//        let conversationButton = UIButton()
//        conversationButton.backgroundColor = UIColor(cgColor: CGColor(red: 255/255, green: 255/255, blue: 1/255, alpha: 1))
//        conversationButton.layer.cornerRadius = 10
//        return conversationButton
//    }()
    
//    private let oldWorkoutImage: UIImageView = {
//        let oldWorkoutImage = UIImageView(image: UIImage(systemName: "clock.fill"))
//        oldWorkoutImage.tintColor = .white
//        return oldWorkoutImage
//    }()
    
//    private let questionButton: UIButton = {
//        let questionButton = UIButton()
//        questionButton.backgroundColor = UIColor(cgColor: CGColor(red: 75/255, green: 160/255, blue: 26/255, alpha: 1))
//        questionButton.layer.cornerRadius = 10
//        return questionButton
//    }()
    
    private let nutritionImage: UIImageView = {
        let nutritionImage = UIImageView(image: UIImage(systemName: "person.fill.questionmark"))
        nutritionImage.tintColor = .white
        return nutritionImage
    }()
    
//    private let emotionPracticeButton: UIButton = {
//        let emotionPracticeButton = UIButton()
//        emotionPracticeButton.backgroundColor = .systemBlue
//        emotionPracticeButton.layer.cornerRadius = 10
//        return emotionPracticeButton
//    }()
    
    private let personalImage: UIImageView = {
        let nutritionImage = UIImageView(image: UIImage(systemName: "face.smiling.inverse"))
        nutritionImage.tintColor = .white
        return nutritionImage
    }()
    
    private let conversationButton: RainbowButton = {
        let button = RainbowButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
//        button.setTitle("Conversation", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

//    private let oldWorkoutButton: RainbowButton = {
//        let button = RainbowButton()
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = true
////        button.setTitle("Old Workouts", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        return button
//    }()

    private let questionButton: RainbowButton = {
        let button = RainbowButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
//        button.setTitle("Nutrition", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private let emotionPracticeButton: RainbowButton = {
        let button = RainbowButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
//        button.setTitle("Personal Info", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    
    
//    private let progressView: UIProgressView = {
//        let progressView = UIProgressView(progressViewStyle: .bar)
//        progressView.progressTintColor = .red
//        progressView.layer.borderColor = CGColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
//        progressView.layer.borderWidth = 2.0
//        progressView.layer.cornerRadius = 15
//        progressView.progress = 0.2
//        return progressView
//    }()
//    private let progressView: RoundedProgressView = {
//        let progressView = RoundedProgressView(progressViewStyle: .bar)
//        progressView.progressTintColor = .red
//        progressView.trackTintColor = .white
//        progressView.layer.borderColor = UIColor.red.cgColor
//        progressView.layer.borderWidth = 2.0
//        progressView.progress = 0.5
//        return progressView
//    }()
    
    private let progressView2 = CustomButton(title: "Fun Fact of the Day!", hasBackground: false, fontsize: .big, buttonColor: .red, titleColor: .white, cornerRadius: 10)
    private let progressView: RainbowProgressView = {
        let progressView = RainbowProgressView()
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.backgroundColor = .white  // Set the background color to white or any other fitting background
        progressView.progress = 1.0
        return progressView
    }()


    
    private let termsTextView: UITextView = {
        
        let attributedString = NSMutableAttributedString(string: "Check out our Terms & Conditions and Privacy Policy")
        
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        
        tv.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1))]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .black
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupUI()
        self.conversationButton.addTarget(self, action: #selector(didTapConversationButton), for: .touchUpInside)
        self.emotionPracticeButton.addTarget(self, action: #selector(didTapPersonalInformation), for: .touchUpInside)
        self.questionButton.addTarget(self, action: #selector(didTapQuestion), for: .touchUpInside)
//        self.oldWorkoutButton.addTarget(self, action: #selector(didTapWorkoutHistory), for: .touchUpInside)
        self.progressView2.addTarget(self, action: #selector(didTapFunFact), for: .touchUpInside)
        self.termsTextView.delegate = self
//
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTapBack))
    }
    
    
    private func setupUI(){
        
        self.view.addSubview(conversationButton)
        self.view.addSubview(welcomeLabel)
//        self.view.addSubview(oldWorkoutButton)
        self.view.addSubview(questionButton)
        self.view.addSubview(emotionPracticeButton)
        self.view.addSubview(newWorkoutImage)
//        self.view.addSubview(oldWorkoutImage)
        self.view.addSubview(personalImage)
        self.view.addSubview(nutritionImage)
        self.view.addSubview(termsTextView)
        self.view.addSubview(welcomeLabel2)
        self.view.addSubview(progressView)
        self.view.addSubview(progressView2)
        
        
        conversationButton.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
//        oldWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        questionButton.translatesAutoresizingMaskIntoConstraints = false
        emotionPracticeButton.translatesAutoresizingMaskIntoConstraints = false
        newWorkoutImage.translatesAutoresizingMaskIntoConstraints = false
//        oldWorkoutImage.translatesAutoresizingMaskIntoConstraints = false
        nutritionImage.translatesAutoresizingMaskIntoConstraints = false
        personalImage.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel2.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.welcomeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
//            self.welcomeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//            self.welcomeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.welcomeLabel.heightAnchor.constraint(equalToConstant: 180),
            self.welcomeLabel.widthAnchor.constraint(equalToConstant: 300),
            
            self.welcomeLabel2.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 0),
            self.welcomeLabel2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.welcomeLabel2.heightAnchor.constraint(equalToConstant: 50),
            
            self.progressView.topAnchor.constraint(equalTo: self.welcomeLabel2.bottomAnchor, constant: 80),
            self.progressView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.progressView.heightAnchor.constraint(equalToConstant: 50),
            self.progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.progressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            
            self.progressView2.topAnchor.constraint(equalTo: self.welcomeLabel2.bottomAnchor, constant: 80),
            self.progressView2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.progressView2.heightAnchor.constraint(equalToConstant: 50),
            self.progressView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.progressView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
        
            
            

//            self.oldWorkoutButton.topAnchor.constraint(equalTo: self.progressView.topAnchor, constant: 70),
//            self.oldWorkoutButton.widthAnchor.constraint(equalToConstant: 150),
//            self.oldWorkoutButton.heightAnchor.constraint(equalToConstant: 150),
//            self.oldWorkoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            
            self.questionButton.topAnchor.constraint(equalTo: self.progressView.topAnchor, constant: 70),
            self.questionButton.widthAnchor.constraint(equalToConstant: 100),
            self.questionButton.heightAnchor.constraint(equalToConstant: 100),
//            self.questionButton.leadingAnchor.constraint(equalTo: self.conversationButton.trailingAnchor, constant: 30),
            self.questionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.conversationButton.topAnchor.constraint(equalTo: self.progressView.topAnchor, constant: 70),
            self.conversationButton.widthAnchor.constraint(equalToConstant: 100),
            self.conversationButton.heightAnchor.constraint(equalToConstant: 100),
            self.conversationButton.trailingAnchor.constraint(equalTo: self.questionButton.leadingAnchor, constant: -30),
            
            self.emotionPracticeButton.topAnchor.constraint(equalTo: self.progressView.topAnchor, constant: 70),
            self.emotionPracticeButton.widthAnchor.constraint(equalToConstant: 100),
            self.emotionPracticeButton.heightAnchor.constraint(equalToConstant: 100),
            self.emotionPracticeButton.leadingAnchor.constraint(equalTo: self.questionButton.trailingAnchor, constant: 30),
            
            self.newWorkoutImage.centerXAnchor.constraint(equalTo: self.conversationButton.centerXAnchor),
            self.newWorkoutImage.centerYAnchor.constraint(equalTo: self.conversationButton.centerYAnchor),
            self.newWorkoutImage.widthAnchor.constraint(equalToConstant: 65),
            self.newWorkoutImage.heightAnchor.constraint(equalToConstant: 50),
            
//            self.oldWorkoutImage.centerXAnchor.constraint(equalTo: self.oldWorkoutButton.centerXAnchor),
//            self.oldWorkoutImage.centerYAnchor.constraint(equalTo: self.oldWorkoutButton.centerYAnchor),
//            self.oldWorkoutImage.widthAnchor.constraint(equalToConstant: 100),
//            self.oldWorkoutImage.heightAnchor.constraint(equalToConstant: 100),
            
            self.personalImage.centerXAnchor.constraint(equalTo: self.emotionPracticeButton.centerXAnchor),
            self.personalImage.centerYAnchor.constraint(equalTo: self.emotionPracticeButton.centerYAnchor),
            self.personalImage.widthAnchor.constraint(equalToConstant: 50),
            self.personalImage.heightAnchor.constraint(equalToConstant: 50),
            
            self.nutritionImage.centerXAnchor.constraint(equalTo: self.questionButton.centerXAnchor),
//            self.nutritionImage.centerYAnchor.constraint(equalTo: self.questionButton.centerYAnchor),
            self.nutritionImage.widthAnchor.constraint(equalToConstant: 60),
            self.nutritionImage.heightAnchor.constraint(equalToConstant: 50),
            self.nutritionImage.topAnchor.constraint(equalTo: self.questionButton.topAnchor, constant: 20),
            
            
            
            self.termsTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            self.termsTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
            
            
            
        
        
        
        
        
        ])
        self.view.sendSubviewToBack(welcomeLabel)
        
        
        
    }
    
    @objc func didTapConversationButton(){
//        let vc = SelectWorkoutViewController()
//        vc.modalPresentationStyle = .fullScreen // You can adjust the presentation style as needed
//        present(vc, animated: true, completion: nil)
        
        let vc = ConversationViewController(exercise: 5)
        //        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didTapFunFact(){
//        let vc = SelectWorkoutViewController()
//        vc.modalPresentationStyle = .fullScreen // You can adjust the presentation style as needed
//        present(vc, animated: true, completion: nil)
        
        let vc = FunFactViewController()
        //        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didTapPersonalInformation() {
        let vc = EmotionRegulatorController(exercise: 5)//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapQuestion() {
        let vc = QuestionsViewController()
//        vc.delegate = self
//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapWorkoutHistory() {
        let vc = ViewController()
//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapBack() {
        self.dismiss(animated: true, completion: nil)
    }



}

//extension HomePageViewController: NutritionViewControllerDelegate {
//    func didUpdateTotalCalories(_ totalCalories: Int) {
//        totalCaloriesLabel.text = "Calories: \(totalCalories)"
//    }
//}

extension HomePageViewController: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=en")
        } else if URL.scheme == "privacy" {
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=en")
        }
        
        
        return true
    }
    
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewerController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}




