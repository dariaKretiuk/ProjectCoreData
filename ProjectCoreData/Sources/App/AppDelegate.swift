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
        tabBarController.selectedIndex = 0
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

