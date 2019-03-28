//
//  BaseViewController.swift
//  package
//
//  Created by Admin on 2019/2/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

open class PHBaseViewController: UIViewController,UINavigationControllerDelegate  {
    open var showNavi : Bool = true
    override open func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.phNaviTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.phNaviBg
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.phNaviTitle]
        
        
        
        self.view.backgroundColor = UIColor.phBgContent
        self.setNeedsStatusBarAppearanceUpdate()

        // Do any additional setup after loading the view.
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
    
    
    
    open func initUI()  {}
    open func initNavi()  {}

    override open var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
}


extension PHBaseViewController{
    // MARK: 导航代理
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setNavigationBarHidden(!(viewController as! PHBaseViewController).showNavi, animated: true)
    }
    public func dial(phone:String) {
        let callWebview =   UIWebView()
        callWebview.loadRequest(NSURLRequest(url: URL(string: "tel:\(phone)")!) as URLRequest)
        self.view.addSubview(callWebview)
    }

}
