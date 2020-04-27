//
//  ViewController.swift
//  FaceIDApp
//
//  Created by 柿沼儀揚 on 2020/04/27.
//  Copyright © 2020 柿沼儀揚. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

  @IBOutlet weak var resultLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func Pressed(_ sender: Any) {
    
    let context = LAContext()
    let reason = "This app uses Touch ID / Facd ID to secure your data."
    var authError: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
        if success {
          self.setMessage("Authenticated")
        } else {
          let message = error?.localizedDescription ?? "Failed to authenticate"
          self.setMessage(message)
        }
      }
    } else {
      let message = authError?.localizedDescription ?? "canEvaluatePolicy returned false"
      setMessage(message)
    }
  }
  
  func setMessage(_ message: String) {
    DispatchQueue.main.async { [unowned self] in
      self.resultLabel.text = message
    }
  }
  
}
