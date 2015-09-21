//
//  TimeLineTableViewCell.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/13.
//  Copyright (c) 2015年 yokoyama. All rights reserved.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!

    
    func displayUpdate(timeLine:TwitterTimeLine){
        
        iconImageView.sd_setImageWithURL(NSURL(string: timeLine.userIcon))
        userLabel.text = timeLine.userName
        tweetLabel.text = timeLine.text
    }
}
