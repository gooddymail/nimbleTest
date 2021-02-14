//
//  SurveyViewController.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import UIKit
import AlamofireImage

class SurveyViewController: UIViewController {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var survey: Survey?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let survey = survey else { return }
        
        coverImageView.af.setImage(withURL: URL(string: survey.coverImageURL)!)
        titleLabel.text = survey.title
        descriptionLabel.text = survey.description
    }
    
    @IBAction func actionDidTapped(_ sender: UIButton) {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
