//
//  Constant.swift
//  package
//
//  Created by Admin on 2019/2/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

public class PHConstant: NSObject {

    
}
/// 尺寸的适配
///
/// - Parameter size: 适配前的尺寸
/// - Returns: 适配后的尺寸
public func SCALE( size:CGFloat) -> CGFloat{
    //    return size * ((UIScreen.main.bounds.height > 568) ? UIScreen.main.bounds.height/568.00 : 1)
    //    return size * (UIScreen.main.bounds.height/568.00)
    return size
}
public func isIPhoneXType() -> Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets.bottom == 34
}
public func Status_Height() -> CGFloat{//
    return isIPhoneXType() ? 44 : 20
}
public func Bottom_Tool_Height() -> CGFloat{//
    return isIPhoneXType() ? 34 : 0
}

// MARK: - 颜色
public extension UIColor{
    
    
    class var phBgContent: UIColor { get{ return UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)} } //  背景颜色
    
//    字体颜色
    
    /// 红色
    class var phRed: UIColor { get{ return UIColor.init(red: 231/255.0, green: 41/255.0, blue: 47/255.0, alpha: 1)} } //
    ///  黑色字体
    class var phBlackText: UIColor { get{ return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)} } //
    ///  浅灰色字体
    class var phLightGrayText: UIColor { get{ return UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.8)} } //
    
    
    ///  导航颜色
    private static var _phNaviBg : UIColor = UIColor.white
    static var phNaviBg: UIColor {get{return _phNaviBg}set{_phNaviBg = newValue}}
    ///  导航字体
    private static var _phNaviTitle : UIColor = UIColor.phBlackText
    static var phNaviTitle: UIColor { get { return _phNaviTitle}set{_phNaviTitle=newValue}}
    
    //返回随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

// MARK: - 字体大小
public extension UIFont{
    class var phBig: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 18))} }   //  大号字体
    class var phMiddle: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 16))} }   //  中号号字体
    class var phSmall: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 14))} } //小号字体
}




public extension PHConstant{
    static var isLogin : Bool{
        get{
            return UserDefaults.standard.bool(forKey: "isLogin")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isLogin")
        }
    }
    static func getRandomNumber(min:Int,max:Int) -> Int {
        let randomNumber:Int = Int(arc4random_uniform(UInt32(max - min))) + min
        return randomNumber
    }
}
