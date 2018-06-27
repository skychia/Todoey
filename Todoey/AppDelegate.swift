//
//  AppDelegate.swift
//  Todoey
//
//  Created by Chia Khai Fong on 30/5/18.
//  Copyright © 2018 Chia Khai Fong. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
       
        do {
            _ = try Realm()
            
        } catch {
            print("Error initiallzing new Realm, \(error)")
        }
        
        return true
    }


}

