//
//  ViewController.swift
//  MathGame
//
//  Created by administrator on 25/02/16.
//  Copyright © 2016 administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var pageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        let startButton = UIButton(type: UIButtonType.System) as UIButton
        
        startButton.frame = CGRectMake(0, 0, 116, 30)
        startButton.titleLabel!.font = (UIFont(name: "Helvetica Neue",size: 18))
        startButton.setTitle("Start Game !!!", forState: UIControlState.Normal)
        startButton.center = self.view.center
        startButton.addTarget(self, action: "startGameAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(startButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func startGameAction(sender: AnyObject) {
        presentViewController(PlaygroundController(), animated: true, completion: nil)
    }
}

