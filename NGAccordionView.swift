//
//  NGAccordionView.swift
//
//  Created by Nick Gorman on 2014-06-09.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

import Foundation
import UIKit

class NGAccordionView: UIScrollView {
    
    var items:NSMutableArray = [];
    var clipHeight:NSNumber = 0;
    var currentlySelectedItem:Int = -1;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addObjectToAccordion(clip: NGAccordionBarView) {
        
        clipHeight = clip.frame.size.height;
        
        var itemPosition:NSNumber = items.count as Int * clipHeight.integerValue;
        var itemWidth:NSNumber = clip.frame.size.width;
        var itemHeight:NSNumber = clip.frame.size.height;
        
        clip.frame = CGRect(x: 0, y: itemPosition.integerValue, width: itemWidth.integerValue, height: itemHeight.integerValue);
        
        self.addSubview(clip);
        items.addObject(clip);
        
        clip.btn.addTarget(self, action: Selector("buttonCallback:"), forControlEvents: UIControlEvents.TouchUpInside);
        clip.btn.tag = items.count-1;
        
        self.contentSize = CGSize(width: itemWidth.integerValue, height: itemPosition.integerValue);
    }
    
    func buttonCallback(obj: UIButton) {
        self.animateOpen(obj.tag);
    }
    
    func animateOpen(num: Int) {
        var bar:NGAccordionBarView = items.objectAtIndex(num) as NGAccordionBarView;
        
        var heightOfOpenBox:Int = bar.fullHeight;
        var totalHeightForContainer:Int = 0;
        var yPosForItem:Int = 0;
        var heightOfSelectedBox:Int = 0;
        
        for ( var i = 0; i < items.count; i++ ){
            if ( i != num ){
                
                var midBar:NGAccordionBarView = items.objectAtIndex(i) as NGAccordionBarView;
                midBar.spinArrow(0);
                
                var targetHeight:Int = midBar.minHeight;
                var newYPosition:Int = (targetHeight * i );
                
                if ( i > num ){
                    newYPosition = newYPosition + heightOfOpenBox - targetHeight;
                }
                
                UIView.beginAnimations(nil, context: nil );
                UIView.setAnimationDuration(0.3);
                UIView.setAnimationBeginsFromCurrentState(true);
                UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut);
                
                midBar.frame = CGRect(x: midBar.frame.origin.x, y: CGFloat(newYPosition), width: midBar.frame.size.width, height: CGFloat(targetHeight));
                
                UIView.commitAnimations();
                
                totalHeightForContainer = totalHeightForContainer + targetHeight;
                
            } else {
                
                var targetHeight:Int = bar.fullHeight;
                var newYPosition:Int = (bar.minHeight * num);
                yPosForItem = newYPosition;
                heightOfSelectedBox = targetHeight;
                
                bar.spinArrow(180);
                
                UIView.beginAnimations(nil, context: nil );
                UIView.setAnimationDuration(0.3);
                UIView.setAnimationBeginsFromCurrentState(true);
                UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut);
                
                // close the view
                if ( currentlySelectedItem == num ){
                    
                    bar.spinArrow(0);
                    currentlySelectedItem = -1;
                    bar.frame = CGRect(x: bar.frame.origin.x, y: CGFloat(newYPosition), width: bar.frame.size.width, height: CGFloat(bar.minHeight));
                    heightOfOpenBox = bar.minHeight;
                    totalHeightForContainer = totalHeightForContainer + bar.minHeight;
                    heightOfSelectedBox = bar.minHeight;
                    
                    // open the proper view
                } else {
                    currentlySelectedItem = num
                    bar.frame = CGRect(x: bar.frame.origin.x, y: CGFloat(newYPosition), width: bar.frame.size.width, height: CGFloat(targetHeight));
                    totalHeightForContainer = totalHeightForContainer + targetHeight;
                    heightOfSelectedBox = bar.minHeight;
                }
                
                UIView.commitAnimations();
                
            }
        }
        
        var newYPos:Int = bar.minHeight * num;
        
        UIView.beginAnimations(nil, context: nil );
        UIView.setAnimationDuration(0.3);
        UIView.setAnimationBeginsFromCurrentState(true);
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut);
        
        self.contentSize = CGSize(width: self.frame.size.width, height: CGFloat(totalHeightForContainer));
        
        UIView.commitAnimations();
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("setRect:"), userInfo: newYPos, repeats: false);
    }
    
    func setRect(timer: NSTimer) {
        var vw:UIView = self.superview!;
        self.scrollRectToVisible(CGRect(x: 0, y: CGFloat(timer.userInfo as NSNumber), width: self.frame.size.width, height: vw.frame.size.height), animated: true);
    }
}