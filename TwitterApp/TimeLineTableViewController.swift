//
//  TimeLineTableViewController.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/12.
//  Copyright (c) 2015年 yokoyama. All rights reserved.
//

import UIKit
import Social
import Accounts

class TimeLineTableViewController: UITableViewController {
    
    var twitterAccount:ACAccount?
    
    var dataArray:[[String:String]] = [
        
        [
            "title":"タイトル1",
            "image":"http://ux-mobile.net/data/public/spartacamp/201509/twitter_icon.png"
        ],
        
        [
            "title":"タイトル2",
            "image":"http://ux-mobile.net/data/public/spartacamp/201509/twitter_icon.png"
        ]
    ]
    
    //テーブルの件数を登録
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //テーブルの内容を代入
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //セルを内部的にリサイクルしているのでこちらが必須になります。
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TimeLineTableViewCell
        
        
        print("表示したいIndex : \(indexPath.row)")
        
        if let title = dataArray[indexPath.row]["title"]{
            cell.tweetLabel.text = title
        }
        
        if let urlString = dataArray[indexPath.row]["image"]{
            cell.iconImageView?.sd_setImageWithURL(NSURL(string: urlString))
        
        }
        
        return cell
    }
    

    

}
