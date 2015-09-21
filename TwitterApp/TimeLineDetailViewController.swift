//
//  TimeLineDetailViewController.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/22.
//  Copyright © 2015年 yokoyama. All rights reserved.
//

import UIKit
import SnapKit
import TTTAttributedLabel

class TimeLineDetailViewController: UIViewController ,TTTAttributedLabelDelegate{

    var tweet:TwitterTimeLine?
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var tweetLabel: TTTAttributedLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet{
            iconImageView.sd_setImageWithURL(NSURL(string: tweet.userIcon))
            
            if tweet.imageURL == ""{
                detailImageView.snp_remakeConstraints(closure: { (make) -> Void in
                    make.height.equalTo(0)
                })
            }else{
                detailImageView.sd_setImageWithURL(NSURL(string: tweet.imageURL))
            }
            
            userLabel.text = tweet.userName
            tweetCountLabel.text = "リツイート : \(tweet.retweetCount)\nファボ : \(tweet.favoriteCount)"
            
            tweetLabel.delegate = self
            tweetLabel.enabledTextCheckingTypes =  NSTextCheckingType.Link.rawValue
            tweetLabel.text = tweet.text
            
            if tweet.favorited{
                favButton.setTitleColor(UIColor.yellowColor(), forState: .Normal)
            }else{
                favButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            }
            
        }
        
    }

    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        
        UIApplication.sharedApplication().openURL(url)
    }

}
