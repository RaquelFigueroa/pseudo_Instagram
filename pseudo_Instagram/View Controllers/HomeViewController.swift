//
//  HomeViewController.swift
//  pseudo_Instagram
//
//  Created by Raquel Figueroa-Opperman on 2/24/18.
//  Copyright © 2018 Raquel Figueroa-Opperman. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        imageTableView.insertSubview(refreshControl, at: 0)
        imageTableView.dataSource = self
        imageTableView.delegate = self
        
        fetchPosts()
    }

    func fetchPosts() {
        print ("Get posts!")
        let query = Post.query()
        query?.limit = 20
        query?.order(byDescending: "_created_at")
        query?.includeKey("author")
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.imageTableView.reloadData()
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = imageTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]

        cell.postLabel.text = post.caption
        cell.postImageView.file = post.media
        cell.postImageView.loadInBackground()
        
        return cell
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchPosts()
    }
    
    @IBAction func logout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    @IBAction func uploadNewImage(_ sender: Any) {
        performSegue(withIdentifier: "uploadImage", sender: sender)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if (segue.identifier == "uploadImage"){
            _ = segue.destination as! UINavigationController
        }
        else {
            let cell = sender as! UITableViewCell
            if let indexPath = imageTableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let postDetailViewController = segue.destination as! PostDetailViewController
                postDetailViewController.post = post
            }
        }

    }
    
}
