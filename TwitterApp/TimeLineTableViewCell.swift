//
//  TimeLineTableViewCell.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/13.
//  Copyright (c) 2015年 yokoyama. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class TimeLineTableViewCell: UITableViewCell, TTTAttributedLabelDelegate {

    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: TTTAttributedLabel!

    
    func displayUpdate(timeLine:TwitterTimeLine){
        
        iconImageView.sd_setImageWithURL(NSURL(string: timeLine.userIcon))
        userLabel.text = timeLine.userName
        
        tweetLabel.delegate = self
        tweetLabel.enabledTextCheckingTypes =  NSTextCheckingType.Link.rawValue
        tweetLabel.text = timeLine.text
        
        
    }
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        
        UIApplication.sharedApplication().openURL(url)
    }
}
