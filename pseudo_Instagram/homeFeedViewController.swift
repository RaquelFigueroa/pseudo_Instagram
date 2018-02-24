//
//  homeFeedViewController.swift
//  pseudo_Instagram
//
//  Created by Raquel Figueroa-Opperman on 2/24/18.
//  Copyright © 2018 Raquel Figueroa-Opperman. All rights reserved.
//

import UIKit

class homeFeedViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    
}
