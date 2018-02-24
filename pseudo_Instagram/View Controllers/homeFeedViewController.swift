//
//  homeFeedViewController.swift
//  pseudo_Instagram
//
//  Created by Raquel Figueroa-Opperman on 2/24/18.
//  Copyright © 2018 Raquel Figueroa-Opperman. All rights reserved.
//

import UIKit
import Parse

class homeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageView: UITableView!
    
    var refreshControl: UIRefreshControl!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(homeFeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        imageView.insertSubview(refreshControl, at: 0)
        imageView.dataSource = self
        imageView.delegate = self
        
        fetchImages()
        
    }

    func fetchImages() {
        print ("fetching more images!")
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchImages()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    
}
