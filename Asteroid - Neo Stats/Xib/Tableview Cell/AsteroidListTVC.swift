//
//  AsteroidListTVC.swift
//  Asteroid - Neo Stats
//
//  Created by Keyur on 08/09/22.
//

import UIKit

class AsteroidListTVC: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var diameterLbl: UILabel!
    @IBOutlet weak var magnitudeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : NearEarthObject) {
        nameLbl.text = dict.name
        diameterLbl.text = "Diameter : \(getDoubleValueString(dict.estimatedDiameter!.meters.estimatedDiameterMax)) meters"
        magnitudeLbl.text = "Magnitude : \(dict.absoluteMagnitudeH)"
        if dict.closeApproachData.count > 0 {
            dateLbl.text = "Date : \(dict.closeApproachData[0].closeApproachDateFull)"
        }else{
            dateLbl.text = ""
        }
        outerView.setBorderColor(borderColor: dict.isPotentiallyHazardousAsteroid ? RedColor : GreenColor)
        nameView.setBorderColor(borderColor: dict.isPotentiallyHazardousAsteroid ? RedColor : GreenColor)
        outerView.backgroundColor = dict.isPotentiallyHazardousAsteroid ? colorFromHex(hex: "9D000B", alpha: 0.2) : colorFromHex(hex: "005203", alpha: 0.2)
        nameView.backgroundColor = dict.isPotentiallyHazardousAsteroid ? colorFromHex(hex: "9D000B", alpha: 1.0) : colorFromHex(hex: "005203", alpha: 1.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


