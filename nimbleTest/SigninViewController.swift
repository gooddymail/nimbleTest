//
//  SigninViewController.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import UIKit
import Alamofire
import KeychainAccess

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
        let parameters: [String: String] = ["grant_type": "password",
                                            "email": emailTextField.text!,
                                            "password": passwordTextField.text!,
                                            "client_id": "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE",
                                            "client_secret": "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"]
        
        AF.request("https://survey-api.nimblehq.co/api/v1/oauth/token", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: ResponseData<LoginCredential>.self) { (response) in
                switch response.result {
                case .success(let responseData):
                    LoginSession.share.credential = responseData.data
                    
                    DispatchQueue.main.async {
                        self.showSurveyList()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func showSurveyList() {
        guard let surveyContainerViewController = storyboard?.instantiateViewController(withIdentifier: "SurveyContainerViewController") as? SurveyContainerViewController else {
            assertionFailure("No view controler ID DetailsViewController")
            
            return
        }
        
        UIApplication.shared.delegate?.window??.rootViewController = surveyContainerViewController
    }
}
