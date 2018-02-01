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
        self.title = "My Calender"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.bgColor
        
        view.addSubview(calenderView)
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive = true
        
        //        let rightBarBtn = UIBarButtonItem(title: "Light", Style: .plain, target: self, action: #selector(rightBarBtnAction))
        //        self.navigationController.rightBarButtonItem = rightBarBtn
        // Do any additional setup after loading the view, typically from a nib.
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
        }else{
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

