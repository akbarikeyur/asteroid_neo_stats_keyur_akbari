//
//  HomeVC.swift
//  Asteroid - Neo Stats
//
//  Created by Keyur on 07/09/22.
//

import UIKit

class HomeVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var endDateTxt: UITextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    var selectedStartDate : Date?
    var selectedEndDate : Date?
    
    var homeVM = HomeViewModel.init()
    var arrData = [NearEarthObject]()
   
    var refreshControl = UIRefreshControl.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewMethod()
        configUI()
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    func configUI() {
        selectedStartDate = Date().addDays(daysToAdd: -1)
        selectedEndDate = Date()
        startDateTxt.text = getDateStringFromDate(date: selectedStartDate!, format: DATE_FORMMATE.DATE2.rawValue)
        endDateTxt.text = getDateStringFromDate(date: selectedEndDate!, format: DATE_FORMMATE.DATE2.rawValue)
        noDataLbl.isHidden = true
        
        homeVM.homeList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                let arrKeys: [String] = self.homeVM.homeList.value.nearEarthObjects.map{String($0.key) }
                print(arrKeys)
                self.arrData = [NearEarthObject]()
                for temp in arrKeys {
                    if let data = self.homeVM.homeList.value.nearEarthObjects[temp], data.count > 0 {
                        for temp1 in data {
                            self.arrData.append(temp1)
                        }
                    }
                }
                self.tblView.reloadData()
                self.noDataLbl.isHidden = (self.homeVM.homeList.value.nearEarthObjects.count > 0)
            }
        }
        delay(0.1) {
            self.noDataLbl.isHidden = true
        }
        
        callAPI()
    }
    
    //MARK: - clickToSelectStartDate
    @IBAction func clickToSelectStartDate(_ sender: Any) {
        self.view.endEditing(true)
        showDatePicker(title: getTranslate("start_date"), selected: selectedStartDate, minDate: nil, maxDate: nil) { date in
            self.selectedStartDate = date
            self.startDateTxt.text = getDateStringFromDate(date: date, format: DATE_FORMMATE.DATE2.rawValue)
            if (self.selectedEndDate != nil) && (self.selectedStartDate! > self.selectedEndDate!) {
                self.selectedEndDate = nil
                self.endDateTxt.text = ""
            }
        } completionClose: {
            
        }
    }
    
    //MARK: - clickToSelectEndDate
    @IBAction func clickToSelectEndDate(_ sender: Any) {
        self.view.endEditing(true)
        showDatePicker(title: getTranslate("end_date"), selected: selectedEndDate, minDate: selectedStartDate, maxDate: nil) { date in
            self.selectedEndDate = date
            self.endDateTxt.text = getDateStringFromDate(date: date, format: DATE_FORMMATE.DATE2.rawValue)
        } completionClose: {
            
        }
    }
    
    //MARK: - clickToSubmit
    @IBAction func clickToSubmit(_ sender: Any) {
        if selectedStartDate == nil {
            displayToast("Please select start date")
        }
        else if selectedEndDate == nil {
            displayToast("Please select end date")
        }else{
            callAPI()
        }
    }
}

//MARK:- Tableview Method
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.AsteroidListTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.AsteroidListTVC.rawValue)
        refreshControl.addTarget(self, action: #selector(callAPI), for: .valueChanged)
        tblView.refreshControl = refreshControl
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AsteroidListTVC = tblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.AsteroidListTVC.rawValue) as! AsteroidListTVC
        cell.setupDetails(arrData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : DetailsVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.DetailsVC.rawValue) as! DetailsVC
        vc.asteroidData = arrData[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

extension HomeVC {
    @objc func callAPI() {
        refreshControl.endRefreshing()
        let request = AsteroidsListRequest.init(start_date: getDateStringFromDate(date: selectedStartDate!, format: DATE_FORMMATE.DATE4.rawValue), end_date: getDateStringFromDate(date: selectedEndDate!, format: DATE_FORMMATE.DATE4.rawValue), api_key: "DEMO_KEY")
        homeVM.getCatalogueData(request)
    }
}
