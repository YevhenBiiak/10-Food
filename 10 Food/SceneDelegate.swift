//
//  SceneDelegate.swift
//  10 Food
//
//  Created by Yevhen Biiak on 16.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var ordersRepository: OrdersRepository!
    var favoritesRepository: FavoritesRepository!
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        ordersRepository = OrdersRepository()
        favoritesRepository = FavoritesRepository()
        
        ordersRepository.fetch()
        favoritesRepository.fetch()
        
        let navigationController = window?.rootViewController as? UINavigationController
        let splashViewController = navigationController?.viewControllers.first as? SplashViewController
        
        let credentialStorage = KeychainCredentialStorage()
        let notificationService = AlertNotificationService()
        let authService = AuthServiceImpl(credentialStorage: credentialStorage,
                                          notificationService: notificationService)
        
        splashViewController?.authService = authService
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        ordersRepository.save()
        favoritesRepository.save()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
