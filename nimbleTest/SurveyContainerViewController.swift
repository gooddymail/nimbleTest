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
    
    weak var surveyPageViewController: SurveyPageViewController!
    
    var userProfile: UserProfile!
    var surveyList: [Survey]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = SkeletonGradient(baseColor: UIColor.darkGray, secondaryColor: UIColor.gray)
        view.showAnimatedGradientSkeleton(usingGradient: gradient)
        profileImageView.layer.cornerRadius = 18
        
        loadProfileAndSurveyList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
                .responseDecodable(of: ResponseData<UserProfile>.self) { (response) in
                    switch response.result {
                    case .success(let responseData):
                        self.userProfile = responseData.data
                        
                    case .failure(let error):
                        print(error)
                    }
                    
                    group.leave()
                }
            
            group.enter()
            let surveyListURLRequest = URLRequest(url: URL(string: "https://survey-api.nimblehq.co/api/v1/surveys?page[number]=1&page[size]=2")!)
            session.request(surveyListURLRequest, interceptor: interceptor)
                .validate()
                .responseDecodable(of: ResponseData<[Survey]>.self) { (response) in
                    switch response.result {
                    case .success(let responseData):
                        self.surveyList = responseData.data
                        
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
                    self.setupSurvey()
                }
            }
        }
    }
    
    func setupProfile() {
        profileImageView.af.setImage(withURL: URL(string: userProfile.avatarURL)!, placeholderImage: UIImage(named: "ProfilePlaceholder"))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        
        dateLabel.text = dateFormatter.string(from: Date())
    }
    
    func setupSurvey() {
        surveyPageControl.numberOfPages = surveyList.count
        surveyPageViewController.updatePageViewWith(surveyList)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SurveyPageViewController {
            surveyPageViewController = controller
            surveyPageViewController.surveyPageDelegate = self
        }
    }
}

extension SurveyContainerViewController: SurveyPageViewControllerDelegate {
    func surveyPageViewController(surveyPageViewController: SurveyPageViewController, didUpdatePageIndex index: Int) {
        surveyPageControl.currentPage = index
    }
}
