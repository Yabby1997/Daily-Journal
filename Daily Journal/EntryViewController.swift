//
//  EntryViewController.swift
//  Daily Journal
//
//  Created by yabby on 2021/02/16.
//

import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if entry == nil {
            // Entry가 존재하지않는다면 생성해야한다.
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                entry = Entry(context: context)
                entry?.date = datePicker.date
                entry?.text = "오늘은 "
                textView.becomeFirstResponder(  )
            }
        }
        // date는 optional을 받을 수 없어 먼저 unwrap해줘야한다.
        if let dateToBeShown = entry?.date {
            datePicker.date = dateToBeShown
        }
        //textView는 optional을 받을 수 있다.
        textView.text = entry?.text
        textView.delegate = self
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            print(keyboardHeight)
            
            bottomConstraint.constant = keyboardHeight
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = textView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        entry?.date = datePicker.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func deleteEntry(_ sender: Any) {
        if entry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                context.delete(entry!)
                //이런식으로도 변화를 저장해줄 수 있다.
                try? context.save()
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
