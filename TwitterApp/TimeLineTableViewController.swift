//
//  TimeLineTableViewController.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/12.
//  Copyright (c) 2015年 yokoyama. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    
    var dataArray:[TwitterTimeLine] = []
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterTimeLineFetcher.requestHomeTimeLine(callback: { (array) -> Void in
            self.dataArray += array
            self.tableView.reloadData()
        })
        
    }
    
    //テーブルの件数を登録
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //テーブルの内容を代入
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TimeLineTableViewCell
        
        cell.displayUpdate(dataArray[indexPath.row])
        
        return cell
    }
    

    //投稿ボタンイベント
    @IBAction func tapTweetButton(sender: UIBarButtonItem) {
        
        TwitterAccountManager.showTweetDialog()

    }

        


}
