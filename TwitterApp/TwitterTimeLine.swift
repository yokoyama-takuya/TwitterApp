//
//  TwitterTimeLine.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/22.
//  Copyright © 2015年 yokoyama. All rights reserved.
//

import Foundation
import SwiftyJSON

class TwitterTimeLine{
    
    //投稿ユーザ                             //Jsonパス
    private(set) var userName = ""         //user:name
    private(set) var userIcon = ""         //user:profile_image_url
    //投稿内容
    private(set) var text = ""             //text
    private(set) var imageURL = ""         //entities:0:media:media_url
    private(set) var retweetCount = 0      //retweet_count
    private(set) var favoriteCount = 0     //favorite_count
    private(set) var tweetId = ""           //id_str
    //ログインユーザーの行動フラグ
    private(set) var retweeted = false     //retweetd
    private(set) var favorited = false     //favorited
    
    
    init(json:JSON){
        
        //投稿ユーザー
        userName = json["user"]["name"].stringValue
        userIcon = json["user"]["profile_image_url"].stringValue
        
        //投稿内容
        text = json["text"].stringValue
        
        imageURL = json["entities"]["media"][0]["media_url_https"].stringValue
        if imageURL == ""{
            imageURL = json["entities"]["media"][0]["media_url"].stringValue
        }
        
        retweetCount = json["retweet_count"].intValue
        favoriteCount = json["favorite_count"].intValue
        tweetId = json["id_str"].stringValue
        
        //ログインユーザーの行動フラグ
        retweeted = json["retweetd"].boolValue
        favorited = json["favorited"].boolValue
        
    }
    
    //お気に入り状態のオンオフ
    func changeFavoriteState(){
        if favorited{
            favoriteCount -= 1
        }else{
            favoriteCount += 1
        }
        favorited = !favorited
    }
    
    
}