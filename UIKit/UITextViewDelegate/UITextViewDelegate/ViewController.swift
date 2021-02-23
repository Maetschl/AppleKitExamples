//
//  ViewController.swift
//  UITextViewDelegate
//
//  Created by Julian Arias Maetschl on 23-02-21.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        let attributedString = NSMutableAttributedString(string: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.")
        attributedString.addAttribute(.link, value: "", range: NSRange(location: 22, length: 55))

        textView.attributedText = attributedString
        textView.font = UIFont.systemFont(ofSize: 18.0)
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("Click")
        return false
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        false
    }

}

