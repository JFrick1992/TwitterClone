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
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoritedButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    var tweet: Tweet? {
        didSet {
            tweetTextLabel.text = tweet?.text!
            nameLabel.text = tweet?.user?.name!
            nameLabel.sizeToFit()
            usernameLabel.text = tweet?.user?.screenName!
            dateLabel.text = tweet?.createdAtString!
            replyCountLabel.text = "0"
            favoriteCountLabel.text = "\((tweet?.favoriteCount)!)"
            retweetCountLabel.text = "\((tweet?.retweetCount)!)"
            if (tweet?.favorited)! {
                favoritedButton.setImage(#imageLiteral(resourceName: "favor-icon-red.png"), for: .normal)
            } else {
                favoritedButton.setImage(#imageLiteral(resourceName: "favor-icon.png"), for: .normal)
            }
            if (tweet?.retweeted)! {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green.png"), for: .normal)
            } else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon.png"), for: .normal)
            }
            
        }

    }

    @IBAction func tappedFavorite(_ sender: Any) {
        if favoritedButton.currentImage == #imageLiteral(resourceName: "favor-icon.png") {
            favoritedButton.setImage(#imageLiteral(resourceName: "favor-icon-red.png"), for: .normal)
        } else {
            favoritedButton.setImage(#imageLiteral(resourceName: "favor-icon.png"), for: .normal)
        }
    }
    @IBAction func tappedRetweet(_ sender: Any) {
        if retweetButton.currentImage == #imageLiteral(resourceName: "retweet-icon.png") {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green.png"), for: .normal)
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon.png"), for: .normal)

        }
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon.png"), for: .normal)
        favoritedButton.setImage(#imageLiteral(resourceName: "favor-icon.png"), for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = UIColor.white
        // Configure the view for the selected state
    }

}
