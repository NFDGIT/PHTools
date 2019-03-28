//
//  PHAlertView.swift
//  ziyanzhi
//
//  Created by Admin on 2019/3/27.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

open class PHAlertView: UIView {
    public let backView : UIButton = UIButton.init()
    
    public init() {
        super.init(frame: CGRect.zero)
        self.initUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func initUI() {
        self.backView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        
        
        self.backView.addSubview(self)
        self.backgroundColor = UIColor.white
        self.backView.addTarget(self, action: #selector(disAppear), for: .touchUpInside)
    }
    
    open func appear(view:UIView) {
        view.addSubview(self.backView)
        self.backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        

//        self.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(0.7)
//            make.height.equalTo(self.snp.width)
//        }
        
    }
    @objc open func disAppear(){
        self.backView.removeFromSuperview()
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension UIColor{
    //返回随机颜色
    public class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
extension UIView{
    /**
     Get the view's screen shot, this function may be called from any thread of your app.
     
     - returns: The screen shot's image.
     */
    public func screenShot() -> UIImage? {
        
        guard frame.size.height > 0 && frame.size.width > 0 else {
            
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
