//
//  IntroVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/21/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import UIKit
import Firebase

class IntroVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            if error != nil{
                return
            }
            if let user = user{
                let isAnonymous = user.anonymous  // true
                print("this is a isAnonymous \(isAnonymous)")
                let uid = user.uid
                print(uid)
//                self.nextViewController()
            }
        }
        
        //1
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        //2
        self.startButton.layer.cornerRadius = 4.0
        //3
        let imgOne = UIImageView(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
        imgOne.image = UIImage(named: "intro page")
//        let imgTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
//        imgTwo.image = UIImage(named: "Slide 2")
//        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
//        imgThree.image = UIImage(named: "Slide 3")
//        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
//        imgFour.image = UIImage(named: "Slide 4")
        
        self.scrollView.addSubview(imgOne)
//        self.scrollView.addSubview(imgTwo)
//        self.scrollView.addSubview(imgThree)
//        self.scrollView.addSubview(imgFour)
        //4
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 1, self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        //this sets a time to call scroll
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(IntroVC.moveToNextPage), userInfo: nil, repeats: true)
    }
    func moveToNextPage (){
        
        // Move to next page
        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        let maxWidth:CGFloat = pageWidth * 1
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
            // Each time you move back to the first slide, you may want to hide the button, uncomment the animation below to do so
            //            UIView.animateWithDuration(0.5, animations: { () -> Void in
            //                self.startButton.alpha = 0.0
            //            })
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
    }
    
    //automatic scroll
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        setupScrollForPage()
    }
    //manual scroll
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        setupScrollForPage()
    }
    
    func setupScrollForPage(){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.startButton.alpha = 1.0
            })
        }
//        else if Int(currentPage) == 1{
//        }else if Int(currentPage) == 2{
//        }else{
//            // Show the "Let's Start" button in the last slide (with a fade in animation)
//            UIView.animateWithDuration(1.0, animations: { () -> Void in
//                self.startButton.alpha = 1.0
//            })
//        }
    }
    
    func nextViewController(){
        let controller = storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        presentViewController(controller, animated: true, completion: nil)
    }
}
