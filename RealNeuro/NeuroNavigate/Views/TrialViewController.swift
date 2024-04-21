//
//  TrialViewController.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/20/24.
//

import UIKit

class TrialViewController: UIViewController, UITextViewDelegate {
    
    
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
    
    private let conversationButton: UIButton = {
        let conversationButton = UIButton()
        conversationButton.backgroundColor = UIColor(cgColor: CGColor(red: 255/255, green: 146/255, blue: 1/255, alpha: 1))
        conversationButton.layer.cornerRadius = 75
//        conversationButton.setImage(UIImage(systemName: "sun.min"), for: .normal)
//        conversationButton.imageView?.contentMode = .
        return conversationButton
    }()
    
    private let newWorkoutImage: UIImageView = {
        let newWorkoutImage = UIImageView(image: UIImage(systemName: "dumbbell.fill"))
        newWorkoutImage.tintColor = .white
        return newWorkoutImage
    }()
    
    private let oldWorkoutButton: UIButton = {
        let conversationButton = UIButton()
        conversationButton.backgroundColor = UIColor(cgColor: CGColor(red: 255/255, green: 255/255, blue: 1/255, alpha: 1))
        conversationButton.layer.cornerRadius = 75
        return conversationButton
    }()
    
    private let oldWorkoutImage: UIImageView = {
        let oldWorkoutImage = UIImageView(image: UIImage(systemName: "clock.fill"))
        oldWorkoutImage.tintColor = .white
        return oldWorkoutImage
    }()
    
    private let nutritionButton: UIButton = {
        let nutritionButton = UIButton()
        nutritionButton.backgroundColor = UIColor(cgColor: CGColor(red: 75/255, green: 160/255, blue: 26/255, alpha: 1))
        nutritionButton.layer.cornerRadius = 75
        return nutritionButton
    }()
    
    private let nutritionImage: UIImageView = {
        let nutritionImage = UIImageView(image: UIImage(systemName: "carrot.fill"))
        nutritionImage.tintColor = .white
        return nutritionImage
    }()
    
    private let personalInformationButton: UIButton = {
        let personalInformationButton = UIButton()
        personalInformationButton.backgroundColor = .systemBlue
        personalInformationButton.layer.cornerRadius = 75
        return personalInformationButton
    }()
    
    private let personalImage: UIImageView = {
        let nutritionImage = UIImageView(image: UIImage(systemName: "person.fill"))
        nutritionImage.tintColor = .white
        return nutritionImage
    }()
    
    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "Wallpaper")
        backgroundImageView.contentMode = .scaleAspectFill
        return backgroundImageView
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
    
    private let progressView = CustomButton(title: "Progress", hasBackground: true, fontsize: .big, buttonColor: .red, titleColor: .white, cornerRadius: 10)

    
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
        self.personalInformationButton.addTarget(self, action: #selector(didTapPersonalInformation), for: .touchUpInside)
        self.nutritionButton.addTarget(self, action: #selector(didTapNutrition), for: .touchUpInside)
        self.oldWorkoutButton.addTarget(self, action: #selector(didTapWorkoutHistory), for: .touchUpInside)
        self.termsTextView.delegate = self
//
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTapBack))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundImageView.frame = self.view.bounds
    }
    
    
    private func setupUI(){
        
        self.view.addSubview(conversationButton)
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(oldWorkoutButton)
        self.view.addSubview(nutritionButton)
        self.view.addSubview(personalInformationButton)
        self.view.addSubview(newWorkoutImage)
        self.view.addSubview(oldWorkoutImage)
        self.view.addSubview(personalImage)
        self.view.addSubview(nutritionImage)
        self.view.addSubview(termsTextView)
        self.view.addSubview(welcomeLabel2)
        self.view.addSubview(progressView)
        self.view.addSubview(backgroundImageView)
        
        
        conversationButton.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        oldWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        nutritionButton.translatesAutoresizingMaskIntoConstraints = false
        personalInformationButton.translatesAutoresizingMaskIntoConstraints = false
        newWorkoutImage.translatesAutoresizingMaskIntoConstraints = false
        oldWorkoutImage.translatesAutoresizingMaskIntoConstraints = false
        nutritionImage.translatesAutoresizingMaskIntoConstraints = false
        personalImage.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel2.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.frame = self.view.bounds
        
        NSLayoutConstraint.activate([
            
            self.welcomeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
//            self.welcomeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//            self.welcomeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.welcomeLabel.heightAnchor.constraint(equalToConstant: 180),
            self.welcomeLabel.widthAnchor.constraint(equalToConstant: 300),
            
            self.welcomeLabel2.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 0),
            self.welcomeLabel2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.welcomeLabel2.heightAnchor.constraint(equalToConstant: 50),
            
            self.progressView.topAnchor.constraint(equalTo: self.welcomeLabel2.bottomAnchor, constant: 30),
            self.progressView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.progressView.heightAnchor.constraint(equalToConstant: 50),
            self.progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.progressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
        
            self.conversationButton.topAnchor.constraint(equalTo: self.progressView.topAnchor, constant: 70),
            self.conversationButton.widthAnchor.constraint(equalToConstant: 150),
            self.conversationButton.heightAnchor.constraint(equalToConstant: 150),
            self.conversationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            

            self.oldWorkoutButton.topAnchor.constraint(equalTo: self.progressView.topAnchor, constant: 70),
            self.oldWorkoutButton.widthAnchor.constraint(equalToConstant: 150),
            self.oldWorkoutButton.heightAnchor.constraint(equalToConstant: 150),
            self.oldWorkoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            
            self.nutritionButton.topAnchor.constraint(equalTo: self.conversationButton.bottomAnchor, constant: 30),
            self.nutritionButton.widthAnchor.constraint(equalToConstant: 150),
            self.nutritionButton.heightAnchor.constraint(equalToConstant: 150),
            self.nutritionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            
            self.personalInformationButton.topAnchor.constraint(equalTo: self.oldWorkoutButton.bottomAnchor, constant: 30),
            self.personalInformationButton.widthAnchor.constraint(equalToConstant: 150),
            self.personalInformationButton.heightAnchor.constraint(equalToConstant: 150),
            self.personalInformationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            
            self.newWorkoutImage.centerXAnchor.constraint(equalTo: self.conversationButton.centerXAnchor),
            self.newWorkoutImage.centerYAnchor.constraint(equalTo: self.conversationButton.centerYAnchor),
            self.newWorkoutImage.widthAnchor.constraint(equalToConstant: 150),
            self.newWorkoutImage.heightAnchor.constraint(equalToConstant: 100),
            
            self.oldWorkoutImage.centerXAnchor.constraint(equalTo: self.oldWorkoutButton.centerXAnchor),
            self.oldWorkoutImage.centerYAnchor.constraint(equalTo: self.oldWorkoutButton.centerYAnchor),
            self.oldWorkoutImage.widthAnchor.constraint(equalToConstant: 100),
            self.oldWorkoutImage.heightAnchor.constraint(equalToConstant: 100),
            
            self.personalImage.centerXAnchor.constraint(equalTo: self.personalInformationButton.centerXAnchor),
            self.personalImage.centerYAnchor.constraint(equalTo: self.personalInformationButton.centerYAnchor),
            self.personalImage.widthAnchor.constraint(equalToConstant: 100),
            self.personalImage.heightAnchor.constraint(equalToConstant: 100),
            
            self.nutritionImage.centerXAnchor.constraint(equalTo: self.nutritionButton.centerXAnchor),
//            self.nutritionImage.centerYAnchor.constraint(equalTo: self.nutritionButton.centerYAnchor),
            self.nutritionImage.widthAnchor.constraint(equalToConstant: 100),
            self.nutritionImage.heightAnchor.constraint(equalToConstant: 100),
            self.nutritionImage.topAnchor.constraint(equalTo: self.nutritionButton.topAnchor, constant: 20),
            
            
            
            self.termsTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            self.termsTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
            
            
            
        
        
        
        
        
        ])
        self.view.sendSubviewToBack(welcomeLabel)
        self.view.sendSubviewToBack(backgroundImageView)
        
        
        
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
    
    @objc func didTapPersonalInformation() {
        let vc = ViewController()//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapNutrition() {
        let vc = ViewController()
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

