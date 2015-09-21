//
//  TwitterTimeLineFetcher.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/22.
//  Copyright © 2015年 yokoyama. All rights reserved.
//

import Foundation
import SwiftyJSON

class TwitterTimeLineFetcher{
    
    enum TwitterAPIEndPoint: String{
        case HomeTimeLine = "statuses/home_timeline.json"
        case UserTimeLine = "statuses/user_timeline.json"
    }
    
    static func requestHomeTimeLine(parameters:[String:AnyObject] = [:], callback:([TwitterTimeLine]) -> Void){

        self.request(.HomeTimeLine, parameters:parameters, callback:callback)
    }
    
    static func requestUserTimeLine(parameters:[String:AnyObject] = [:], callback:([TwitterTimeLine]) -> Void){
        
        self.request(.UserTimeLine, parameters:parameters, callback:callback)
        
    }
    
    private static func request(endPoint:TwitterAPIEndPoint, parameters:[String:AnyObject] = [:], callback:([TwitterTimeLine]) -> Void){
        

        TwitterAccountManager.requestTwitterAPI(endPoint.rawValue, method: .GET, parameters: parameters) { (result) -> Void in
            
            if result.isFailure{
                print(result.error)
                ExUtil.showAlert(msg: "通信エラーです。電波の良いところで再度お試しください。")
                return
            }
            
            if let res = result.value as? [[String:AnyObject]]{
                
                var dataArray:[TwitterTimeLine] = []
                
                for entry in res{
                    let tweet = TwitterTimeLine(json:JSON(entry))
                    dataArray.append(tweet)
                }
                
                callback(dataArray)
            }
            
        }

    }
    
}