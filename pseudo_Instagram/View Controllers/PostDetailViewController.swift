//
//  PostDetailViewController.swift
//  pseudo_Instagram
//
//  Created by Raquel Figueroa-Opperman on 2/24/18.
//  Copyright © 2018 Raquel Figueroa-Opperman. All rights reserved.
//

import UIKit
import ParseUI

class PostDetailViewController: UIViewController {

    @IBOutlet weak var postDetailImage: PFImageView!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postCommentLabel: UILabel!
    
    
    var post: Post?
//    var postImage: PFFile
//    var postDate: String!
//    var postComment: String!
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            let str = post.createdAt!.description

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_Posix")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
            let newDate = formatter.date(from: str)
            
            formatter.dateFormat = "MMMM d, yyyy h:mm a"
            let dateStr = formatter.string(from: newDate!)

            postDateLabel.text = dateStr
            postCommentLabel.text = post["caption"] as? String
            postDetailImage.file = post.media
            postDetailImage.loadInBackground()
//            cell.postImageView.loadInBackground()

        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
