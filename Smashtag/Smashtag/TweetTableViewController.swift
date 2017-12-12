//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Ömer Yetik on 03/12/2017.
//  Copyright © 2017 Ömer Yetik. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController, UITextFieldDelegate {

    // MARK: - Model

    private var tweets = [Array<Twitter.Tweet>]() {
        didSet {
            print(tweets)
//            enhancedTweets = tweets.map { arrayOfTweets in
//                return arrayOfTweets.map { item in
//                    var enhancedTweet = EnhancedTweet()
//                    enhancedTweet.tweet = item
//                    return enhancedTweet
//                }
//            }
        }
    }
    
//    private var enhancedTweets = [Array<EnhancedTweet>]()
    
//    Assignment #4 Tasks - Begin
    
//    private struct EnhancedTweet {
//        var tweet: Twitter.Tweet?
//        var highlightedText: NSAttributedString? {
//            if let currentTweet = tweet {
//                let highlightedTweetText = NSMutableAttributedString(string:currentTweet.text)
//                
//                for item in currentTweet.hashtags {
//                    highlightedTweetText.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: item.nsrange)
//                }
//            
//                for item in currentTweet.urls {
//                    highlightedTweetText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: item.nsrange)
//                }
//                
//                for item in currentTweet.userMentions {
//                    highlightedTweetText.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: item.nsrange)
//                }
//
//            
//                return highlightedTweetText
//            } else {
//                return nil
//            }
//        }
//    }
    
//    Assignment #4 Tasks - End
    
    
    var searchText: String? {
        didSet {
            searchTextField?.text = searchText
            searchTextField?.resignFirstResponder()
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        }
    }
    
    private func twitterRequest() -> Twitter.Request? {
        if let query = searchText, !query.isEmpty {
            return Twitter.Request(search: query, count: 100)
        }
        return nil
    }
    
    private var lastTwitterRequest: Twitter.Request?
    
    private func searchForTweets() {
        if let request = twitterRequest() {
            lastTwitterRequest = request
            request.fetchTweets { [weak self] newTweets in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.tweets.insert(newTweets, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchText = searchTextField.text
        }
        return true
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweet", for: indexPath)

        let tweet: Tweet = tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }

        return cell
    }

}