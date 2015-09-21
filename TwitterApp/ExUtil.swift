//
//  ExUtil.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/22.
//  Copyright © 2015年 yokoyama. All rights reserved.
//

import UIKit

typealias ExUtilSimpleCallback = () -> ()
typealias ExUtileAlertCallback = ((UIAlertAction) -> Void)

class ExUtil{
    
    static func getVC()->UIViewController{
        
        let vc = UIApplication.sharedApplication().windows[0].rootViewController
        
        if let nvc = vc as? UINavigationController,
            let visibleVC = nvc.visibleViewController{
                
            return visibleVC
        }
        
        if  let visibleVC = vc{
            return visibleVC
        }
        
        //エラーケース
        return vc!
    }
    
    
    /*
    *   アラート表示
    *   はい、いいえ
    */
    static func showConfirm(title:String = "", msg:String,
        yesCallback:ExUtileAlertCallback?, noCallback:ExUtileAlertCallback?){
            
            let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler:yesCallback))
            alert.addAction(UIAlertAction(title: "いいえ", style: UIAlertActionStyle.Default, handler:noCallback))
            ExUtil.getVC().presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /*
    *   アラート表示
    *   はいのみ
    */
    static func showAlert(title:String = "", msg:String, callback:ExUtileAlertCallback? = nil){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler:callback))
        ExUtil.getVC().presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /*
    *   遅延実行
    */
    class func dispatchAsyncMain (time:Double = 0, callback:ExUtilSimpleCallback? = nil){
        
        if time == 0{
            dispatch_async(dispatch_get_main_queue(), callback!)
            return
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), callback!)
    }
    
}
