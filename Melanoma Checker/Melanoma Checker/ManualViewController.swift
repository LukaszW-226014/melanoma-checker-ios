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
        let main = UIStoryboard(name: "Main", bundle: nil)
        let home = main.instantiateViewController(withIdentifier: "HomeVC")
        self.present(home, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
