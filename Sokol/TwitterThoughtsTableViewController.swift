//
//  TwitterThoughtsTableViewController.swift
//  Sokol
//
//  Created by Andres Rene Gutierrez on 22/06/2016.
//  Copyright © 2016 Andres Rene Gutierrez. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit

class TwitterThoughtsTableViewController: UITableViewController,TWTRTweetViewDelegate {
    let userId = Twitter.sharedInstance().sessionStore.session()?.userID
    var tweetsID:[Int] = []
    var tweets:[AnyObject] = []
    let tweetTableReuseIdentifier = "TweetCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient(userID: userId)
        tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: tweetTableReuseIdentifier)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false

        
        
        let request = client.URLRequestWithMethod("GET", URL: "https://api.twitter.com/1.1/search/tweets.json?q=%23SokolApp", parameters: nil, error: nil)
        client.sendTwitterRequest(request, completion: { (response, data, connectionError) in
            if connectionError != nil {
                print(connectionError?.description)
            }else{
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    let tweets = json!["statuses"] as! [AnyObject]
                    self.tweetsID = []
                    for t in tweets {
                        self.tweetsID.append(t["id"] as! Int)
                        
                    }
                    self.getTweets(self.tweetsID)
                    
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }
                
            }
        })
        
                // Do any additional setup after loading the view.
    }
    func getTweets(ids:[Int]){
        tweets = []
        let client = TWTRAPIClient(userID: userId)
        for i in ids {
            client.loadTweetWithID(String(i), completion:{tweet,error in
                if let t = tweet {
                    self.tweets.append(t)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.tableView.reloadData()
                        
                    })
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

 

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(tweetTableReuseIdentifier, forIndexPath: indexPath) as! TWTRTweetTableViewCell
        cell.tweetView.delegate = self
        let tweet = tweets[indexPath.row]
        cell.configureWithTweet(tweet as! TWTRTweet)
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
