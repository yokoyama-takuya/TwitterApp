//
//  TimeLineTableViewController.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/12.
//  Copyright (c) 2015年 yokoyama. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    
    let dataArray:[[String:String]] = [
        
        [
            "title":"タイトル1",
            "image":"https://scontent.xx.fbcdn.net/hphotos-xal1/t31.0-8/c0.55.851.315/p851x315/10515212_315737341956430_4261430778935915055_o.jpg"
        ],
        
        [
            "title":"タイトル2",
            "image":"https://scontent.xx.fbcdn.net/hphotos-xal1/t31.0-8/c0.55.851.315/p851x315/10515212_315737341956430_4261430778935915055_o.jpg"
        ]
        
    ]
    
    //テーブルの件数を登録
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //テーブルの内容を代入
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //セルを内部的にリサイクルしているのでこちらが必須になります。
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        
        println("表示したいIndex : \(indexPath.row)")
        
        if let title = dataArray[indexPath.row]["title"]{
            cell.textLabel?.text = title
        }
        
        if let urlString = dataArray[indexPath.row]["image"]{
            
            cell.imageView?.sd_setImageWithURL(NSURL(string: urlString)
                , placeholderImage: UIImage(named: "placeholder"))
            
        }
        
        return cell
    }

}
