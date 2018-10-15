//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Jacob Frick on 10/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
   
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var favoritedImageView: UIImageView!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var messageCountLabel: UILabel!
    @IBOutlet weak var usernameDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            profileImage.af_setImage(withURL: (tweet?.user?.profilePicture)!)
            nameLabel.text = tweet?.user?.name!
            usernameDateLabel.text = (tweet?.user?.screenName)! + " - " + (tweet?.createdAtString)!
            favoriteCountLabel.text = "\((tweet?.favoriteCount)!)"
            tweetTextLabel.text = tweet?.text!
            retweetCountLabel.text = "\((tweet?.retweetCount)!)"
            replyCountLabel.text = "0"
            if (tweet?.retweeted)! {
                retweetedImageView.image = #imageLiteral(resourceName: "retweet-icon-green.png")
            } else {
                retweetedImageView.image = #imageLiteral(resourceName: "retweet-icon.png")
            }
            if (tweet?.favorited)! {
                favoritedImageView.image = #imageLiteral(resourceName: "favor-icon-red.png")
            } else {
                favoritedImageView.image = #imageLiteral(resourceName: "favor-icon.png")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
