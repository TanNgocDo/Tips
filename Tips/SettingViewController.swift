//
//  SettingViewController.swift
//  Tips
//
//  Created by Do Ngoc Tan on 8/5/15.
//  Copyright (c) 2015 Do Ngoc Tan. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController,UITextFieldDelegate {
    var tipSetting : TipSetting!
    
    @IBOutlet weak var txtTipOne: UITextField!
    
    @IBOutlet weak var txtTipTwo: UITextField!
    
    
    @IBOutlet weak var txtTipThree: UITextField!
    
    @IBOutlet weak var swBackground: UISwitch!
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTipOne.delegate = self
        txtTipTwo.delegate = self
        txtTipThree.delegate = self
        
        txtTipOne.text = String(tipSetting.tipOne)
        txtTipTwo.text = String(tipSetting.tipTwo)
        txtTipThree.text = String(tipSetting.tipThree)
        
     //   swBackground.on = tipSetting.hasBackground
        
     //   tipControl.selectedSegmentIndex = tipSetting.curIdx
        
        
          }
    func initTipControl() {
        tipControl.selectedSegmentIndex = tipSetting.curIdx
        tipControl.setTitle( String(tipSetting.tipOne) + "%", forSegmentAtIndex: 0)
        tipControl.setTitle( String(tipSetting.tipTwo) + "%", forSegmentAtIndex: 1)
        tipControl.setTitle( String(tipSetting.tipThree) + "%", forSegmentAtIndex: 2)    }
    
    override func viewWillAppear(animated: Bool) {
        
        swBackground.on = tipSetting.hasBackground
        self.initTipControl()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        let prospectiveText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if textField == txtTipOne || textField == txtTipTwo || textField == txtTipThree {
            if count(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.-").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                
                let resultingStringLengthIsLegal = count(prospectiveText) <= 2
                
                let scanner = NSScanner(string: prospectiveText)
                let resultingTextIsNumeric = scanner.scanDecimal(nil) && scanner.atEnd
                
                result = replacementStringIsLegal &&
                    resultingStringLengthIsLegal &&
                resultingTextIsNumeric
            }
        }
        return result
    }
    

    @IBAction func onTipOneChanged(sender: AnyObject) {
//        if( !txtTipOne.text.isEmpty ) {
//        tipSetting.tipOne = txtTipOne.text.toInt()
//        }
        tipControl.setTitle( String(txtTipOne.text) + "%", forSegmentAtIndex: 0)
    }
    
    
    @IBAction func onTipTwoChange(sender: AnyObject) {
       // tipSetting.tipTwo = txtTipTwo.text.toInt()
        tipControl.setTitle( String(txtTipTwo.text) + "%", forSegmentAtIndex: 1)
    }
    
    @IBAction func onTipThreeChanged(sender: AnyObject) {
      tipControl.setTitle( String(txtTipThree.text) + "%", forSegmentAtIndex: 2)
    }
    
    
    
    @IBAction func onTipOneEnd(sender: AnyObject) {
//        if( !txtTipOne.text.isEmpty ) {
//            tipSetting.tipOne = txtTipOne.text.toInt()
//        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if( !txtTipOne.text.isEmpty ) {
            tipSetting.tipOne = txtTipOne.text.toInt()
        }
        
        if( !txtTipTwo.text.isEmpty ) {
            tipSetting.tipTwo = txtTipTwo.text.toInt()
        }
        
        if( !txtTipThree.text.isEmpty ) {
            tipSetting.tipThree = txtTipThree.text.toInt()
        }
        
        tipSetting.hasBackground = swBackground.on
        tipSetting.curIdx = tipControl.selectedSegmentIndex
        
    }
    
}


