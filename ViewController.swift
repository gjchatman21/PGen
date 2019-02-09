//
//  ViewController.swift
//  PGen
//
//  Created by Gregory Chatman on 2/4/19.
//  Copyright © 2019 Gregory Chatman. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    // Properties
    var wordPart1 = ""
    var wordPart2 = ""
    var newPassword = ""
    var dictionary1 = [String]()
    var dictionary2 = [String]()
    
    // Not sure what this does..
    override func viewDidLoad() {
        super.viewDidLoad()
        newPasswordTextField.delegate = self
    }
    
    // Dismiss the keyboard if up by touching the display
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Dismiss the keyboard by pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Button to Generate Password
    @IBAction func generatePassword(_ sender: UIButton) {

        doStuffForPassword(on: sender)
    }
    
    // Button Copy the password to clipboard
    @IBAction func copyToClipBoardButton(_ sender: UIButton) {
        
        //copy password to clipboard
        let myClipBoard = UIPasteboard.general
        myClipBoard.string = newPasswordTextField.text
        
    }
    
    // Method to Generate Password from dictionary file
    func doStuffForPassword(on button: UIButton){
        
            // Look up file path by file name and file extention
            if let wordsFilePath = Bundle.main.path(forResource: "words", ofType: "txt") {
                
                // If file/path?? found, put into startwords and seperate each line/word into a array
                if let wordsFile = try? String(contentsOfFile: wordsFilePath) {
                dictionary1 = wordsFile.components(separatedBy: "\n")
                dictionary2 = wordsFile.components(separatedBy: "\n")
                }
            }
            else {
                print("FILE NOT FOUND, PATH INCORRECT, or IM DOING THIS WRONG")
            }
            
            // Shuffle each arrary
            dictionary1.shuffle()
            dictionary2.shuffle()

            // Go through each array and only get word with 6 or more characters
           dictionary1.forEach {
                word1 in
                if word1.count >= 7 && word1.count <= 9 {
                    wordPart1 = word1
                }
            }
            
            dictionary2.forEach {
                word2 in
                if word2.count >= 7 && word2.count <= 9 {
                    wordPart2 = word2
                }
            }
        
            // concatenate the two words together
            newPassword = wordPart1 + wordPart2
            
            // replace vowels with special characters
            // Need to do REGEX here for speed
            newPassword = newPassword.replacingOccurrences(of: "a", with: "@")
            newPassword = newPassword.replacingOccurrences(of: "k", with: "&")
            newPassword = newPassword.replacingOccurrences(of: "i", with: "!")
            newPassword = newPassword.replacingOccurrences(of: "o", with: "0")
            newPassword = newPassword.replacingOccurrences(of: "s", with: "$")
            
            //shuffle password
            var passwordArray = Array(newPassword) // put each character of the string into array
            passwordArray = passwordArray.shuffled() // shuffle array
            newPassword = String(passwordArray) // put array back together as string
            
            //display password
            newPasswordTextField.text = newPassword
    }
}

