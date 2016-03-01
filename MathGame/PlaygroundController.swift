//
//  PlaygroundController.swift
//  MathGame
//
//  Created by administrator on 25/02/16.
//  Copyright © 2016 administrator. All rights reserved.
//

import Foundation
import UIKit

class PlaygroundController: UIViewController{
    
    var topLable = UILabel(frame: CGRectMake(10,30,150,30)) as UILabel
    var contentLable = UILabel(frame: CGRectMake(10, 80, 300, 160)) as UILabel
    var correctButton = UIButton(type: UIButtonType.System) as UIButton
    var wrongButton = UIButton(type: UIButtonType.System) as UIButton
    
    var progressBar = UIProgressView()
    
    var timer = NSTimer()
    var progressTimer = NSTimer()
    var expectedAnswer : NSString = ""
    var totalQuestions:Int = 0
    
    var timerTime:Float = 0.0
    var questionTimeLimit:Double = 3.2 // time limit for each question!!!
    
    var easyQuestions = [
        (question:"4 + 2 = 6", answer:"true"),
        (question:"8 + 2 = 12", answer:"false"),
        (question:"5 - 0 = 5", answer:"true"),
        (question:"8 + 5 = 13", answer:"true"),
        (question:"7 + 4 = 12", answer:"false"),
        (question:"7 + 0 = 7", answer:"true")
    ]

    var mediumQuestions = [
        (question:"4 * 2 = 10", answer:"false"),
        (question:"24 + 13 = 37", answer:"true"),
        (question:"36 * 2 = 62", answer:"false"),
        (question:"40 * 2 = 80", answer:"true"),
        (question:"4 * 2 = 8", answer:"true"),
        (question:"4 * 3 = 14", answer:"false"),
        (question:"11 * 2 = 22", answer:"true"),
        (question:"42 * 3 = 116", answer:"false"),
    ]
    
    var hardQuestions = [
        (question:"40 * 20 = 80", answer:"false"),
        (question:"12 * 12 = 144", answer:"true"),
        (question:"36 * 21 = 786", answer:"false"),
        (question:"43 * 80 = 3440", answer:"true"),
        (question:"15 * 5 = 75", answer:"true"),
        (question:"43 * 13 = 559", answer:"true"),
        (question:"37 * 7 = 249", answer:"false"),
        (question:"15 * 11 = 165", answer:"true"),
    ]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        topLable.text = "True (or) False"
        topLable.font = (UIFont(name: "Helvetica Neue",size: 16))
        topLable.textAlignment = NSTextAlignment.Left
        self.view.addSubview(topLable)
        
        
        contentLable.text = "question will be here"
        contentLable.font = (UIFont(name: "Helvetica Neue",size: 20))
        contentLable.textAlignment = NSTextAlignment.Center
        self.view.addSubview(contentLable)
        
        correctButton.frame = CGRectMake(15, 260, 130, 130)
        correctButton.setTitle(" ", forState: UIControlState.Normal)
        correctButton.setTitle("true", forState: UIControlState.Application)
        correctButton.backgroundColor = UIColor.greenColor()
        correctButton.addTarget(self, action: "updateAnswer:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(correctButton)
        
        wrongButton.frame = CGRectMake(175, 260, 130, 130)
        wrongButton.setTitle(" ", forState: UIControlState.Normal)
        wrongButton.setTitle("false", forState: UIControlState.Application)
        wrongButton.backgroundColor = UIColor.redColor()
        wrongButton.addTarget(self, action: "updateAnswer:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(wrongButton)
        
        progressBar.frame = CGRectMake(10, 60, 304, 20)
        progressBar.clipsToBounds = true;
        self.view.addSubview(progressBar)
        
        updateQuestion()
        
    }
    
    func updateQuestion()
    {
        expectedAnswer = "-";
        contentLable.text = getNextQuestionText()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(questionTimeLimit, target: self, selector: "timeUpAction", userInfo: nil, repeats: false)
        
        timerTime = 1.0
        progressTimer.invalidate()
        progressBar.setProgress(1.0, animated: false)
        progressTimer = NSTimer.scheduledTimerWithTimeInterval(questionTimeLimit/100, target: self, selector: "updateProgress", userInfo: nil, repeats: false)
        
    }
    
    func updateProgress()
    {
        if(timerTime<0.15)
        {
            progressBar.setProgress(0.0, animated: true)
            
        }else{
            timerTime -= 0.01;
            progressBar.setProgress(timerTime, animated: true)
            progressTimer = NSTimer.scheduledTimerWithTimeInterval(questionTimeLimit/100, target: self, selector: "updateProgress", userInfo: nil, repeats:false)
        }
        
    }
    
    func updateAnswer(sender: UIButton)
    {
        timer.invalidate()
        //NSLog("answer - %@ exp - %@",sender.titleForState(UIControlState.Application)!,expectedAnswer)
        if(expectedAnswer.isEqualToString(sender.titleForState(UIControlState.Application)!))
        {
            totalQuestions = totalQuestions + 1;
            updateQuestion()
        }
        else{
            showAlert("Sorry wrong answer... Your score is " + totalQuestions.description)

        }
    }
    
    func showAlert(alertMessage:NSString)
    {
        let myAlert = UIAlertController(title: "Game Over!!!", message: alertMessage as String, preferredStyle: UIAlertControllerStyle.Alert);
        let homeAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            self.presentViewController(ViewController(), animated: true, completion: nil)
        })

        myAlert.addAction(homeAction)
        self.presentViewController(myAlert, animated: true, completion: nil)

    }
    
    func timeUpAction()
    {
        showAlert("Time is up. your Score " + totalQuestions.description)

    }
    
    func getNextQuestionText() -> String
    {
        if(easyQuestions.count != 0)//easy
        {
            let ele = easyQuestions.removeAtIndex(Int(random())%easyQuestions.count)
            expectedAnswer = ele.answer
            return ele.question
        }else if(mediumQuestions.count != 0){
            let ele = mediumQuestions.removeAtIndex(Int(random())%mediumQuestions.count)
            expectedAnswer = ele.answer
            return ele.question
        }else if(hardQuestions.count != 0){
            let ele = hardQuestions.removeAtIndex(Int(random())%hardQuestions.count)
            expectedAnswer = ele.answer
            return ele.question
        }
        showAlert("Marvellous ... You have cleared all the questions. Your score is " + totalQuestions.description)
        return "next question"
    }
}