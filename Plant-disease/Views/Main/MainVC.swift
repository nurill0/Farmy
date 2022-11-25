//
//  VC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 27/10/22.
//

import UIKit
import BubbleTabBar

class MainVC: BaseVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseContainerV.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground

        let shopVC = ShopVC()
        shopVC.tabBarItem = UITabBarItem(title: "Do'kon", image: UIImage(named: "shop")?.withTintColor(UIColor.titleColors(), renderingMode: .alwaysOriginal), tag: 0)
        shopVC.tabBarItem.selectedImage = UIImage(named: "shop")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let gardenVC = GardenVC()
        gardenVC.tabBarItem = UITabBarItem(title: "Bog'", image: UIImage(named: "garden")?.withTintColor(UIColor.titleColors(), renderingMode: .alwaysOriginal), tag: 0)
        gardenVC.tabBarItem.selectedImage = UIImage(named: "garden")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let jobVC = JobVC()
        jobVC.tabBarItem = UITabBarItem(title: "Ish o'rinlari", image: UIImage(named: "job")?.withTintColor(UIColor.titleColors(), renderingMode: .alwaysOriginal), tag: 0)
        jobVC.tabBarItem.selectedImage = UIImage(named: "job")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        jobVC.tabBarController?.tabBar.barTintColor = .red
        
        let tabBarController = BubbleTabBarController()
        tabBarController.viewControllers = [shopVC, gardenVC, jobVC]
        tabBarController.tabBar.tintColor = UIColor.baseColor()
        tabBarController.tabBar.barTintColor = .red
        tabBarController.tabBar.backgroundColor = .systemBackground
        self.navigationController?.pushViewController(tabBarController, animated: true)
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
}
