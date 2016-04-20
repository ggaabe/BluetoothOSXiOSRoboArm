//
//  ViewController.swift
//  Bluetooth Joint Position
//
//  Created by Gabe Garrett on 4/18/16.
//  Copyright © 2016 Gabe. All rights reserved.
//

import Cocoa
import CoreBluetooth
import CoreLocation

class ViewController: NSViewController {

    var bleManager : BLEManager!

    override func viewDidLoad() {
//        var peripheralManager : CBPeripheralManager?

        super.viewDidLoad()
        
            //        super.viewDidAppear(animated)
            bleManager = BLEManager()
            
            
//            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            print("initializizing BLEPeripheralManager")
            
//            peripheralManager = CBPeripheralManager(delegate: self, queue: queue)
            //let manager = BLEManager()
            
            /*peripheralManager{
             print("manager delegated to self")
             manager.delegate = self
             }*/
            
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

//var BPM = BLEPeripheralManager()
//BPM.viewDidAppear()
