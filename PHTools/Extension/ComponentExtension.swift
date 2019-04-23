//
//  ComponentExtent.swift
//  package
//
//  Created by Admin on 2019/2/13.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import WebKit

class ComponentExtension: NSObject {

}


struct UIButtonAssociatedKeys {
    static var eventCallBack: String = "eventCallBack"
}
public extension UIButton{
    // MARK: UIButton的初始化方法
    convenience  init(normalTitle:String?=nil,selectedTitle:String? = nil,normalImg:UIImage? = nil,selectedImg:UIImage? = nil,normalTextColor:UIColor?=nil,selectedTextColor:UIColor? = nil,normalBgImg:UIImage? = nil,selectedBgImg:UIImage? = nil,font:UIFont?=nil)  {
        self.init()
        
        self.phInitialize(normalTitle: normalTitle, selectedTitle: selectedTitle, normalImg: normalImg, selectedImg: selectedImg, normalTextColor: normalTextColor, selectedTextColor: selectedTextColor,normalBgImg: normalBgImg,selectedBgImg: selectedBgImg, font: font)
    }
    // MARK: UIButton的一些常用参数的初始化
    func  phInitialize(normalTitle:String? = nil,selectedTitle:String? = nil,normalImg:UIImage? = nil,selectedImg:UIImage? = nil,normalTextColor:UIColor?=nil,selectedTextColor:UIColor? = nil,normalBgImg:UIImage? = nil,selectedBgImg:UIImage? = nil,font:UIFont?=nil) {

        self.setTitle(normalTitle, for: .normal)
        self.setImage(normalImg, for: .normal)
        self.setTitleColor(normalTextColor, for: .normal)
        self.setBackgroundImage(normalBgImg, for: .normal)
        
        self.setTitle(selectedTitle, for: .selected)
        self.setImage(selectedImg, for: .selected)
        self.setTitleColor(selectedTextColor, for: .selected)
        self.setBackgroundImage(selectedBgImg, for: .selected)
        
        self.titleLabel?.font = font
        
        self.imageView?.contentMode = UIView.ContentMode.center
        
    }
    

    
    // MARK: UIButton图像文字同时存在时---图像相对于文字的位置
    /**
     UIButton图像文字同时存在时---图像相对于文字的位置

     - top:    图像在上
     - left:   图像在左
     - right:  图像在右
     - bottom: 图像在下
     */
    enum PHButtonImageEdgeInsetsStyle {
        case top, left, right, bottom
    }
    /// 文字图片互换位置
    ///
    /// - Parameters:
    ///   - style: 样式
    ///   - space: 间距
    func phImagePosition(at style: PHButtonImageEdgeInsetsStyle, space: CGFloat) {
        guard let imageV = imageView else { return }
        guard let titleL = titleLabel else { return }
        //获取图像的宽和高
        let imageWidth = imageV.frame.size.width
        let imageHeight = imageV.frame.size.height
    
        //获取文字的宽和高
        let labelWidth  = titleL.intrinsicContentSize.width
        let labelHeight = titleL.intrinsicContentSize.height

        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //UIButton同时有图像和文字的正常状态---左图像右文字，间距为0
        switch style {
        case .left:
            //正常状态--只不过加了个间距
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
        case .right:
            //切换位置--左文字右图像
            //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
        case .top:
            //切换位置--上图像下文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: labelWidth * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
        case .bottom:
            //切换位置--下图像上文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }

    
    // MARK: --  添加点击事件
    var eventCallBack: ((UIButton)->())? {
        get {
            return objc_getAssociatedObject(self, &UIButtonAssociatedKeys.eventCallBack) as? ((UIButton) -> ())
        }
        set {
            objc_setAssociatedObject(self, &UIButtonAssociatedKeys.eventCallBack, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func phAddTarget(events:UIControl.Event, callBack:@escaping ((UIButton)->()))  {
        self.addTarget(self, action: #selector(method(sender:)), for: events)
        self.eventCallBack = { sender in
            callBack(sender)
        }
    }
    @objc private func method(sender:UIButton)  {
        self.eventCallBack!(sender)
    }
}
public extension UIScrollView{
    func addEmptyView(emptyView:UIView)  {
        emptyView.tag = 100001
        emptyView.isHidden = true
        self.addSubview(emptyView)
        self.bringSubviewToFront(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    func setIsEmpty(isEmpty:Bool) {
        let emptyView = self.viewWithTag(100001)
        if  emptyView != nil {
            emptyView?.isHidden = !isEmpty
        }
        

    }

    
}
public extension UIView{

    func phLayer(cornerRadius:CGFloat,borderWidth:CGFloat,borderColor:UIColor? = nil) {
        if  cornerRadius  != 0{
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
        if  borderColor != nil {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor!.cgColor
        }
    }
    func phView( backGroundColor:UIColor?) {
        self.backgroundColor = backGroundColor
    }
    
    /**
     Get the view's screen shot, this function may be called from any thread of your app.
     
     - returns: The screen shot's image.
     */
    func screenShot() -> UIImage? {
        
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
struct UITableViewAssociatedKeys {
    static var datas: String = "datas"
}
public extension UITableView {
    var datas: Array<Any>{
        get{
            let value = objc_getAssociatedObject(self, &UITableViewAssociatedKeys.datas)
            if  (value != nil) {
                return value as! Array<Any>
            }
            return  Array.init()
        }
        set{
            objc_setAssociatedObject(self, &UITableViewAssociatedKeys.datas, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
struct UITableViewCellAssociatedKeys  {
    static var indexPath: String = "indexPath"
}
public extension UITableViewCell{
    var indexPath: IndexPath? {
        get {
            return (objc_getAssociatedObject(self, &UITableViewCellAssociatedKeys.indexPath) as! IndexPath)
        }
        set {
            objc_setAssociatedObject(self, &UITableViewCellAssociatedKeys.indexPath, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

struct UICollectionViewCellAssociatedKeys {
    static var indexPath: String = "indexPath"
}
public extension UICollectionViewCell{
    var indexPath: IndexPath? {
        get {
            return (objc_getAssociatedObject(self, &UICollectionViewCellAssociatedKeys.indexPath) as! IndexPath)
        }
        set {
            objc_setAssociatedObject(self, &UICollectionViewCellAssociatedKeys.indexPath, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}



public extension UIImage{
    
    static func phInit(color:UIColor) -> UIImage {
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsGetCurrentContext()
        
        return image!
    }
    
}

public extension WKWebView{
    static func phInit()  -> WKWebView{
    
        let config : WKWebViewConfiguration = WKWebViewConfiguration()
        config.userContentController = WKUserContentController.init()
        
        let preferences : WKPreferences = WKPreferences.init()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        //        preferences.minimumFontSize = 30
        config.preferences = preferences
    

        return WKWebView.init(frame: CGRect.zero, configuration: config)
    }
}
public class PHTool: NSObject {
    public static func getCacheSize() ->Double{
        
        // 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            let path = cachePath! + ("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (key, fileSize) in floder {
                // 累加文件大小
                if key == FileAttributeKey.size {
                    size += (fileSize as AnyObject).integerValue
                }
            }
        }
        
        let totalCache = Double(size) / 1024.00 / 1024.00
        return totalCache
    }
    public static func removeCache(callBack:((_ success:Bool)->())){
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        
        for file in fileArr! {
            
            let path = (cachePath! as NSString).appending("/\(file)")
            
            if FileManager.default.fileExists(atPath: path) {
                
                do {
                    
                    try FileManager.default.removeItem(atPath: path)
                    
                } catch {
                    
                    
                    
                }
                
            }
            
        }
        callBack(true)
        
    }
}
