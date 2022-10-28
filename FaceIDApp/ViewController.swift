//
//  ViewController.swift
//  FaceIDApp
//
//  Created by Sergey Medvedev on 28.10.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet var statusLabel: UILabel!
        
    @IBAction func authbuttonPressed() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with Face ID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        self.statusLabel.text = "Your Biometric Status: \n" + "Failed"
                        self.statusLabel.textColor = .red
                        self.showAlert(title: "Ошибка", message: "Попробуйте снова")
                        return
                    }
                    
                    self.statusLabel.text = "Your Biometric Status: \n" + "Logged In"
                    self.statusLabel.textColor = .green
                }
            }
        } else {
            if let error = error {
                showAlert(title: "Нет доступа", message: "\(error.localizedDescription)")
            }
        }
    }
    
}

extension ViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
}

