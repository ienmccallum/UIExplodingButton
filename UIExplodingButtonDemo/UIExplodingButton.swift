//
//  UIExplodingButton.swift
//  UIExplodingButtonDemo
//
//  Created by Otávio Zabaleta on 09/03/2015.
//  Copyright (c) 2015 OZ. All rights reserved.
//

import UIKit

let MAX_CHILD: UInt = 8

protocol UIExplodingButtonDelegate {
    func touchUpInside(button: UIButton)
}

class UIExplodingButton: UIButton {
    var childButtons = Array<UIButton>()
    var viewController: UIViewController!
    var childCount: UInt! = 0
    var delegate: UIExplodingButtonDelegate?
    var isExpanded: Bool! = false
    
    func addButton(button: UIButton) {
        self.childButtons.append(button)
    }
    
    func addButton(title aTitle: String, tag: Int) {
        if self.childCount >= MAX_CHILD {
            return
        }
    
        var newButton = UIButton(frame: self.frame)
        newButton.alpha = 0.0
        newButton.setTitle(aTitle, forState: UIControlState.Normal)
        newButton.setTitleColor(self.titleColorForState(UIControlState.Normal), forState: UIControlState.Normal)
        newButton.setTitle(aTitle, forState: UIControlState.Highlighted)
        newButton.setTitleColor(self.titleColorForState(UIControlState.Highlighted), forState: UIControlState.Highlighted)
        newButton.titleLabel?.font = self.titleLabel?.font
        newButton.tag = tag
        newButton.layer.borderColor = self.layer.borderColor
        newButton.layer.borderWidth = self.layer.borderWidth
        newButton.layer.cornerRadius = self.layer.cornerRadius
        newButton.backgroundColor = self.backgroundColor?
        newButton.addTarget(self, action: Selector("buttonTouched:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.childButtons.append(newButton)
        self.childCount = self.childCount + 1
        self.viewController.view.addSubview(newButton)
        self.viewController.view.bringSubviewToFront(self)
    }
    
    func buttonTouched(button: UIButton) {
        self.delegate?.touchUpInside(button)
    }
    
    func explode() {
        if self.childCount <= 0 {
            return
        }
        
        if(isExpanded!) {
            for button in childButtons {
                UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    button.frame.origin.x = self.frame.origin.x
                    button.frame.origin.y = self.frame.origin.y
                    button.alpha = 0.0
                }, completion: { (Bool) -> Void in

                })
            }
            isExpanded = false
            return;
        }
        
        let distance = Float(self.frame.size.width + 10)
        let angleIncrement = ((360.0 / Float(self.childCount))) * Float(M_PI) / 180.0
        var angle: Float = Float(M_PI_2)
        
        switch childCount {
            case 2:
                angle = Float(-M_PI)
            case 4:
                angle = Float(-M_PI_4)
            case 6:
                angle = Float(-M_PI_2)
            default:
                break
        }
    
        for button in self.childButtons {
            var newX = CGFloat(distance * cosf(angle));
            var newY = CGFloat(distance * sinf(angle));
            angle += angleIncrement
            
            UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                button.frame.origin.x += newX
                button.frame.origin.y += newY
                button.alpha = 1.0
            }, completion: nil)
        }
        
        isExpanded = true
    }
    
    deinit {
        for button in self.childButtons {
            button.removeFromSuperview()
        }
    }
}
