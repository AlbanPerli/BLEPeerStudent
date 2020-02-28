//
//  ViewController.swift
//  BLEChat2
//
//  Created by Guillaume Lagouy on 27/02/2020.
//  Copyright © 2020 Guillaume Lagouy. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet var msgToolbar: UIToolbar!
    @IBOutlet weak var fakeMsgTextfield: UITextField!
    
    @IBOutlet weak var msgTextfield: UITextField!
    
    @IBOutlet weak var msgTableView: UITableView!
    
    struct Message {
        var msgContent:String
        var msgCell:String
    }
    
    var messages:[Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fakeMsgTextfield.delegate = self
        msgTextfield.delegate = self
        msgTableView.delegate = self
        msgTableView.dataSource = self
        
        msgTableView.keyboardDismissMode = .onDrag
      
    }
    
    
    @IBAction func onSendTouched(_ sender: Any) {
        if let text = msgTextfield.text {
            displaySenderMsg(msgContent: text)
        }
    }
    
    // Pour tester l'affichage de la réception d'un message
    @IBAction func onSendRecieverTouched(_ sender: Any) {
        let text = "Oui d'accord"
        displayRecieverMsg(msgContent: text)
    }
    
    func displaySenderMsg(msgContent:String) {
        messages.append(Message(msgContent: msgContent, msgCell: "senderCell"))
        msgTableView.reloadData()
        scrollToEnd()
    }
    
    func displayRecieverMsg(msgContent:String) {
        messages.append(Message(msgContent: msgContent, msgCell: "recieverCell"))
        msgTableView.reloadData()
        scrollToEnd()
    }
    
    func scrollToEnd() {
        let indexPath = NSIndexPath(row: messages.count - 1, section: 0)
        msgTableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
    
    
}

extension ChatViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fakeMsgTextfield {
            textField.inputAccessoryView = msgToolbar
            print(msgTextfield.isFirstResponder)
            if !msgTextfield.isFirstResponder{
                msgTextfield.becomeFirstResponder()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == msgTextfield {
            self.displaySenderMsg(msgContent: textField.text ?? "")
            return true
        }
        return true
    }
}

extension ChatViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension ChatViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = messages[indexPath.row].msgCell
        let msgContent = messages[indexPath.row].msgContent
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MsgTableViewCell
        
        cell.msgTextView.text = msgContent
        
        return cell
    }
    
    
}

