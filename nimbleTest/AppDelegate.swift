//
//  AppDelegate.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 13/2/2564 BE.
//

import UIKit
import KeychainAccess

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if LoginSession.share.credential != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let surveyContainerViewController = storyboard.instantiateViewController(withIdentifier: "SurveyContainerViewController") as? SurveyContainerViewController else {
                assertionFailure("No view controler ID DetailsViewController")
                
                return true
            }
            
            let navigationController = UINavigationController(rootViewController: surveyContainerViewController)
            window?.rootViewController = navigationController
        }
        
        return true
    }
}

