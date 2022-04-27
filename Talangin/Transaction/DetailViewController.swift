//
//  DetailViewController.swift
//  My Diary
//
//  Created by zy on 27/04/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol DetailViewControllerDelegate: AnyObject {
    // Delegate method that can be used
    func displayAlert(message:String?)
}

class DetailViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Output element & Outlet connection
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.drawARoundedCorner()
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.drawARoundedCorner()
            cancelButton.drawABorder()
        }
    }
    // MARK: - Object initialization & Optional
    var dataToBeUpdate: String?
    var isUpdated: Bool? = false
    // MARK: - delegate object initialization
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        if let data = dataToBeUpdate {
            textArea.text = data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let isUpdated = isUpdated {
            if !isUpdated {
                textArea.text = "Input your story here..."
            }
        }
        textArea.delegate = self
    }
    
    // MARK: - Delegate method from UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Let's clear up our text area, so then user can start to write their story
        textView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            // Since our textview text it's an optional, which possible to have a nil, then we need to use it savely
            if let storyHasSomething = textView.text {
                dataToBeUpdate = storyHasSomething
            }
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.displayAlert(message:self.textArea.text)
        }
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
