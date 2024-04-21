//
//  FunFactViewController.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/21/24.
//

import UIKit

class FunFactViewController: UIViewController {
    
    private let funFactBank = [
        "Dolphins sleep with one eye open to watch out for predators and friends.",
        "Cows can walk upstairs but can't walk back down.",
        "Penguins propose to their mates with a pebble.",
        "Bananas are berries, but strawberries aren't.",
        "A group of flamingos is called a 'flamboyance'.",
        "Kangaroos can't walk backwards.",
        "Octopuses have three hearts and blue blood.",
        "A snail can sleep for three years if it doesn’t feel like waking up.",
        "Slugs have four noses to smell all the good stuff in the garden.",
        "A shrimp's heart is in its head.",
        "A group of porcupines is called a 'prickle'.",
        "Turtles can breathe through their butts.",
        "Jellyfish are made up of about 95% water.",
        "The unicorn is the national animal of Scotland.",
        "The longest recorded flight of a chicken is 13 seconds.",
        "Honey never spoils. You can eat 3000-year-old honey!",
        "A crocodile can't stick its tongue out.",
        "An ostrich's eye is bigger than its brain.",
        "Elephants are the only animals that can't jump.",
        "A rhinoceros' horn is made of hair.",
        "Frogs can't vomit. If they have to, they vomit their entire stomach.",
        "Apples float in water because 25% of their volume is air.",
        "Reindeer eyes turn blue in winter to help them see at lower light levels.",
        "Cats have whiskers on the backs of their front legs as well.",
        "Goldfish can see both infrared and ultraviolet light.",
        "Beavers can hold their breath for 15 minutes underwater.",
        "A woodpecker can peck 20 times per second.",
        "The word 'muscle' comes from a Latin term meaning 'little mouse', which is what ancient Romans thought flexed muscles resembled.",
        "Ants stretch when they wake up in the morning.",
        "A group of crows is called a 'murder'.",
        "Dragonflies have six legs but can't walk.",
        "Most lipsticks contain fish scales.",
        "It's impossible to hum while holding your nose.",
        "Giraffes have no vocal cords.",
        "An armadillo’s shell is so hard, it can deflect a bullet.",
        "Bats always turn left when exiting a cave.",
        "A single spaghetti noodle is called a 'spaghetto'.",
        "Your taste buds are replaced every 2 weeks.",
        "A group of unicorns is called a 'blessing'.",
        "Lobsters have blue blood."
        ]
    
    private let label1: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        label1.textAlignment = .center
        label1.numberOfLines = 2
        self.view.addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            self.label1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        
        
        ])
        
        
        var randomNumber = Int.random(in: 0...39)
        
        label1.text = self.funFactBank[randomNumber]
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
