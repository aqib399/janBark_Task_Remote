//
//  BaseViewController.swift
//  janBark Task
//
//  Created by Aqib Zareen on 21/01/2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func settingNavigationBar(title: String)  {
        self.title = title
        let navigationBar = navigationController?.navigationBar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.init(red: 12/250, green: 175/250, blue: 255/250, alpha: 1)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar?.standardAppearance = navBarAppearance
        navigationBar?.scrollEdgeAppearance = navBarAppearance
    }
    
    func leftBarButton()  {
        let leftBtn = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem  = leftBtn
    }
    @objc func goBack(){
        self.navigationController?.popViewController(animated: false)
    }
}
