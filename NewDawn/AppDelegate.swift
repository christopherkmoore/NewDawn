//
//  AppDelegate.swift
//  NewDawn
//
//  Created by modelf on 4/19/17.
//  Copyright © 2017 ChristopherMoore. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		FIRApp.configure()
		
		GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
		GIDSignIn.sharedInstance().delegate = self
		return true	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	@available(iOS 9.0, *)
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
	}
	func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		return GIDSignIn.sharedInstance().handle(url,
		                                         sourceApplication: sourceApplication,
		                                         annotation: annotation)
	}
}

extension AppDelegate {
	
	// protocols and delgates for GIDSignInDelegate
	
//	func checkNeedsIntro() {
//		var count = 0
//		if let currentUser = currentUser, let needsIntro = currentUser.needsIntro {
//			if needsIntro {
//				let controller = UIStoryboard(name: "Main", bundle: nil)
//				let vc = controller.instantiateViewController(withIdentifier:
//					"TutorialViewController")
//				self.window?.rootViewController?.present(vc, animated: true, completion: nil)
//				
//			} else {
//				
//				let controller = UIStoryboard(name: "Main", bundle: nil)
//				let vc = controller.instantiateViewController(withIdentifier:
//					"NavigationController")
//				self.window?.rootViewController?.present(vc, animated: true, completion: nil)
//			}
//		} else {
//			DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//				count += 1
//				//				print(count)
//				self.checkNeedsIntro()
//			})
//			
//		}
//		
//	}
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
		
		// this nesting structure is weird breh (there would be no error to unwrap if authentication is true)
		
		if let authentication = user.authentication  {
			let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
			
			FIRAuth.auth()?.signIn(with: credential) {(user, error) in
				
//				if let newUser = user {
//					currentUser = User(user: newUser)
//				}
				if let error = error {
					print(error.localizedDescription)
					return
				}
				let controller = UIStoryboard(name: "Main", bundle: nil)
				let vc = controller.instantiateViewController(withIdentifier: "TabbedViewController")
				self.window?.rootViewController?.present(vc, animated: true, completion: nil)
			}
		}
//		checkNeedsIntro()
	}
	
	func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
	            withError error: NSError!) {
		
		print("User: \(user.userID)")
		// Perform any operations when the user disconnects from app here.
		// ...
	}
	
}



