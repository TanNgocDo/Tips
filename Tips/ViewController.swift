//
//  ViewController.swift
//  Tips
//
//  Created by Do Ngoc Tan on 8/4/15.
//  Copyright (c) 2015 Do Ngoc Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lbTip: UILabel!
    
    @IBOutlet weak var txtBill: UITextField!
    
    @IBOutlet weak var lbTotal: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var numberFormatter : NSNumberFormatter!
    var tipSetting : TipSetting!
    var tip : Double = 0.0
    var total: Double = 0.0
    
    
    func getStoredPercentTip() {
        tipSetting = TipSetting()
        var defaults = NSUserDefaults.standardUserDefaults()
        
        var tipOne = defaults.integerForKey("tip_one")
        var tipTwo = defaults.integerForKey("tip_two")
        var tipThree = defaults.integerForKey("tip_three")
        if( tipOne==0 && tipTwo==0 && tipThree==0 ) {
            tipSetting.tipOne = 18
            tipSetting.tipTwo = 20
            tipSetting.tipThree = 25
        }
        else{
            tipSetting.tipOne = tipOne
            tipSetting.tipTwo = tipTwo
            tipSetting.tipThree = tipThree
        }
    }
    
    func savePercentTip(){
        var defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(tipSetting.tipOne, forKey: "tip_one")
        defaults.setInteger(tipSetting.tipTwo, forKey: "tip_two")
        defaults.setInteger(tipSetting.tipThree, forKey: "tip_three")
        defaults.synchronize()
    }
    
    func initTipControl() {
        tipControl.setTitle( String(tipSetting.tipOne) + "%", forSegmentAtIndex: 0)
        tipControl.setTitle( String(tipSetting.tipTwo) + "%", forSegmentAtIndex: 1)
        tipControl.setTitle( String(tipSetting.tipThree) + "%", forSegmentAtIndex: 2)    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "localeChanged:",
            name: NSCurrentLocaleDidChangeNotification, object: nil)
        
        numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        numberFormatter.locale = NSLocale.autoupdatingCurrentLocale()
        
        self.getStoredPercentTip()
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func applicationWillEnterForeground(notification: NSNotification) {
       
       
    }
    
    func localeChanged(note: NSNotification!) {
        numberFormatter.locale = NSLocale.autoupdatingCurrentLocale()
        lbTip.text = numberFormatter.stringFromNumber(tip)
        lbTotal.text = numberFormatter.stringFromNumber(total)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
       
        lbTip.text = numberFormatter.stringFromNumber(tip)
        lbTotal.text = numberFormatter.stringFromNumber(total)
        self.initTipControl()
       
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.savePercentTip()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
    }
    
    
    
    @IBAction func onEdittingChanged(sender: AnyObject) {
        
        var tipPercentOne = Double(tipSetting.tipOne)/100.0
        var tipPercentTwo = Double(tipSetting.tipTwo)/100.0
        var tipPercentThree = Double(tipSetting.tipThree)/100.0
        var tipPercent = [tipPercentOne, tipPercentTwo,tipPercentThree]
        var curTipPercent = tipPercent[tipControl.selectedSegmentIndex]
        
        var billAmount = ( txtBill.text as NSString ).doubleValue
        tip = billAmount*curTipPercent
        total = billAmount + tip
        lbTip.text = numberFormatter.stringFromNumber(tip)
        lbTotal.text = numberFormatter.stringFromNumber(total)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( segue.identifier == "goSetting") {
            let settingVC:SettingViewController = segue.destinationViewController as! SettingViewController
            let data = sender as! TipSetting
            settingVC.tipSetting = data
        }
        
        
    }
    
    
    @IBAction func showSetting(sender: AnyObject) {
        
        
        self.performSegueWithIdentifier("goSetting", sender: tipSetting )
        
    }
    
}

