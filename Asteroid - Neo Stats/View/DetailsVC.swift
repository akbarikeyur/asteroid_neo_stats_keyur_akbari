//
//  DetailsVC.swift
//  Asteroid - Neo Stats
//
//  Created by iMac on 08/09/22.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var exactDateLbl: UILabel!
    @IBOutlet weak var magnitudeLbl: UILabel!
    @IBOutlet weak var isHazardousLbl: UILabel!
    @IBOutlet weak var isSentryLbl: UILabel!
    @IBOutlet weak var orbitalbodyLbl: UILabel!
    @IBOutlet weak var missDistanceAULbl: UILabel!
    @IBOutlet weak var missDistanceLDLbl: UILabel!
    @IBOutlet weak var missDistanceKMLbl: UILabel!
    @IBOutlet weak var missDistanceMilesLbl: UILabel!
    @IBOutlet weak var speedKMperSecLbl: UILabel!
    @IBOutlet weak var speedKMperhourLbl: UILabel!
    @IBOutlet weak var speedMilesperHourLbl: UILabel!
    @IBOutlet weak var diaMaxMetersLbl: UILabel!
    @IBOutlet weak var diaMinMetersLbl: UILabel!
    @IBOutlet weak var diaMaxFeetLbl: UILabel!
    @IBOutlet weak var diaMinFeetLbl: UILabel!
    
    var asteroidData =  NearEarthObject.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetails()
    }
    
    func setupDetails() {
        
        topView.backgroundColor = asteroidData.isPotentiallyHazardousAsteroid ? colorFromHex(hex: "9D000B", alpha: 1.0) : colorFromHex(hex: "005203", alpha: 1.0)
        titleLbl.text = "\(asteroidData.name)"
        magnitudeLbl.text = "Magnitude : \(asteroidData.absoluteMagnitudeH)"
        isHazardousLbl.text = "Is hazardous? : \(asteroidData.isPotentiallyHazardousAsteroid)"
        isSentryLbl.text = "Is Sentry? : \(asteroidData.isSentryObject)"
        
        if asteroidData.estimatedDiameter != nil {
            diaMaxMetersLbl.text = "Diameter Max (meters) : \(asteroidData.estimatedDiameter!.meters.estimatedDiameterMax)"
            diaMinMetersLbl.text = "Diameter Min (meters) : \(asteroidData.estimatedDiameter!.meters.estimatedDiameterMin)"
            diaMaxFeetLbl.text = "Diameter Min (feet) : \(asteroidData.estimatedDiameter!.feet.estimatedDiameterMax)"
            diaMinFeetLbl.text = "Diameter Min (feet) : \(asteroidData.estimatedDiameter!.feet.estimatedDiameterMin)"
        }
        else{
            diaMaxMetersLbl.text = ""
            diaMinMetersLbl.text = ""
            diaMaxFeetLbl.text = ""
            diaMinFeetLbl.text = ""
        }
        
        if asteroidData.closeApproachData.count > 0 {
            exactDateLbl.text = "Exact date : \(asteroidData.closeApproachData[0].closeApproachDateFull)"
            orbitalbodyLbl.text = "Orbital Body : \(asteroidData.closeApproachData[0].orbitingBody ?? "")"
            missDistanceAULbl.text = "Miss Distance (AU) : \(asteroidData.closeApproachData[0].missDistance?.astronomical ?? "")"
            missDistanceLDLbl.text = "Miss Distance (LD) : \(asteroidData.closeApproachData[0].missDistance?.lunar ?? "")"
            missDistanceKMLbl.text = "Miss Distance (KM) : \(asteroidData.closeApproachData[0].missDistance?.kilometers ?? "")"
            missDistanceMilesLbl.text = "Miss Distance (miles) : \(asteroidData.closeApproachData[0].missDistance?.miles ?? "")"
            speedKMperSecLbl.text = "Speed (km/s) : \(asteroidData.closeApproachData[0].relativeVelocity?.kilometersPerSecond ?? "")"
            speedKMperhourLbl.text = "Speed (km/h) : \(asteroidData.closeApproachData[0].relativeVelocity?.kilometersPerHour ?? "")"
            speedMilesperHourLbl.text = "Speed (miles/h) : \(asteroidData.closeApproachData[0].relativeVelocity?.milesPerHour ?? "")"
            
        }
        else{
            exactDateLbl.text = ""
            orbitalbodyLbl.text = ""
            missDistanceAULbl.text = ""
            missDistanceLDLbl.text = ""
            missDistanceKMLbl.text = ""
            missDistanceMilesLbl.text = ""
            speedKMperSecLbl.text = ""
            speedKMperhourLbl.text = ""
            speedMilesperHourLbl.text = ""
            
        }
    }
    
    @IBAction func clickToClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
