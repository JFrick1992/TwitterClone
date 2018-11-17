//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jacob Frick on 11/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var newTweetTextView: UITextView!
    
    @IBOutlet weak var charCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        newTweetTextView!.layer.borderWidth = 1
        newTweetTextView!.layer.borderColor = UIColor.lightGray.cgColor
        charCountLabel.text = "0"
        newTweetTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapPost(_ sender: Any) {
        let newPost = newTweetTextView.text
    
        APIManager.shared.getCurrentAccount { (user, error) in
            if let user = user {
                APIManager.shared.composeNewTweet(newPost!, user, APIManager.TweetAction.composeNew, completion: { (user, error) in
                    if let user = user {
                        print("woooo")
                    }
                })
            }
        }
        performSegue(withIdentifier: "postedtweetSegue", sender: nil)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        let newText = NSString(string: newTweetTextView.text!).replacingCharacters(in: range, with: text)
        charCountLabel.text = "\(newText.count)"
        return newText.count < characterLimit
    }

}
