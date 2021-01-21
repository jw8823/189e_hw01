//
//  ViewController.swift
//  WaLite
//
//  Created by user190420 on 1/19/21.
//

import UIKit
import PhoneNumberKit
class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapPiece(gestureRecognizer:)))
        background.addGestureRecognizer(tapRecognizer)
        
    }
    let phoneNumberKit = PhoneNumberKit()
    
    @IBOutlet weak var input: PhoneNumberTextField!
    @IBOutlet var background: UIView!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var err_message: UILabel!
    
    
    //handle when send button is tapped
    @IBAction func tapsend() {
        do {
            if let raw = input.text {
                let phoneNumber = try phoneNumberKit.parse(raw)
                
                let pnumber = phoneNumberKit.format(phoneNumber, toType: .e164)
                err_message.text = "Code is sent to \(pnumber)"
            }
        }
        catch PhoneNumberError.notANumber {
                err_message.text = "Number is invalid \nPlease enter a valid number"
        } catch PhoneNumberError.unknownType {
                err_message.text = "Number type is unknown \nPlease enter a valid number"
        } catch {
            err_message.text = "Please enter a valid number"
        }
    }
    //dismiss the keyboard when screen is tapped(except the input and send button)
    @IBAction func tapPiece(gestureRecognizer : UITapGestureRecognizer ) {
       guard gestureRecognizer.view != input else { return }
       guard gestureRecognizer.view != send else { return }
       input.resignFirstResponder()
    }
}

