//
//  AppDelegate.swift
//  Nexus
//
//  Created by Matthew Foote on 1/6/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
   
    
    
    private func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Initialize sign-in
        
        return true
    }

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.black
        FirebaseApp.configure()
        //For google Sign in
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // Override point for customization after application launch.
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.tintColor = UIColor(red: 85/255, green: 204/255, blue: 238/255, alpha: 1.0) /* #55ccee */
        navigationBarAppearance.barTintColor = UIColor(red: 85/255, green: 204/255, blue: 238/255, alpha: 1.0) /* #55ccee */
        
        navigationBarAppearance.barTintColor = UIColor(red: 85/255, green: 204/255, blue: 238/255, alpha: 1.0) /* #55ccee */
        navigationBarAppearance.isTranslucent = true
        navigationBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.tintColor = UIColor.black;
        return true
    }
    //Google signin
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    //Google signin
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let err = error {
            print("Failed to login:", err)
            return
        }
        print("Login successfull", user)
        guard let idToken = user.authentication.idToken else {return}
        guard let accessToken = user.authentication.accessToken else {return}
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let err = error {
                print("Failed to create Firebase user with Google account", err)
                return
            }
            // User is signed in
            guard let uid = user?.uid else {return}
            var phone = " "
            let email = user?.email
            if user?.phoneNumber != nil {
                phone = (user?.phoneNumber)!
            }
            let name = user?.displayName
            let ref = Database.database().reference()
            let usersReference = ref.child("GoogleUsers")
            let newUsersReference = usersReference.child(uid)
            newUsersReference.setValue(["email": email!, "phone": phone, "Name": name!])
            print("Successfuly in firebase auth and database", uid)
            print("before segue")
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let viewController: SignUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            let rootViewController = self.window!.rootViewController as! UINavigationController
            rootViewController.pushViewController(viewController, animated: true)
           // self.window?.rootViewController?.performSegue(withIdentifier: "signUpSegue", sender: nil)
            //SignUpViewController.SignUpBtn_TouchUpInside()
            
        }
    }
    //Google signin
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

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


}

