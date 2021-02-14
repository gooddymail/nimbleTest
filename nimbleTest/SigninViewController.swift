//
//  SigninViewController.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import UIKit

class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            let clearPlaceHolderText = NSAttributedString(string: "Email",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.3)])
            
            emailTextField.attributedPlaceholder = clearPlaceHolderText
        }
    }
    
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            let clearPlaceHolderText = NSAttributedString(string: "Password",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.3)])
            
            passwordTextField.attributedPlaceholder = clearPlaceHolderText
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewComponent()
    }
    
    func setupViewComponent() {
        emailContainerView.layer.cornerRadius = 10
        passwordContainerView.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
    }
    
    @IBAction func emailTextDidChanged(_ sender: UITextField) {
        enableLoginButton()
    }
    
    @IBAction func passwordTextDidChanged(_ sender: UITextField) {
        enableLoginButton()
    }
    
    func enableLoginButton() {
        loginButton.isEnabled = !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
    }
    
    @IBAction func loginDidTapped(_ sender: UIButton) {
    }
}