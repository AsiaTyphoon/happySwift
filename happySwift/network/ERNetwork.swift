//
//  ERNetwork.swift
//  happySwift
//
//  Created by dfsx1 on 2018/12/4.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit
import AFNetworking

@objcMembers class ERNetwork: NSObject {
    
    typealias progressBlock = (_ progress: Progress?) -> ()
    typealias completionBlock = (_ response: Any?, _ error: NSError?) -> ()
    
    var baseURL = ""
    var path = ""
    private var fullURL = ""
    var request: NSURLRequest?
    var uploadTask: URLSessionUploadTask?
    
    //MARK:-
    override init() {
        super.init()
    }
    
    
    //配置完整URL
    func setupParams() {
        var paramStr = ""
        let propertyList = exPropertyNames()
        for key in propertyList {
            paramStr = paramStr + "\(key)=\(value(forKey: key) ?? "")"
        }
        fullURL = baseURL + path + paramStr
        print("requestURL: \(fullURL)")
    }
    
    
    func startGet(completion: @escaping completionBlock) {
        
        setupParams()
        
        if baseURL.isEmpty {
            completion(nil, unsupportURL())
            return
        }
        
        DispatchQueue.global().async {
            
            AFHTTPSessionManager().get(self.fullURL, parameters: nil, progress: nil, success: { (sessionTask, responseObj) in
                
                DispatchQueue.main.async {
                    completion(responseObj, nil)
                }
                
            }) { (sessionTask, err) in
                
                DispatchQueue.main.async {
                    completion(nil, err as NSError)
                }
                
            }
        }
        
        
    }
    
    func startPost(completion: @escaping completionBlock) {
        
        if baseURL.isEmpty {
            completion(nil, unsupportURL())
            return
        }
        
        AFHTTPSessionManager().post(fullURL, parameters: nil, progress: nil, success: { (task, responseObj) in
            completion(responseObj, nil)
        }) { (task, error) in
            completion(nil, error as NSError)
        }
        
    }
    
    func startUpload(progress: @escaping progressBlock, completion: @escaping completionBlock) {
        
        if baseURL.isEmpty {
            completion(nil, unsupportURL())
            return
        }
        
        guard let request = request else {
            return
        }
        
        uploadTask =  AFHTTPSessionManager().uploadTask(with: request as URLRequest, from: nil, progress: { (pprogress) in
            
            progress(pprogress)
            
        }, completionHandler: { (sessionTask, responsObj, err) in
            
            if let error = err as NSError? {
                completion(responsObj, error)
            }
            else {
                completion(responsObj, nil)
            }
        })
    }
    
    func cancelUpload() {
        uploadTask?.cancel()
    }
    
    func unsupportURL() -> NSError {
        return NSError(domain: "", code: 0, userInfo: nil)
    }
    
}
