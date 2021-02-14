//
//  SurveyContainerViewController.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import UIKit
import SkeletonView
import Alamofire
import AlamofireImage

class SurveyContainerViewController: UIViewController {
    
    @IBOutlet weak var loadingAnimationView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var surveyPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = SkeletonGradient(baseColor: UIColor.darkGray, secondaryColor: UIColor.gray)
        view.showAnimatedGradientSkeleton(usingGradient: gradient)
        profileImageView.layer.cornerRadius = 18
        
        loadProfileAndSurveyList()
    }
    
    func loadProfileAndSurveyList() {
        DispatchQueue.global(qos: .userInitiated).async {
            let credential = LoginSession.share.credential
            let authenticator = OAuthenticator()
            let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
            let session = Session()
            
            let group = DispatchGroup()
            
            group.enter()
            let profileURLRequest = URLRequest(url: URL(string: "https://survey-api.nimblehq.co/api/v1/me")!)
            session.request(profileURLRequest, interceptor: interceptor)
                .validate()
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let json):
                        print(json)
                        
                    case .failure(let error):
                        print(error)
                    }
                    
                    group.leave()
                }
            
            group.enter()
            let surveyListURLRequest = URLRequest(url: URL(string: "https://survey-api.nimblehq.co/api/v1/surveys?page[number]=1&page[size]=2")!)
            session.request(surveyListURLRequest, interceptor: interceptor)
                .validate()
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let json):
                        print(json)
                        
                    case .failure(let error):
                        print(error)
                    }
                    
                    group.leave()
                }
            
            group.wait()
            group.notify(queue: .main) {
                DispatchQueue.main.async {
                    self.view.stopSkeletonAnimation()
                    self.loadingAnimationView.isHidden = true
                    self.setupProfile()
                }
            }
        }
    }
    
    func setupProfile() {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
