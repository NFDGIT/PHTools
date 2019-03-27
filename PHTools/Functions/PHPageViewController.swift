//
//  PHPageViewController.swift
//  package
//
//  Created by Admin on 2019/3/8.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
//import MJRefresh

//enum PHPageViewControllerTransitionStyle : Int {
//    case scroll
//    case pageCurl
//}
//enum PHPageViewControllerNavigationOrientation : Int {
//    case horizontal
//    case vertical
//}


public class PHPageViewController:BaseViewController ,UIPageViewControllerDelegate,UIPageViewControllerDataSource{


    public var finishTransitionCallBack:((Int)->())?
    
    
    public var currentPage : Int = 0
    public var numberOfViewController:(()->(Int))?
    public var viewControllerForPage:((Int)->(UIViewController))?
    
    public var transitionStyle : UIPageViewControllerTransitionStyle = .scroll
    public var navigationOrientation : UIPageViewControllerNavigationOrientation = .horizontal
    
    public var pageVC : UIPageViewController?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
    }
    override public func initNavi() {
        super.initNavi()
    }
    override public func initUI() {
        super.initUI()
        
        pageVC = UIPageViewController.init(transitionStyle: self.transitionStyle, navigationOrientation: self.navigationOrientation, options: nil)

        self.addChildViewController(pageVC!)
        self.view.addSubview(pageVC!.view)
        pageVC!.delegate = self
        pageVC!.dataSource = self
        
        pageVC!.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.setPage(page: 0)
        
//        self.scrollView()
        
    }
    public  func setPage(page:Int)  {
        pageVC!.setViewControllers([getVC(page: page)!], direction: .forward, animated: false) { (completed) in
        }
    }
    
    public func getVC(page:Int) -> UIViewController? {
        if self.viewControllerForPage == nil || self.numberOfViewController == nil || self.numberOfViewController!() == 0 {
            return nil
        }
        if page < 0 {
            return nil
        }
        if page >= self.numberOfViewController!()
        {
           return nil
        }
        
        let vc = self.viewControllerForPage!(page)
        vc.phPageNum = page
        
        return vc
    }
    
    func scrollView()  {
        
   
        for  subView in  (self.pageVC?.view.subviews)!{
            if subView.isKind(of: UIScrollView.classForCoder())
            {
                
//                let view :UIView = UIView.init()
//                view.backgroundColor = UIColor.appTheme
//                subView.addSubview(view)
//                view.snp.makeConstraints { (make) in
//                    make.left.equalToSuperview().offset(40)
//                    make.right.equalToSuperview().offset(-40)
//                    make.top.equalTo(subView.snp.top)
//                    make.height.equalTo(30)
//                }
//
//
                
                
//                (subView as! UIScrollView).mj_header = MJRefreshStateHeader.init(refreshingBlock: {
//                    
//                })
                
            }
            
            
        }
        
        
    }


}
extension PHPageViewController{
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return getVC(page: (pageViewController.viewControllers?.first?.phPageNum)! - 1)

    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getVC(page: (pageViewController.viewControllers?.first?.phPageNum)! + 1)

    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (finishTransitionCallBack != nil)
        {
            finishTransitionCallBack!((pageViewController.viewControllers?.first?.phPageNum)!)
        }
    }
    
}

struct UIViewControllerAssociatedKeys {
    static var phPageNum: String = "phPageNum"
    static var phPageViewController: String = "phPageViewController"
}

extension UIViewController{
    public var phPageNum: Int? {
        get {
            return (objc_getAssociatedObject(self, &UIViewControllerAssociatedKeys.phPageNum) as! Int)
        }
        set {
            objc_setAssociatedObject(self, &UIViewControllerAssociatedKeys.phPageNum, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public var phPageViewController: UIPageViewController? {
        get {
            return (objc_getAssociatedObject(self, &UIViewControllerAssociatedKeys.phPageViewController) as! UIPageViewController)
        }
        set {
            objc_setAssociatedObject(self, &UIViewControllerAssociatedKeys.phPageViewController, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
//    open var ti : String!
    
}
