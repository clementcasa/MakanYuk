//
//  ViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var connectedButton: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }
    
    func changeImage() {
        if textField.text == "clement" {
            imageView.image = UIImage(named: "clement_image")
        } else if textField.text == "hilmy" {
            imageView.image = UIImage(named: "hilmy_image")
        }
    }
    
    @IBAction func didTapOnSignInButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnSegmentedControl(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 1 {
            signInButton.isHidden = false
            textField.isHidden = false
            labelText.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        changeImage()
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        if newString == "clement" {
            imageView.image = UIImage(named: "clement_image")
        } else if newString == "hilmy" {
            imageView.image = UIImage(named: "hilmy_image")
        } 
        return true
    }
}
