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

        subscribeToNotification(UIKeyboardWillShowNotification, selector: #selector(FeedbackVC.keyboardWillShow(_:)))
        subscribeToNotification(UIKeyboardWillHideNotification, selector: #selector(FeedbackVC.keyboardWillHide(_:)))
        subscribeToNotification(UIKeyboardDidShowNotification, selector: #selector(FeedbackVC.keyboardDidShow(_:)))
        subscribeToNotification(UIKeyboardDidHideNotification, selector: #selector(FeedbackVC.keyboardDidHide(_:)))
//        DataService.sharedInstance().postFeedBack("www.google.com", comment: "this is a link")
    }
    
    @IBAction func sendPressed(sender: AnyObject) {
        DataService.sharedInstance().postFeedBack(websiteTextField.text!, comment: commentTextView.text!)
        let alert = basicAlert("Message Sent", message: "Thank You For Your Feedback", action: "OK")
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

extension FeedbackVC: UITextViewDelegate {
    
    // MARK: UITextViewDelegate
    
    // MARK: Show/Hide Keyboard
    
    func textViewDidEndEditing(textView: UITextView) {
        activeField = nil
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let height = tabBarController?.tabBar.frame.height
        let firstResponder = getFirstRespondet()
        if firstResponder.frame.origin.y + (firstResponder.frame.height) > view.frame.height - (keyboardHeight(notification) - height!){
            if !keyboardOnScreen {
                let distance = view.frame.height - (sendButton.frame.origin.y)
                view.frame.origin.y -= (keyboardHeight(notification) - height!) - distance
            }
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardOnScreen {
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
    
    private func basicAlert(tittle:String, message:String, action: String)-> UIAlertController{
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .Alert)
//        let action = UIAlertAction(title: action, style: .Default, handler: nil)
        let action = UIAlertAction(title: action, style: .Default) { (alertAction) in
            print(alertAction)
//            self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.popViewControllerAnimated(true)
        }
        alert.addAction(action)
        return alert
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
