//
//  ViewController.swift
//  werureo-showcase
//
//  Created by Keli'i Martin on 3/13/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController
{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    ////////////////////////////////////////////////////////////

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil
        {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }

    ////////////////////////////////////////////////////////////

    @IBAction func fbBtnPressed(sender: UIButton!)
    {
        let facebookLogin = FBSDKLoginManager()

        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self)
        { facebookResult, facebookError in
            if facebookError != nil
            {
                print("Facebook login failed.  Error \(facebookError)")
            }
            else
            {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(accessToken)

                FIRAuth.auth()?.signInWithCredential(credential)
                { (user, error) in
                    if error != nil
                    {
                        print("Login failed. \(error)")
                    }
                    else
                    {
                        let userData = ["provider": credential.provider]
                        DataService.ds.createFirebaseUser(user!.uid, user: userData)

                        NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////

    @IBAction func attemptLogin(sender: UIButton!)
    {
        if let email = emailField.text where email != "",
            let pwd = passwordField.text where pwd != ""
        {
            FIRAuth.auth()?.signInWithEmail(email, password: pwd)
            { (user, error) in
                if error != nil
                {
                    if error!.code == STATUS_ACCOUNT_NONEXIST
                    {
                        FIRAuth.auth()?.createUserWithEmail(email, password: pwd)
                        { (user, error) in
                            if error != nil
                            {
                                self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else")
                            }
                            else
                            {
                                NSUserDefaults.standardUserDefaults().setValue(user?.uid, forKey: KEY_UID)
                                FIRAuth.auth()?.signInWithEmail(email, password: pwd)
                                { (user, error) in
                                    let userData = ["provider": email, "blah":"emailtest"]
                                    DataService.ds.createFirebaseUser(user!.uid, user: userData)
                                }
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                        }
                    }
                    else
                    {
                        self.showErrorAlert("Could not login", msg: "Please check your username or password")
                    }
                }
                else
                {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            }
        }
        else
        {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
        }
    }

    ////////////////////////////////////////////////////////////

    func showErrorAlert(title: String, msg: String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}

