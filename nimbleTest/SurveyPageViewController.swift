//
//  SurveyPageViewController.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import UIKit

class SurveyPageViewController: UIPageViewController {
    var surveyList: [Survey]?
    weak var surveyPageDelegate: SurveyPageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
    }
    
    func updatePageViewWith(_ surveyList: [Survey]) {
        self.surveyList = surveyList
        
        if let firstViewController = viewControllerAtIndex(index: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if index < 0 || index > surveyList!.count - 1 {
          return nil
        }
        
        if let survey = surveyList?[index],
           let viewController = storyboard?.instantiateViewController(withIdentifier: "SurveyViewController") as? SurveyViewController {
            viewController.survey = survey
            viewController.view.tag = index
            return viewController
        }
        
        return nil
    }
}

extension SurveyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? SurveyViewController,
           let currentSurvey = currentViewController.survey,
           let currentIndex = surveyList?.firstIndex(where: { $0.title == currentSurvey.title }) {
            return viewControllerAtIndex(index: currentIndex - 1)
        }

        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? SurveyViewController,
           let currentSurvey = currentViewController.survey,
           let currentIndex = surveyList?.firstIndex(where: { $0.title == currentSurvey.title }) {
            return viewControllerAtIndex(index: currentIndex + 1)
        }

        return nil
    }
    
    
}

extension SurveyPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentPageIndex = viewControllers?.first?.view.tag {
            surveyPageDelegate?.surveyPageViewController(surveyPageViewController: self, didUpdatePageIndex: currentPageIndex)
        }
    }
}


protocol SurveyPageViewControllerDelegate: class {
    func surveyPageViewController(surveyPageViewController: SurveyPageViewController,
            didUpdatePageIndex index: Int)
}
