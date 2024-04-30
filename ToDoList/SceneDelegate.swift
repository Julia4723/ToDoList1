//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by user on 30.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene) //инициализируем окно
        window?.makeKeyAndVisible() //Делаем окно видимым и ключевым
        window?.rootViewController = UINavigationController(rootViewController: TaskListViewController()) //Определяем стартовый вью, помещая его в навигейшн
        
    }

    

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

