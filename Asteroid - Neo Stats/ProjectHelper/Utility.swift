//
//  Utility.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import Foundation
import Toast_Swift
import SafariServices
import Foundation
import MapKit

struct PLATFORM {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

extension UIView {
    //MARK: - addBorderColorWithCornerRadius
    func addBorderColorWithCornerRadius(borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}

//MARK:- toJson
func toJson(_ dict:[String:Any]) -> String{
    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let jsonString = String(data: jsonData!, encoding: .utf8)
    return jsonString!
}

//MARK: - getCurrentTimeStampValue
func getCurrentTimeStampValue() -> String
{
    return String(format: "%0.0f", Date().timeIntervalSince1970*1000)
}

//MARK: - DataExtension
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}

//MARK:- Delay Features
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

//MARK:- Toast
func displayToast(_ message:String)
{
    UIApplication.topViewController()?.view.makeToast(getTranslate(message))
}


func displayToastWithDelay(_ message:String)
{
    delay(0.2) {
        UIApplication.topViewController()?.view.makeToast(getTranslate(message))
    }
}


//MARK:- Image Function
func compressImageView(_ image: UIImage, to toSize: CGSize) -> UIImage {
    var actualHeight: Float = Float(image.size.height)
    var actualWidth: Float = Float(image.size.width)
    let maxHeight: Float = Float(toSize.height)
    //600.0;
    let maxWidth: Float = Float(toSize.width)
    //800.0;
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    //50 percent compression
    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }
    let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    let imageData1: Data? = img?.jpegData(compressionQuality: 1.0)//UIImageJPEGRepresentation(img!, CGFloat(1.0))//UIImage.jpegData(img!)
    UIGraphicsEndImageContext()
    return  imageData1 == nil ? image : UIImage(data: imageData1!)!
}

//MARK:- Loader
func showLoader()
{
    AppDelegate().sharedDelegate().showLoader()
}

// MARK: - removeLoader
func removeLoader()
{
    AppDelegate().sharedDelegate().removeLoader()
}

//Image Compression to 10th
func compressImage(image: UIImage) -> Data {
    // Reducing file size to a 10th
    var actualHeight : CGFloat = image.size.height
    var actualWidth : CGFloat = image.size.width
    let maxHeight : CGFloat = 1920.0
    let maxWidth : CGFloat = 1080.0
    var imgRatio : CGFloat = actualWidth/actualHeight
    let maxRatio : CGFloat = maxWidth/maxHeight
    var compressionQuality : CGFloat = 0.5
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if (imgRatio < maxRatio) {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        } else if (imgRatio > maxRatio) {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        } else {
            actualHeight = maxHeight
            actualWidth = maxWidth
            compressionQuality = 1
        }
    }
    let rect = CGRect(x: 0.0, y: 0.0, width:actualWidth, height:actualHeight)
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    let imageData = img!.jpegData(compressionQuality: compressionQuality)
    UIGraphicsEndImageContext();
    return imageData!
}

func showDatePicker(title : String, selected: Date?,  minDate : Date?, maxDate : Date?, completionDone: @escaping (_ date : Date) -> Void, completionClose: @escaping () -> Void){
    
    let vc : DatePickerViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.DatePickerViewVC.rawValue) as! DatePickerViewVC
    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
    vc.setupDatePickerDetails(title: title, selected: selected, minDate: minDate, maxDate: maxDate)

    vc.closeBtn.addAction {
        vc.view.removeFromSuperview()
        completionClose()
    }
    vc.doneBtn.addAction {
        vc.view.removeFromSuperview()
        completionDone(vc.datePicker.date)
    }
}

func showTimePicker(title : String, selected: Date?, completionDone: @escaping (_ date : Date) -> Void, completionClose: @escaping () -> Void){
    
    let vc : DatePickerViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.DatePickerViewVC.rawValue) as! DatePickerViewVC
    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
    vc.setupTimePickerDetails(title: title, selected: selected)

    vc.closeBtn.addAction {
        vc.view.removeFromSuperview()
        completionClose()
    }
    vc.doneBtn.addAction {
        vc.view.removeFromSuperview()
        completionDone(vc.datePicker.date)
    }
}

func showDateTimePicker(title : String, selected: Date?,  minDate : Date?, maxDate : Date?, completionDone: @escaping (_ date : Date) -> Void, completionClose: @escaping () -> Void){
    
    let vc : DatePickerViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.DatePickerViewVC.rawValue) as! DatePickerViewVC
    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
    vc.setupDateTimePickerDetails(title: title, selected: selected)

    vc.closeBtn.addAction {
        vc.view.removeFromSuperview()
        completionClose()
    }
    vc.doneBtn.addAction {
        vc.view.removeFromSuperview()
        completionDone(vc.datePicker.date)
    }
}
//
//func showAlertWithOption(_ title:String, message:String, btns:[String] ,completionConfirm: @escaping () -> Void,completionCancel: @escaping () -> Void){
//    let vc : AlertViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.AlertViewVC.rawValue) as! AlertViewVC
//    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
//    vc.setupDetails(title, message, btns)
//
//    vc.cancelBtn.addAction {
//        vc.view.removeFromSuperview()
//        completionCancel()
//    }
//    vc.okBtn.addAction {
//        vc.view.removeFromSuperview()
//        completionConfirm()
//    }
//}
//
//func showAlert(_ title:String, message:String, btn : String = "OK", completion: @escaping () -> Void) {
//    let vc : AlertViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "AlertViewVC") as! AlertViewVC
//    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
//    vc.setupDetails(title, message, [btn])
//
//    vc.fullBtn.addAction {
//        vc.view.removeFromSuperview()
//        completion()
//    }
//}
//
//
//func showPopup(image:String, title:String, desc:String, btns:[String] ,completionConfirm: @escaping () -> Void,completionCancel: @escaping () -> Void){
//
//    let vc : PopupViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.PopupViewVC.rawValue) as! PopupViewVC
//    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
//    vc.setupDetails(image, title, desc, btns)
//
//    vc.noBtn.addAction {
//        vc.view.removeFromSuperview()
//        completionCancel()
//    }
//    vc.okayBtn.addAction {
//        vc.view.removeFromSuperview()
//        completionConfirm()
//    }
//    vc.yesBtn.addAction {
//        vc.view.removeFromSuperview()
//        completionConfirm()
//    }
//}
//
//func showAppPopup(image:String, title:String, desc:String, btns:[String] ,completionConfirm: @escaping () -> Void,completionCancel: @escaping () -> Void){
//
//    let vc : AppPopupViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.AppPopupViewVC.rawValue) as! AppPopupViewVC
//    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
//    vc.setupDetails(image, title, desc, btns)
//
//    vc.okayBtn.addAction {
//        vc.view.removeFromSuperview()
//        completionConfirm()
//    }
//    vc.cancelBtn.addAction {
//        vc.view.removeFromSuperview()
//        completionConfirm()
//    }
//    vc.closeBtn.addAction {
//        vc.view.removeFromSuperview()
//        completionConfirm()
//    }
//}

func openMapForPlace(_ lat : Double, _ long: Double, _ address: String) {
    let latitude: CLLocationDegrees = lat
    let longitude: CLLocationDegrees = long
    
    let regionDistance:CLLocationDistance = 10000
    let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
    let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
    let options = [
        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = address
    mapItem.openInMaps(launchOptions: options)
}

//MARK: - height of a label
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    //MARK: - isValidEmail
    var isValidEmail: Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

//MARK: - displaySubViewtoParentView
func displaySubViewtoParentView(_ parentview: UIView! , subview: UIView!)
{
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    parentview.layoutIfNeeded()
}

func displayImageAnimation(_ image: UIImageView) {
    UIView.animate(withDuration: 0.6,
                   animations: {
                    image.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                   },
                   completion: { _ in
                    UIView.animate(withDuration: 0.6) {
                        image.transform = CGAffineTransform.identity
                    }
                   })
}

func getTranslate(_ str : String) -> String
{
    return NSLocalizedString(str, comment: "")
}

func displayFlotingValue(_ price : Double) -> String
{
    var finalValue = String(format: "%.1f", Float(price))
    if finalValue.contains(".0") {
        finalValue = finalValue.replacingOccurrences(of: ".0", with: "")
    }
    return finalValue
}

func getDoubleValueOfPrice(_ price : Double) -> String {
    return "$" + displayFlotingValue(price)
}

func getDoubleValueString(_ value : Double) -> String {
    return "\(String(format: "%.2f", value))"
}

//MARK:- Color function
func colorFromHex(hex : String) -> UIColor
{
    return colorWithHexString(hex, alpha: 1.0)
}

func colorFromHex(hex : String, alpha:CGFloat) -> UIColor
{
    return colorWithHexString(hex, alpha: alpha)
}

func colorWithHexString(_ stringToConvert:String, alpha:CGFloat) -> UIColor {
    
    var cString:String = stringToConvert.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

//MARK:- Card
func showCardNumberFormattedStr(_ str:String, isRedacted:Bool = true) -> String{
    let tempStr:String = sendDetailByRemovingChar(sendDetailByRemovingChar(str, char:"-"), char: " ")
    var retStr:String = ""
    for i in 0..<tempStr.count{
        if(i == 4 || i == 8 || i == 12){
            retStr += "-"
        }
        retStr += tempStr[i]
    }
    if(isRedacted){
        var arr:[String] = retStr.components(separatedBy: "-")
        for i in 0..<arr.count{
            if(i == 1 || i == 2){
                arr[i] = "xxxx"
            }
        }
        retStr = arr.joined(separator: "-")
    }
    return retStr
}

func showCardExpDateFormattedStr(_ str:String) -> String{
    
    let tempStr:String = sendDetailByRemovingChar(str, char:"/")
    var retStr:String = ""
    for i in 0..<tempStr.count{
        if(i == 2){
            retStr += "/"
        }
        retStr += tempStr[i]
    }
    return retStr
}

func sendDetailByRemovingChar(_ str:String, char:String = " ") -> String {
    let regExp :String = char + "\n\t\r"
    return String(str.filter { !(regExp.contains($0))})
}

//MARK:- UICollectionView
extension UICollectionView {
    //MARK:- setEmptyMessage
    public func sainiSetEmptyMessageCV(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
        
    }
    //MARK:- sainiRestore
    public func restore() {
        self.backgroundView = nil
        
    }
}

func convertToDictionary(_ text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

//MARK:- Get Json from file
func getJsonFromFile(_ file : String) -> [[String : Any]]
{
    if let filePath = Bundle.main.path(forResource: file, ofType: "json"), let data = NSData(contentsOfFile: filePath) {
        do {
            if let json : [[String : Any]] = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String : Any]] {
                return json
            }
        }
        catch {
            //Handle error
        }
    }
    return [[String : Any]]()
}

// MARK: - getCompleteString
func getCompleteString(strArr: [String]) -> String {
    var str: String = String()
    for i in 0..<strArr.count {
        if i == strArr.count - 1 {
            str += strArr[i]
        }
        else {
            str += (strArr[i]) + ", "
        }
    }
    return str
}

//MARK:- Open Url
func openUrlInSafari(strUrl : String)
{
    if strUrl.trimmed == "" {
        return
    }
    
    let webUrl = strUrl
    if webUrl.hasPrefix("https://") || webUrl.hasPrefix("http://"){
        guard let url = URL(string: webUrl) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }else {
        let correctedURL = "http://\(webUrl)"
        let escapedAddress = correctedURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let url = URL(string: escapedAddress ?? "") else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

//Get year array
func getYearArr() -> [String] {
    var yearArr : [String] = [String]()
    for i in 0...30 {
        let fromDate = Calendar.current.date(byAdding: .year, value: i, to: Date())
        yearArr.append(getDateStringFromDate1(date: fromDate!, format: "yyyy"))
    }
    return yearArr
}

//MARK:- Email
func redirectToEmail(_ email : String)
{
    if email == "" || !email.isValidEmail {
        displayToast("Invalid email address")
        return
    }
    guard let url = URL(string: "mailto:\(email)") else {
        displayToast("Invalid email address")
        return
    }
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url)
    } else {
        UIApplication.shared.openURL(url)
    }
}

func redirectToPhone(_ number : String) {
    if number.trimmed == "" {
        displayToast("Invalid phone number")
        return
    }
    if let url = URL(string: "tel://\(number)") {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }else{
        displayToast("Invalid phone number")
    }
}
func getDoubleValueOfDistance(_ price : Double) -> String {
    return "\(String(format: "%.1f", price))km"
}

func getLabelArray(_ label : [String]) -> String {
    return label.joined(separator: ", ")
}

func getLabelNextLineArray(_ label : [String]) -> String {
    return label.joined(separator: ", \n")
}


func isLocationAccessEnabled() -> Bool {
    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            return true
        default:
            break
        }
    } else {
        print("Location services not enabled")
        return false
    }
    return false
}

func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double, label: UILabel) {
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
    let ceo: CLGeocoder = CLGeocoder()
    center.latitude = pdblLatitude
    center.longitude = pdblLongitude
    var addressString : String = ""
    
    let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
    
    ceo.reverseGeocodeLocation(loc, completionHandler:
                                {(placemarks, error) in
                                    if (error != nil)
                                    {
                                        print("reverse geodcode fail: \(error!.localizedDescription)")
                                    }
                                    let pm = placemarks! as [CLPlacemark]
                                    
                                    if pm.count > 0 {
                                        let pm = placemarks![0]
                                        print(pm.country ?? "")
                                        print(pm.locality ?? "")
                                        print(pm.subLocality ?? "")
                                        print(pm.thoroughfare ?? "")
                                        print(pm.postalCode ?? "")
                                        print(pm.subThoroughfare ?? "")
                                        
                                        if pm.subLocality != nil {
                                            addressString = addressString + pm.subLocality! + ", "
                                        }
                                        if pm.thoroughfare != nil {
                                            addressString = addressString + pm.thoroughfare! + ", "
                                        }
                                        if pm.locality != nil {
                                            addressString = addressString + pm.locality! + ", "
                                        }
                                        if pm.country != nil {
                                            addressString = addressString + pm.country! + ", "
                                        }
                                        print(addressString)
                                        label.text = addressString
                                    }
                                })
}

//MARK:- Attribute string
func attributedStringWithColor(_ mainString : String, _ strings: [String], color: UIColor, font: UIFont? = nil) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: mainString)
    for string in strings {
        let range = (mainString as NSString).range(of: string)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        if font != nil {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font!, range: range)
        }
    }
    return attributedString
}

extension String {
    func queryParam(_ params : [String : Any]) -> String {
        return self + "?" + getQueryParameter(params)
    }
}

func getQueryParameter(_ params : [String : Any])  -> String {
    let urlParams = params.compactMap({ (key, value) -> String in
        return "\(key)=\(value)"
    }).joined(separator: "&")
    return urlParams
}

extension Encodable {
    //MARK:-  Converting object to postable JSON
    public func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        guard let data = try? encoder.encode(self) else { return [:] }
        guard let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        guard let json = object as? [String: Any] else { return [:] }
        return json
    }
}
