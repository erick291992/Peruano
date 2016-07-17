//
//  FeedbackVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/16/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import UIKit

class FeedbackVC: UIViewController {
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var websiteTextField: UITextField!
    
    @IBOutlet weak var sendButton: CustomButton!
    
    var activeField: UITextView?
    var keyboardOnScreen = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self

        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        commentTextView.layer.cornerRadius = 4

        subscribeToNotification(UIKeyboardWillShowNotification, selector: Constants.Selectors.KeyboardWillShow)
        subscribeToNotification(UIKeyboardWillHideNotification, selector: Constants.Selectors.KeyboardWillHide)
        subscribeToNotification(UIKeyboardDidShowNotification, selector: Constants.Selectors.KeyboardDidShow)
        subscribeToNotification(UIKeyboardDidHideNotification, selector: Constants.Selectors.KeyboardDidHide)
    }
    
    @IBAction func sendPressed(sender: AnyObject) {
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

extension FeedbackVC: UITextViewDelegate {
    
    // MARK: UITextViewDelegate
    
    // MARK: Show/Hide Keyboard
    func textViewDidBeginEditing(textView: UITextView) {
        print("begin edit")
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        activeField = nil
    }
//    func keybardShow(){
//        if !keyboardOnScreen {
//            let height = tabBarController?.tabBar.frame.height
//            view.frame.origin.y -= (keyboardHeight(notification) - height!)
//        }
//    }
    
    func keyboardWillShow(notification: NSNotification) {
//        if commentTextView.isFirstResponder(){
//            print("first responder")
//            let height = tabBarController?.tabBar.frame.height
//            if commentTextView.frame.origin.y > view.frame.height - (keyboardHeight(notification) - height!){
//                print("keyshow")
//                if !keyboardOnScreen {
//                    print("key show screen")
//                    view.frame.origin.y -= (keyboardHeight(notification) - height!)
//                }
//                
//            }
//        }
        let height = tabBarController?.tabBar.frame.height
        let firstResponder = getFirstRespondet()
        if firstResponder.frame.origin.y + (firstResponder.frame.height) > view.frame.height - (keyboardHeight(notification) - height!){
            print("keyshow")
            if !keyboardOnScreen {
                let distance = view.frame.height - (sendButton.frame.origin.y)
                view.frame.origin.y -= (keyboardHeight(notification) - height!) - distance
            }
            
        }
//        if commentTextView.isFirstResponder() {
//            print("comment")
//            if !keyboardOnScreen {
//                let height = tabBarController?.tabBar.frame.height
//                view.frame.origin.y -= (keyboardHeight(notification) - height!)
//            }
//        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardOnScreen {
//            let height = tabBarController?.tabBar.frame.height
            view.frame.origin.y = 0.0
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        keyboardOnScreen = true
    }
    
    func keyboardDidHide(notification: NSNotification) {
        keyboardOnScreen = false
    }
    
    private func getFirstRespondet() -> UIView{
        if commentTextView.isFirstResponder(){
            return commentTextView
        }
        else if websiteTextField.isFirstResponder(){
            return websiteTextField
        }
        else{
            return UIView()
        }
    }
    
    private func keyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
}

// MARK: - FeedbackVC (Notifications)

extension FeedbackVC {
    
    private func subscribeToNotification(notification: String, selector: Selector) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    private func unsubscribeFromAllNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
