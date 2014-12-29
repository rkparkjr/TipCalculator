/*************************************************************************
*   ViewController.swift                                                 *
*   TipCalculator                                                        *
*                                                                        *
*   Created by Beni Cheni on 12/24/14.                                   *
*   Last updated by Beni Cheni on 12/29/14.                              *
*   Copyright (c) 2014 Beni Cheni Factory. All rights reserved.          *
*************************************************************************/

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var customTipPercentLabelTop: UILabel!
    @IBOutlet weak var customTipSlider: UISlider!
    @IBOutlet weak var customTipPercentLabelMidway: UILabel!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    let decimal100 = NSDecimalNumber(string: "100.0")
    let decimal15Percent = NSDecimalNumber(string: "0.15")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.becomeFirstResponder()
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let inputString = inputTextField.text
        let sliderValue = NSDecimalNumber(integer: Int(customTipSlider.value))
        let customPercent = sliderValue / decimal100
        
        if sender is UISlider {
            customTipPercentLabelTop.text = NSNumberFormatter.localizedStringFromNumber(customPercent, numberStyle: .PercentStyle)
            
            customTipPercentLabelMidway.text = customTipPercentLabelTop.text
        }
        
        if !inputString.isEmpty {
            let billAmount = NSDecimalNumber(string: inputString) / decimal100
            
            if sender is UITextField {
                billAmountLabel.text = " " + formatAsCurrency(billAmount)
                
                let fifteenTip = billAmount * decimal15Percent
                tip15Label.text = formatAsCurrency(fifteenTip)
                total15Label.text = formatAsCurrency(billAmount + fifteenTip)
            }
            
            let customTip = billAmount * customPercent
            tipCustomLabel.text = formatAsCurrency(customTip)
            totalCustomLabel.text = formatAsCurrency(billAmount + customTip)
        }
        else {
            billAmountLabel.text = ""
            tip15Label.text = ""
            total15Label.text = ""
            tipCustomLabel.text = ""
            totalCustomLabel.text = ""
        }
    }
}

func formatAsCurrency(number: NSNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(number, numberStyle: .CurrencyStyle)
}

func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}
