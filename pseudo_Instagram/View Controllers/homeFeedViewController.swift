//
//  homeFeedViewController.swift
//  pseudo_Instagram
//
//  Created by Raquel Figueroa-Opperman on 2/24/18.
//  Copyright © 2018 Raquel Figueroa-Opperman. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class homeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var posts: [Post] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(homeFeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        imageView.insertSubview(refreshControl, at: 0)
        imageView.dataSource = self
        imageView.delegate = self
        
        fetchPosts()
        
    }

    func fetchPosts() {
        print ("Get posts!")
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.imageView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print(error!.localizedDescription)
                if (error!.localizedDescription == "The Internet connection appears to be offline."){
                    //alert functionality:
                    let alertController = UIAlertController(title: "Network Connection Failure", message: "The Internet connection appears to be offline. Would you like to reload?", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Cancel: Exit App", style: .cancel) { (action) in
                        exit(0)
                    }
                    
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.fetchPosts()
                    }
                    
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true){
                    } 
                }
            }
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchPosts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = imageView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.section]

        cell.postImageView.file = post.media
        cell.postImageView.loadInBackground()
        
        cell.postLabel.text = post.caption
        
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let cell = sender as! UITableViewCell
//
//        if let indexPath =
//
//
//        let cell = sender as! UITableViewCell
//        if let indexPath = imageView.indexPath(for: cell) {
//            let post = posts[indexPath.section]
//            let vc = segue.destination as! PhotoDetailsViewController
//            vc.photoDetail = post
//        }
//    }

    
}
