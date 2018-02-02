//
//  ViewController.swift
//  birthday
//
//  Created by Maria Teresa Rojo on 1/31/18.
//  Copyright © 2018 Maria Rojo. All rights reserved.
//

import UIKit

enum MyTheme{
    case light
    case dark
}

class CalendarViewController: UIViewController {

    var theme = MyTheme.light

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.bgColor
        
        view.addSubview(calenderView)
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive = true
        
        // Change navigation bar background
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = uicolorFromHex(rgbValue: 0xffffff)
        navigationBarAppearance.barTintColor = uicolorFromHex(rgbValue: 0x393939).withAlphaComponent(1.0)
        
        // Add Shadow to navigation bar
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        // Add shadow to tab bar
        self.tabBarController?.tabBar.layer.masksToBounds = false
        self.tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBarController?.tabBar.layer.shadowOpacity = 1.0
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.tabBarController?.tabBar.layer.shadowRadius = 4
        
        //        let rightBarBtn = UIBarButtonItem(title: "Light", Style: .plain, target: self, action: #selector(rightBarBtnAction))
        //        self.navigationController.rightBarButtonItem = rightBarBtn
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func rightBarBtnAction(sender: UIBarButtonItem){
        if theme == .dark{
            sender.title = "Dark"
            theme = .light
            Style.themeLight()
        } else {
            sender.title = "Light"
            theme = .dark
            Style.themeDark()
        }
        self.view.backgroundColor = Style.bgColor
        calenderView.changeTheme()
    }
    
    let calenderView: CalendarView = {
        let v = CalendarView(theme: MyTheme.dark)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

}

