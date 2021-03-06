//
//  BLEManagerAsCentral.swift
//  Bluetooth Joint Position
//
//  Created by Gabe Garrett on 4/19/16.
//  Copyright © 2016 Gabe. All rights reserved.
//
//

import Foundation
import CoreBluetooth

class BLEManager {
    var centralManager : CBCentralManager
    var bleHandler : BLEHandler
    init(){
        self.bleHandler = BLEHandler()
        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue: nil)
    }
}

class BLEHandler : NSObject, CBCentralManagerDelegate, CBPeripheralDelegate{
    override init(){
        super.init()
    }
    let serviceUUid = CBUUID(string: "A8BBDEFF-DE0B-4998-AE60-8CFC5A9E7C7B")//CBUUID(NSUUID: uuid)
    let advertisementUUID = CBUUID(string: "5BCDBFD2-9053-4E2E-8A3E-8A01D213D9AA")
    let characteristicUUID = CBUUID(string: "B4148580-E8E9-48F5-BDAD-691839C7DDFB")
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch(central.state){
        case .Unsupported:
            print("BLE is Unsupported")
        case .Unauthorized:
            print("BLE is Unauthorized")
        case .Unknown:
            print("BLE is unknown")
        case .Resetting:
            print("BLE is resetting")
        case .PoweredOff:
            print("BLE is powered off")
        case .PoweredOn:
            print("BLE is powered on")
            print("Start scanning")
            central.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
    
    var peripherals = [CBPeripheral]()
    var centrals = [CBCentralManager]()
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("peripheral found! " + String(peripheral))
        if((peripheral.name) == "Robot Arm Peripheral"){ //change to NSUUID
            print("FOUND IPHONE!")
            //peripheral.delegate = self
            self.peripherals.append(peripheral)
            self.centrals.append(central)
            central.connectPeripheral(peripherals[0], options: nil)
        }
        print("Advertisement data: " + String(advertisementData))
        print("Services: " + String(peripheral.services))
   
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("Failed to connect \(peripheral) cause of \(error)")
    }
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("CONNECTED to \(peripheral)")
        //central.stopScan()
        //NOTE TO SELF: RUN THIS. THEN THE LAPTOP FINDS THE CHARACTERISTSICS FOR SOME REASON. THEN COMMENT OUT AND IT FINDS IT AGAIN. INCONSISTENT BEHAVIOR. EXHAUSTIVE SCANNING FORCES LAPTOP TO MEMORIZE THE CHARACTERISTIC THOUGH.
        
        peripherals[0].delegate = self
        peripherals[0].discoverServices([serviceUUid])
        print("CONNECTED SERVICES: " + String(peripherals[0].services))

    }
    
    
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        print("S E R V I C E S: \(peripherals[0].services) and error \(error)")
        peripherals[0].services
        if let services = peripherals[0].services {
            for service in services {
                print("discovering characteristics")
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?)
    {
        print("peripheral:\(peripheral) and service:\(service)")
        for characteristic in service.characteristics!
        {
            print("Found characteristic!")
            peripheral.setNotifyValue(true, forCharacteristic: characteristic)
            centrals[0].stopScan()
            print("Subscribed!")
            print(characteristic)
        }
    }
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?)
    {
        print(NSString(data: characteristic.value!, encoding:NSUTF8StringEncoding) as! String)
    }
}