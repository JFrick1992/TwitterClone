//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet var tableView: UITableView!
    var tweets = [Tweet]()
    let refreshcontrol = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        refreshcontrol.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshcontrol, at: 0)
        fecthTweets()
        
    }
    func refreshControlAction(_ refreshcontrol: UIRefreshControl) {
        refreshcontrol.beginRefreshing()
        fecthTweets()
    }
    func fecthTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                if self.refreshcontrol.isRefreshing {
                    self.refreshcontrol.endRefreshing()
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    @IBAction func didTapLogOut(_ sender: Any) {
        APIManager.shared.logout()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        if tweets.count > 0 {
            cell.tweet = tweets[indexPath.row]
            cell.tag = indexPath.row
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tweetDetailSegue" {
            let cell = sender as! TweetCell
            let destination = segue.destination as! TweetDetailViewController
            let indexPath = tableView.indexPath(for: cell)!
            destination.tweet = tweets[indexPath.row]
            cell.setSelected(false, animated: false)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}
