//
//  UIViewControllerExtension.swift
//  PeerToPeerBLE
//
//  Created by AL on 28/02/2020.
//  Copyright © 2020 AL. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayAlertWithText(str:String)  {
        let a = UIAlertController(title: "Message reçu", message: str, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(a, animated: true, completion: nil)
    }
}
