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
            bleManager =  BLEManager()
            
            
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



class BLEPeripheralManager : NSObject, CBPeripheralManagerDelegate {
    
    
    override init(){
        super.init()
    }
    
    /* A newly-generated UUID for our beacon */
    let uuid = NSUUID()
    
    /* The identifier of our beacon is the identifier of our bundle here */
    let identifier2 = NSBundle.mainBundle().bundleIdentifier
    
    /* Made up major and minor versions of our beacon region */
    let major: CLBeaconMajorValue = 1
    let minor: CLBeaconMinorValue = 0
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager,
                                              error: NSError?){
        
        if error == nil{
            print("Successfully started advertising our beacon data")
            
            let message = "Successfully set up your beacon. " +
                "The unique identifier of our service is: \(uuid.UUIDString)"
            
            print(message)
            
            //            let controller = UIAlertController(title: "iBeacon",
            //                                               message: message,
            //                                               preferredStyle: .Alert)
            
            //            controller.addAction(UIAlertAction(title: "OK",
            //                style: .Default,
            //                handler: nil))
            
            //            presentViewController(controller, animated: true, completion: nil)
            
        } else {
            print("Failed to advertise our beacon. Error = \(error)")
        }
        
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager){
        
        //peripheral.stopAdvertising()
        
        //        print("The peripheral state is ", appendNewline: false)
        switch peripheral.state{
        case .PoweredOff:
            print("Powered off")
        case .PoweredOn:
            print("Powered on")
            print("advertising")
        case .Resetting:
            print("Resetting")
        case .Unauthorized:
            print("Unauthorized")
        case .Unknown:
            print("Unknown")
        case .Unsupported:
            print("Unsupported")
        }
        
        /* Bluetooth is now powered on */
        if peripheral.state != .PoweredOn{
            
            print("turn bluetooth on")
            /*          let controller = UIAlertController(title: "Bluetooth",
             message: "Please turn Bluetooth on",
             preferredStyle: .Alert)
             
             controller.addAction(UIAlertAction(title: "OK",
             style: .Default,
             handler: nil))
             
             presentViewController(controller, animated: true, completion: nil)*/
            
        } else {
            print("ADVERTISING SELF")
            
            let manufacturerData = identifier2!.dataUsingEncoding(
                NSUTF8StringEncoding,
                allowLossyConversion: false)
            
            let theUUid = CBUUID(NSUUID: uuid)
            
            let dataToBeAdvertised:[String: AnyObject!] = [
                CBAdvertisementDataLocalNameKey : "Sample peripheral",
                CBAdvertisementDataManufacturerDataKey : manufacturerData,
                CBAdvertisementDataServiceUUIDsKey : [theUUid],
                ]
            
            peripheral.startAdvertising(dataToBeAdvertised)
            
        }
        
    }
}

//var BPM = BLEPeripheralManager()
//BPM.viewDidAppear()
