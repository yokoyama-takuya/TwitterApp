//
//  TwitterFavoriteFetcher.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/22.
//  Copyright © 2015年 yokoyama. All rights reserved.
//

import Foundation

class TwitterFavoriteFetcher {
    
    enum TwitterAPIEndPoint: String{
        case FavoritesCreate = "favorites/create.json"
        case FavoritesDestroy = "favorites/destroy.json"
    }
    
    static func request(tweet:TwitterTimeLine, callback:(success:Bool) -> Void){
        
        let param = ["id":"\(tweet.tweetId)"]
        
        //現在のお気に入り状態でエンドポイントを変更
        var endPoint = TwitterAPIEndPoint.FavoritesCreate
        if tweet.favorited{
           endPoint = TwitterAPIEndPoint.FavoritesDestroy
        }
        
        TwitterAccountManager.requestTwitterAPI(endPoint.rawValue, method: .POST, parameters:param) { (result) -> Void in
            
            if result.isFailure{
                ExUtil.showAlert(msg: "通信エラーです。電波の良いところで再度お試しください。")
                callback(success: false)
                return
            }
            
            callback(success: true)
            
            
        }
        
    }


}