//
//  NGAccordionBarView.swift
//  Playground
//
//  Created by Nick Gorman on 2014-06-09.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

import Foundation
import UIKit

class NGAccordionBarView: UIView {
    
    // objects
    var btn:UIButton;
    var arrow:UIImageView;
    var container:UIView;
    
    // container params
    var fullHeight:Int = 0;
    var minHeight:Int = 0;
    
    // if this option is open
    var isOpen:Bool = false;
    
    
    override init(frame: CGRect) {
        
        // initialize our objects
        btn = UIButton();
        arrow = UIImageView();
        container = UIView();
        
        super.init(frame: frame);
        setup();
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
        // Initialization code
        self.clipsToBounds = true;
        self.addSubview(btn);
        
        btn.layer.borderWidth = 1;
        btn.layer.masksToBounds = true;
        
        minHeight = Int(self.frame.size.height);
        
        container.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 322);
        container.clipsToBounds = true;
        self.addSubview(container);
        
        // create the arrow here!
    }
    
    func spinArrow(num:Int){
        // do spin animation here
    }
    
    func setTitle(titleStr:NSString){
        
        // add the button
        btn.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height);
        btn.setTitle(titleStr, forState: UIControlState.Normal);
        
        // btn.titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 26);
        //btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        
        self.clipsToBounds = true;
        fullHeight = Int(container.frame.origin.y) + Int(container.frame.size.height);
    }
    
    func setColor(str:NSString){
        btn.backgroundColor = colorWithHexString(str);
    }
    
    func setContent(obj: AnyObject){
        var vw:UIView = obj as UIView;
        self.container.addSubview(vw);
        fullHeight = Int(vw.frame.size.height) + Int(container.frame.origin.y);
    }
    
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        if (countElements(cString) != 6) {
            return UIColor.grayColor()
        }
        
        var rString = cString.substringFromIndex(advance(cString.startIndex, 0)).substringToIndex(advance(cString.startIndex, 2))
        var gString = cString.substringFromIndex(advance(cString.startIndex, 2)).substringToIndex(advance(cString.startIndex, 4))
        var bString = cString.substringFromIndex(advance(cString.startIndex, 4)).substringToIndex(advance(cString.startIndex, 6))
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner.scannerWithString(rString).scanHexInt(&r)
        NSScanner.scannerWithString(gString).scanHexInt(&g)
        NSScanner.scannerWithString(bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}