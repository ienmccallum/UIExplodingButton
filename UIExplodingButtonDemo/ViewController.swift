//
//  ViewController.swift
//  UIExplodingButtonDemo
//
//  Created by Otávio Zabaleta on 09/03/2015.
//  Copyright (c) 2015 OZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIExplodingButtonDelegate, UIAlertViewDelegate {

    @IBOutlet weak var explodingButton: UIExplodingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        explodingButton.layer.cornerRadius = 40;
        explodingButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        explodingButton.layer.borderWidth = 0.5
        explodingButton.delegate = self
        explodingButton.viewController = self
        
        explodingButton.addButton(title: "First", tag: 1)
        explodingButton.addButton(title: "Second", tag: 2)
        explodingButton.addButton(title: "Third", tag: 3)
        explodingButton.addButton(title: "Forth", tag: 4)
        explodingButton.addButton(title: "Fifth", tag: 5)
        explodingButton.addButton(title: "Sixth", tag: 6)
    }

    @IBAction func explodingButtonPressedf(sender: UIExplodingButton) {
        explodingButton.explode()
    }
    
    func touchUpInside(button: UIButton) {
        var title = ""
        switch button.tag {
            case 1:
                title = "First"
            case 2:
                title = "Second"
            case 3:
                title = "Third"
            case 4:
                title = "Forth"
            case 5:
                title = "Fifth"
            case 6:
                title = "Sixth"
            default:
                title = "\(button.tag)"
        }

        UIAlertView(title: "", message: title, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "OK").show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.explodingButton.explode()
    }
}

