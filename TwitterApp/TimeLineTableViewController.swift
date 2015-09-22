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
    var refreshUI = UIRefreshControl()
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //引っ張って更新するためのイベント追加
        refreshUI.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshUI)
        
        //初回読み込み
        refreshUI.beginRefreshing()
        fetchTimeLine()
    }
    
    //表示更新
    func refresh(){
        //ロード中は無視する
        if isLoading{
            refreshUI.endRefreshing()
            return
        }
        //先にデータを空にしておく
        dataArray = []
        tableView.reloadData()
        fetchTimeLine()
    }
    
    func fetchTimeLine(){
        if isLoading{
            return
        }
        
        isLoading = true
        
        var params:[String:String] = [:]
        if dataArray.count != 0, let tweet = dataArray.last{
            params = ["max_id":"\(tweet.tweetId - 1)"]
        }
        
        TwitterTimeLineFetcher.requestHomeTimeLine(params, callback: { (array) -> Void in
            self.dataArray += array
            self.tableView.reloadData()
            self.refreshUI.endRefreshing()
            self.isLoading = false
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TimeLineDetailVC") as? TimeLineDetailViewController{
            
            vc.tweet = self.dataArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    //追加読み込み
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if !isLoading && indexPath.row >= (dataArray.count - 10){
            fetchTimeLine()
        }
    }
    

    //投稿ボタンイベント
    @IBAction func tapTweetButton(sender: UIBarButtonItem) {
        
        TwitterAccountManager.showTweetDialog()

    }

        


}
