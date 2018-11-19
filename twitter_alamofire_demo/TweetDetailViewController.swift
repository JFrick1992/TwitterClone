//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jacob Frick on 10/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetDetailViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var replyTextField: UITextView!
    
    @IBOutlet weak var charCountLabel: UILabel!
    
    

    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        setIntialTweetValues()
        replyTextField.delegate = self
        replyTextField!.layer.borderWidth = 1
        replyTextField!.layer.borderColor = UIColor.lightGray.cgColor
        charCountLabel.text = "0"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setIntialTweetValues() {
        replyButton.setImage(#imageLiteral(resourceName: "reply-icon.png"), for: .normal)
        if(tweet.retweeted)! {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green.png"), for: .normal)
        }else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon.png"), for: .normal)
        }
        if (tweet.favorited)! {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red.png"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon.png"), for: .normal)
        }
        replyCountLabel.text = "0"
        tweetTextLabel.text = tweet?.text!
        nameLabel.text = tweet?.user?.name!
        nameLabel.sizeToFit()
        usernameLabel.text = "@\((tweet?.user?.screenName)!)"
        dateLabel.text = tweet?.createdAtString!
        replyCountLabel.text = "0"
        favoriteCountLabel.text = "\((tweet?.favoriteCount)!)"
        retweetCountLabel.text = "\((tweet?.retweetCount)!)"
        profileImageView.af_setImage(withURL: (tweet.user?.profilePicture)!)
    }
    @IBAction func tappedRetweet(_ sender: Any) {
        if retweetButton.currentImage == #imageLiteral(resourceName: "retweet-icon.png") {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green.png"), for: .normal)
            tweet?.retweetCount! = (tweet?.retweetCount)! + 1
            tweet?.retweeted = true
            performTweetAction(APIManager.TweetAction.retweet)
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon.png"), for: .normal)
            tweet?.retweetCount! -= 1
            tweet?.retweeted = false
            performTweetAction(APIManager.TweetAction.unretweet)
        }
        retweetCountLabel.text = "\((tweet?.retweetCount)!)"
    }
    @IBAction func tappedFavorite(_ sender: Any) {
        if favoriteButton.currentImage == #imageLiteral(resourceName: "favor-icon.png") {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red.png"), for: .normal)
            tweet?.favoriteCount! = (tweet?.favoriteCount)! + 1
            tweet?.favorited = true
            performTweetAction(APIManager.TweetAction.favorite)
            
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon.png"), for: .normal)
            tweet?.favoriteCount! -= 1
            tweet?.favorited = false
            performTweetAction(APIManager.TweetAction.unfavorite)
        }
        favoriteCountLabel.text = "\((tweet?.favoriteCount)!)"
    }

    @IBAction func tappedReply(_ sender: Any) {
        
    }
    
    
    @IBAction func tappedReplyToTweet(_ sender: Any) {
        let text = "\((tweet.user?.screenName)!) \((replyTextField.text)!)"
        APIManager.shared.composeTweet(text, tweet, APIManager.TweetAction.reply) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if tweet != nil {
                //self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.performSegue(withIdentifier: "return", sender: nil)
               
            }
        }
        
    }
    func performTweetAction(_ action: APIManager.TweetAction) {
        APIManager.shared.performTweetAction(tweet!, action) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text!)")
            }
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let charLimit = 140
        let newText = NSString(string: replyTextField.text!).replacingCharacters(in: range, with: text)
        charCountLabel.text = "\(newText.count)"
        return newText.count < charLimit
    }

}

