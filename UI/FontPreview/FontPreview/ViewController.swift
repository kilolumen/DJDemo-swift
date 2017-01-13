//
//  ViewController.swift
//  FontPreview
//
//  Created by Weico on 1/6/17.
//  Copyright © 2017 kilolumen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {

    var familyNames: Array<String> = []
    var fontNamesArray = [Array<Any>]()

    var fontSize = 16
    var lineHeight = 21
    var font = UIFont.systemFont(ofSize: 16)

    @IBOutlet weak var fontSizeTextField: UITextField!
    @IBOutlet weak var lineHeightTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        parserFont()

        fontSizeTextField.text = String(fontSize)
        lineHeightTextField.text = String(lineHeight)
        
        fontSizeTextField.delegate = self
        lineHeightTextField.delegate = self
        textView.delegate = self;
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        tableView.sectionHeaderHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerReuseIdentifier")

        updateText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func doneButtonDidTapped(_ sender: Any) {
        fontSizeTextField.resignFirstResponder()
        lineHeightTextField.resignFirstResponder()
    }
    /// update **text**
    func updateText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = CGFloat(lineHeight)
        let attributes = [NSFontAttributeName: UIFont(name: font.fontName, size: CGFloat(fontSize)),
                          NSParagraphStyleAttributeName: paragraphStyle]
        textView.attributedText = NSAttributedString.init(string: textView.text, attributes: attributes)
    }

    /**
        Parse iOS Font.
        ### Font ###
        ```
            parserFont()
        ```
        ## ddd ##
        * use
        1. parse
     */
    func parserFont() {
        familyNames = UIFont.familyNames
        familyNames = familyNames.sorted { (familyName1, familyName2) -> Bool in
            return familyName1 < familyName2
        }
        for familyName in familyNames {
            var fontNames = UIFont.fontNames(forFamilyName: (familyName))
            if fontNames.count == 0 {
                fontNames.append(familyName)
            }
            fontNamesArray.append(fontNames)
        }
    }

    // MARK: UITableViewDataSource & UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return familyNames.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNamesArray[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)
        cell.textLabel?.attributedText = NSAttributedString(string: fontNamesArray[indexPath.section][indexPath.row] as! String, attributes: [NSFontAttributeName: UIFont(name: fontNamesArray[indexPath.section][indexPath.row] as! String, size: 16)!])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerReuseIdentifier")
        header?.textLabel?.attributedText = NSAttributedString.init(string: familyNames[section], attributes: [NSFontAttributeName: UIFont.init(name: familyNames[section], size: 16)!])
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        font = UIFont(name: fontNamesArray[indexPath.section][indexPath.row] as! String, size: CGFloat(fontSize))!
        updateText()
    }

    // MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if textField == fontSizeTextField {
            if (textField.text?.lengthOfBytes(using: .utf8))! > 0 {
                fontSize = Int(textField.text ?? "16")!
            } else {
                fontSize = 16
            }
        } else if textField == lineHeightTextField {
            if (textField.text?.lengthOfBytes(using: .utf8))! > 0 {
                lineHeight = Int(textField.text ?? "16")!
            } else {
                lineHeight = 21
            }
        }
        updateText()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    // MARK: UITextViewDelegate
    func textViewDidEndEditing(_ textView: UITextView) {
        updateText()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }

}

