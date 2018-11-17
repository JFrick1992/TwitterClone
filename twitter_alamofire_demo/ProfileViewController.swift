//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jacob Frick on 11/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
class ProfileViewController: UIViewController {
    @IBOutlet weak var usernam: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.getCurrentAccount { (user, error) in
            if let user = user {
                self.usernam.text = user.name
                self.screennameLabel.text = user.screenName
                self.tweetCountLabel.text = "Tweets: \(user.statuses_count!)"
                self.followersCountLabel.text = "Followers: \(user.followers_count!)"
                self.followingCountLabel.text = "Following: \(user.friends_count!)"
                self.profileImageView.af_setImage(withURL: user.profilePicture!)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapLogOut(_ sender: Any) {
        APIManager.shared.logout()
    }
    


}
