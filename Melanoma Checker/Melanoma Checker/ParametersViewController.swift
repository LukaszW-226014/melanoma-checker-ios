//
//  DiameterViewController.swift
//  Melanoma Checker
//
//  Created by Łukasz Wójcik on 03/12/2018.
//  Copyright © 2018 Łukasz Wójcik. All rights reserved.
//

import UIKit

class ParametersViewController: UIViewController {
    
    var pickedImage: UIImage?

    @IBOutlet weak var sizeChoiceButton: UISegmentedControl!
    
    @IBOutlet weak var evolutionBooleanButton: UISwitch!
    
    @IBAction func backToHome(_ sender: UIBarButtonItem) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let home = main.instantiateViewController(withIdentifier: "HomeVC")
        self.present(home, animated: true, completion: nil)
    }
    
    @IBAction func goToNext(_ sender: UIBarButtonItem) {
        self.next()
    }
    
    private func next() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let results = main.instantiateViewController(withIdentifier: "ResultsVC") as! ResultsViewController
        results.pickedImage = self.pickedImage
        results.diameter = self.sizeChoiceButton.selectedSegmentIndex + 1
        results.evolution = self.evolutionBooleanButton.isOn
        self.present(results, animated: true, completion: nil)
    }
    
    @IBAction func diameterHelp(_ sender: UIButton) {
        self.showAlertBy("Diameter", "Measure mole between extreme points and choose.")
    }
    
    @IBAction func evolutionHelp(_ sender: UIButton) {
        self.showAlertBy("Evolution", "Have you noticed that the mole evolve. If so, check it.")
    }
    
    @IBAction func saveSwitchPressed(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "evolutionState")
    }
    
    @IBAction func saveDiameterSegmentSelect(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "diameterSelect")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .right
        
        view.addGestureRecognizer(edgePan)
        
        sizeChoiceButton.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "diameterSelect")
        evolutionBooleanButton.isOn = UserDefaults.standard.bool(forKey: "evolutionState")

        // Do any additional setup after loading the view.
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.next()
        }
    }
    
    private func showAlertBy(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
