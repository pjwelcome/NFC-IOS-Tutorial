//
//  ViewController.swift
//  NFC Demo
//
//  Created by pjapple on 2017/06/12.
//  Copyright © 2017 Multimeleon. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         _ = NFCReader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

@objc class NFCReader : NSObject{
    
    fileprivate var session : NFCNDEFReaderSession?
    override init() {
        super.init()
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        if let session = session{
            session.begin()
        }
    }
    
    deinit {
        session = nil
    }
}

extension NFCReader: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
        print("Session has been discard or invalidated -> Check your invalidateAfterFirstRead property ")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        print("Session has been discard")
        
        messages.forEach { (message: NFCNDEFMessage) in
            
            message.records.forEach({ (record : NFCNDEFPayload) in
                
                print("payload identifier \(record.identifier), payload body \(record.payload), payload type \(record.type)")
            })
        }
    }
}

extension NFCReader: NFCReaderSessionDelegate {
    
    func readerSession(_ session: NFCReaderSession, didDetect tags: [NFCTag]) {
        
        tags.forEach { (tag : NFCTag) in
            
            print(tag.description)
        }
    }
}

