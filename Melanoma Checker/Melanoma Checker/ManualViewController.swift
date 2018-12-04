//
//  ManualViewController.swift
//  Melanoma Checker
//
//  Created by Łukasz Wójcik on 03/12/2018.
//  Copyright © 2018 Łukasz Wójcik. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {

    @IBAction func backToHome(_ sender: UIBarButtonItem) {
        self.back()
    }
    
    private func back() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let home = main.instantiateViewController(withIdentifier: "HomeVC")
        self.present(home, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)

        // Do any additional setup after loading the view.
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.back()
        }
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
