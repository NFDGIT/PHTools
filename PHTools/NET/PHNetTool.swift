//
//  NetTool.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public class PHNetTool: NSObject {
//    public static func post(url:String,param:[String:Any]? = nil,response:@escaping ((_ res:(success:Bool,msg:String,data:Dictionary<String, Any>))->(Void)))
//    {
//
//        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (res) in
//            var resultDic : NSMutableDictionary = NSMutableDictionary.init()
//
//            if res.response?.statusCode == 200
//            {
//                // parse response
//                let json = JSON(res.data as Any)
//                resultDic =  NSMutableDictionary.init(dictionary: json.dictionaryObject! as NSDictionary)
//                response((true,"服务器访问成功",resultDic as! Dictionary<String, Any>))
//            }
//            else
//            {
//                response((false,"服务器访问失败",resultDic as! Dictionary<String, Any>))
//            }
//        }
//    }
    public static func send(url:String,method:HTTPMethod = .get,param:[String:Any]? = nil,response:@escaping ((_ res:(success:Bool,msg:String,data:Dictionary<String, Any>))->(Void)))
    {
        Alamofire.request(url, method: method, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (res) in
            var resultDic : NSMutableDictionary = NSMutableDictionary.init()
            
            if res.response?.statusCode == 200
            {
                // parse response
                let json = JSON(res.data as Any)
                resultDic =  NSMutableDictionary.init(dictionary: json.dictionaryObject! as NSDictionary)
                response((true,"服务器访问成功",resultDic as! Dictionary<String, Any>))
            }
            else
            {
                response((false,"服务器访问失败",resultDic as! Dictionary<String, Any>))
            }
        }
    }
    public static func upload(url:String,data:Data,name:String? = "file",fileName:String,mimeType:String? = "image/png",uploadProgress:@escaping ((_ progress:Double)->()),response:@escaping ((_ res:(success:Bool,msg:String,data:Dictionary<String, Any>))->(Void))){
        
        
        //                "file"
        //        "123456.mp4"
        //        "video/mp4"
    
        Alamofire.upload(
            //同样采用post表单上传
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(data, withName: name!, fileName: fileName, mimeType: mimeType!)
                //服务器地址
        },to: url,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //json处理
                upload.responseJSON { res in
                    //解包
                    //                    guard let result = res.result.value else { return }
                    
                    
                    
                    var resultDic : NSMutableDictionary = NSMutableDictionary.init()
                    
                    if res.response?.statusCode == 200
                    {
                        // parse response
                        let json = JSON(res.data as Any)
                        resultDic =  NSMutableDictionary.init(dictionary: json.dictionaryObject! as NSDictionary)
                        response((true,"服务器访问成功",resultDic as! Dictionary<String, Any>))
                    }
                    else
                    {
                        response((false,"服务器访问失败",resultDic as! Dictionary<String, Any>))
                    }
                    
                    //                    print("json:\(result)")
                }
                //上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("文件上传进度: \(progress.fractionCompleted)")
                    uploadProgress(progress.fractionCompleted)
                }
                
                
            case .failure(let encodingError):
                print(encodingError)
                let resultDic : NSMutableDictionary = NSMutableDictionary.init()
                response((false,"服务器访问失败",resultDic as! Dictionary<String, Any>))
            }
        })
        
    }
    
    
    public static func upload(url:String,fileUrl:URL,name:String,fileName:String,mimeType:String = "image/png",uploadProgress:@escaping ((_ progress:Double)->()),response:@escaping ((_ res:(success:Bool,msg:String,data:Dictionary<String, Any>))->(Void))){
        
        
        //        "file"
        //        "123456.mp4"
        //        "video/mp4"
        Alamofire.upload(
            //同样采用post表单上传
            multipartFormData: { multipartFormData in
                
                
                multipartFormData.append(fileUrl, withName: name, fileName: fileName, mimeType: mimeType)
                //服务器地址
        },to: url,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //json处理
                upload.responseJSON { res in
                    //解包
                    //                    guard let result = res.result.value else { return }
                    
                    
                    
                    var resultDic : NSMutableDictionary = NSMutableDictionary.init()
                    
                    if res.response?.statusCode == 200
                    {
                        // parse response
                        let json = JSON(res.data as Any)
                        resultDic =  NSMutableDictionary.init(dictionary: json.dictionaryObject! as NSDictionary)
                        response((true,"服务器访问成功",resultDic as! Dictionary<String, Any>))
                    }
                    else
                    {
                        response((false,"服务器访问失败",resultDic as! Dictionary<String, Any>))
                    }
                    
                    //                    print("json:\(result)")
                }
                //上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("文件上传进度: \(progress.fractionCompleted)")
                    uploadProgress(progress.fractionCompleted)
                }
                
                
            case .failure(let encodingError):
                print(encodingError)
                let resultDic : NSMutableDictionary = NSMutableDictionary.init()
                response((false,"服务器访问失败",resultDic as! Dictionary<String, Any>))
            }
        })
        
        
        
        
    }
    
}
