//
//  ViewController.swift
//  PeerToPeerBLE
//
//  Created by AL on 27/02/2020.
//  Copyright © 2020 AL. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    @IBOutlet weak var serverNameTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var peripherals = [CBPeripheral]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let i = BLEManager.instance
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func ScanButtonClicled(_ sender: UIBarButtonItem) {
        BLEManager.instance.scan { (periph) in
            if !self.peripherals.contains(periph) {
                self.peripherals.append(periph)
                print(periph)
                
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func StartButtonClicked(_ sender: UIBarButtonItem) {
        let serverName = serverNameTextField.text ?? ""
        print(serverName)
        serverNameTextField.resignFirstResponder()
        BLEServer.instance.startServerWithName(name: serverName) { (state) in
            self.stateLabel.text = state.description
            
            BLEServer.instance.listenForMessages { (d) in
                print(String(data: d, encoding: .utf8))
            }
            
        }
    }
}


extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        if let name = peripherals[indexPath.row].name {
            cell.textLabel?.text = name
            cell.textLabel?.textColor = UIColor.black
        }else{
            cell.textLabel?.text = "Inconnu"
            cell.textLabel?.textColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 0.8)
        }
        
        return cell
    }
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let periph  = peripherals[indexPath.row]
        
        BLEManager.instance.connectPeripheral(periph) { (connectedPeriph) in
            if connectedPeriph.state == .connected {
                print(connectedPeriph.description + " is connected")
                
                BLEManager.instance.discoverPeripheral(connectedPeriph) { (readyPeriph) in
                    // on est connectés et capable de communiquer
                    print("ready")
                    // On arrête le scan des autres periphs
                    BLEManager.instance.stopScan()
                    
                    self.performSegue(withIdentifier: "toCommunication", sender: self)
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

