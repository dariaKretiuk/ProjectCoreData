//
//  AppDelegate.swift
//  ProjectCoreData
//
//  Created by Дарья Кретюк on 13.06.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: - Elements
    
    private let appearance: UINavigationBarAppearance =  {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .f5cac5
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        return appearance
    }()
    
    private let appearanceTabBar: UITabBarAppearance =  {
        let appearanceTabBar = UITabBarAppearance()
        appearanceTabBar.configureWithOpaqueBackground()
        appearanceTabBar.backgroundColor = .f5cac5
        return appearanceTabBar
    }()
    
    // MARK: - Private func
    
    private func settingsBar() {
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UITabBar.appearance().standardAppearance = appearanceTabBar
        UITabBar.appearance().scrollEdgeAppearance = appearanceTabBar
        UITabBar.appearance().tintColor = .ff585b
    }
    
    // MARK: - Main func

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        settingsBar()
        
        let tabBarController = UITabBarController()
        
        let firstWindowController = FirstWindowController()
        let firstWindowNavigationController = UINavigationController(rootViewController: firstWindowController)
        firstWindowController.tabBarItem = UITabBarItem(title: "Первый экран", image: UIImage(systemName: "1.circle"), tag: 0)
        
        let secondWindowController = SecondWindowController()
        let secondWindowNavigationController = UINavigationController(rootViewController: secondWindowController)
        secondWindowController.tabBarItem = UITabBarItem(title: "Второй экран", image: UIImage(systemName: "2.circle"), tag: 1)
        
        tabBarController.setViewControllers([
            firstWindowNavigationController,
            secondWindowNavigationController
        ], animated: true)
        tabBarController.selectedIndex = 1
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ProjectCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

