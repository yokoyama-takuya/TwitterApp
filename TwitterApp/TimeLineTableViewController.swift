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
import Alamofire

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTwitter()
    }
    
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
    

    @IBAction func tapTweetButton(sender: UIBarButtonItem) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            //CancelもしくはPostを押した際に呼ばれ、投稿画面を閉じる処理を行っています。
            vc.completionHandler = {(result:SLComposeViewControllerResult) -> () in
                vc.dismissViewControllerAnimated(true, completion:nil)
            }
            
            ////投稿画面の初期値設定
            //vc.setInitialText("初期テキストを設定できます。")
            //vc.addURL(NSURL(string:"シェアURLを設定できます。"))
            self.presentViewController(vc, animated: true, completion: nil)
            
        }else{
            print("******** アカウント未設定エラー")
        }
    }

    
    
    /*
    *   Twitterのアクセストークンを取得
    */
    
    func loginTwitter(){
        
        //Twitterが登録されていないケース
        if !SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            return
        }
        
        let store = ACAccountStore();
        let type = store.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        store.requestAccessToAccountsWithType(type, options: nil) { (granted, error) -> Void in
            
            if error != nil{
                return;
            }
            
            if granted == false{
                //アカウントは登録されているが認証が拒否されたケース
                return;
            }
            
            let accounts = store.accountsWithAccountType(type);
            
            if accounts.count == 0{
                return;
            }
            
            if let account = accounts[0] as? ACAccount{
                print("自分のアカウント名：「\(account.username)」\n")
                
                //アカウントをメモリに保持
                self.twitterAccount = account
                
                //タイムラインの取得
                self.downloadTwitterTimeLine()
            }
        }
    }
    
    /*
    *	Twitterのタイムラインを取得する
    */
    
    func downloadTwitterTimeLine(){
        
        //自分の投稿一覧は「user_timeline.json」で取得可能
        let URL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        let preRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: URL, parameters: nil)
        preRequest.account = twitterAccount
        
        Alamofire.request(preRequest.preparedURLRequest()).responseJSON { _, _, result in
            
            if result.isSuccess,
                let json = result.value as? [[String:AnyObject]]{
                    
                    for entry in json{
                        
                        if let user = entry["user"] as? [String: AnyObject]
                            ,let name = user["name"] as? String
                            ,let imageURLString = user["profile_image_url"] as? String{
                                
                                print("ユーザー名：「\(name)」")
                                print("アイコン画像：「\(imageURLString)」")
                                
                        }
                        
                        if let text = entry["text"] as? String{
                            print(text)
                        }
                        print("------------------------")
                    }
                    
            }
            
        }
        
    }
    


}
