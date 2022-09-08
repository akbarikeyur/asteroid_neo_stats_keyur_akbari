//
//  DatePickerViewVC.swift
//  Asteroid - Neo Stats
//
//  Created by iMac on 07/09/22.
//

import UIKit

class DatePickerViewVC: UIViewController {

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func setupDatePickerDetails(title : String, selected : Date?, minDate : Date?, maxDate : Date?) {
        self.datePicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            self.datePicker.preferredDatePickerStyle = .inline
        }
        delay(0.0) {
            self.titleLbl.text = getTranslate(title)
            self.datePicker.minimumDate = minDate
            self.datePicker.maximumDate = maxDate
            if selected != nil {
                self.datePicker.date = selected!
            }
        }
    }
    
    func setupTimePickerDetails(title : String, selected : Date?) {
        self.datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
        delay(0.0) {
            self.titleLbl.text = getTranslate(title)
            if selected != nil {
                self.datePicker.date = selected!
            }
            
        }
    }
    
    func setupDateTimePickerDetails(title : String, selected : Date?) {
        self.datePicker.datePickerMode = .dateAndTime
        if #available(iOS 14.0, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
        delay(0.0) {
            self.titleLbl.text = getTranslate(title)
            if selected != nil {
                self.datePicker.date = selected!
            }
        }
    }
   

}
