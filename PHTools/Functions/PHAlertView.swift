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
