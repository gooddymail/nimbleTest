//
//  SurveyContainerViewController.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import UIKit
import SkeletonView

class SurveyContainerViewController: UIViewController {
    
    @IBOutlet weak var loadingAnimationView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var surveyPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = SkeletonGradient(baseColor: UIColor.darkGray, secondaryColor: UIColor.gray)
        view.showAnimatedGradientSkeleton(usingGradient: gradient)
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
