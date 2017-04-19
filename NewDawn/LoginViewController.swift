//
//  ViewController.swift
//  NewDawn
//
//  Created by modelf on 4/19/17.
//  Copyright © 2017 ChristopherMoore. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var gidButton: GIDSignInButton!
	
	@IBAction func buttonSignIn (_ sender: GIDSignInButton) {
		activityIndicator.isHidden = false
		activityIndicator.startAnimating()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		activityIndicator.isHidden = true
		GIDSignIn.sharedInstance().uiDelegate = self
		if GIDSignIn.sharedInstance().hasAuthInKeychain() {
			activityIndicator.isHidden = false
			activityIndicator.startAnimating()
			GIDSignIn.sharedInstance().signInSilently()
		}
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		activityIndicator.isHidden = true
		activityIndicator.stopAnimating()
	}

}

