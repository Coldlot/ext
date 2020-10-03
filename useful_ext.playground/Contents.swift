import Foundation
import CoreLocation // for Coordinates
import UIKit // for UIDevice
import AudioToolbox // for handle vibration and sounds

//=================================
//trimming the string
extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed
    }
}

//usage:
var str1 = " a b c d    \n"
var str2 = str1.trimmed
str1.trim()
//=================================

//=================================
//int to double and double to int
extension Int {
    func toDouble() -> Double {
        Double(self)
    }
}

extension Double {
    func toInt() -> Int {
        Int(self)
    }
}

//usage:
let a = 15.78
let b = a.toInt()
//=================================

//=================================
//string to date and date to string
extension String {
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }
}

extension Date {
    func toString(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
}

//usage:
let strDate = "2020-08-10 15:00:00"
let date = strDate.toDate(format: "yyyy-MM-dd HH:mm:ss")
let strDate2 = date?.toString(format: "yyyy-MM-dd HH:mm:ss")
//=================================

//=================================
//cents to rub
extension Int {
    func centsToRub() -> Double {
        Double(self) / 100
    }
}

//usage:
let cents = 12350
let rubs = cents.centsToRub()
//=================================

//=================================
//string as coordinates
extension String {
    var asCoordinates: CLLocationCoordinate2D? {
        let components = self.components(separatedBy: ",")
        guard components.count == 2 else { return nil }
        let strLat = components[0].trimmed
        let strLng = components[1].trimmed
        guard let dLat = Double(strLat),
            let dLng = Double(strLng) else {
                return nil
        }
        return CLLocationCoordinate2D(latitude: dLat, longitude: dLng)
    }
}

//usage:
let strCoordinates = "41.6168, 41.6367"
//let coordinates = strCoordinates.asCoordinates
//=================================

//=================================
//string as url
extension String {
    var asURL: URL? {
        URL(string: self)
    }
}

//usage:
let strURL = "https://medium.com"
let url = strURL.asURL
//=================================

//=================================
//uidevice vibrate - vibration its the special sound at iOS
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }
}

//usage:
UIDevice.vibrate()
//=================================

//=================================
//calculating width and height of string label
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.width)
    }
}

//usage:
let text = "Hello, world!"
let textHeight = text.height(withConstrainedWidth: 100, font: UIFont.systemFont(ofSize: 16))
//=================================

//=================================
//string contains only digits
extension String {
    var containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
}

//usage:
let digitsOnlyYes = "1234567890".containsOnlyDigits
let digitsOnlyNo = "1234+567890".containsOnlyDigits
//=================================

//=================================
//string is alphanumeric
extension String {
    var isAlphaNumeric: Bool {
        !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

//usage:
let alphanumericYes = "asds1235adas".isAlphaNumeric
let alphanumericNo = "sdasd_/@#?$".isAlphaNumeric
//=================================

//=================================
//string subscripts
extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start..<end]
    }
    
    subscript(bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start...end]
    }
    
    subscript(bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        if end < start { return "" }
        return self[start...end]
    }
    
    subscript(bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex...end]
    }
    
    subscript(bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex..<end]
    }
}

//usage:
let subscript1 = "Hello, world!"[7...]
let subscript2 = "Hello, world!"[7...11]
//=================================

//=================================
//squared uiimage
extension UIImage {
    var squared: UIImage? {
        let originalWidth = size.width
        let originalHeight = size.height
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var edge: CGFloat = 0
        
        if originalWidth > originalHeight {
            //landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2
            y = 0
        } else if originalWidth < originalHeight {
            //portait
            edge = originalWidth
            x = 0
            y = (originalHeight - originalWidth) / 2
        } else {
            //square
            edge = originalWidth
        }
        
        let cropSquare = CGRect(x: x, y: y, width: edge, height: edge)
        guard let imageRef = cgImage?.cropping(to: cropSquare) else { return nil }
        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }
}

//usage:
let img = UIImage() //must be a real image
let imgSquare = img.squared
//=================================

//=================================
// resize an image to target resolution
extension UIImage {
    func resized(maxSize: CGFloat) -> UIImage? {
        let scale: CGFloat
        if size.width > size.height {
            scale = maxSize / size.width
        } else {
            scale = maxSize / size.height
        }
        
        let newWidth = size.width * scale
        let newHeight = size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

//usage:
let img2 = UIImage() // must be a real image
let img2Thumb = img2.resized(maxSize: 512) // resize to maxSize x maxSize resolution
//=================================

//=================================
//int to string
extension Int {
    func toString() -> String {
        "\(self)"
    }
}

//usage:
let i1 = 15
let i1AsString = i1.toString()
//=================================

//=================================
//double to string
extension Double {
    func toString() -> String {
        String(format: "%.2f", self)
    }
}

//usage:
let d1 = 15.6
let d1AsString = d1.toString()
//=================================

//=================================
//double to price
extension Double {
    func toPrice(currency: String) -> String {
        let nf = NumberFormatter()
        nf.decimalSeparator = ","
        nf.groupingSeparator = "'"
        nf.groupingSize = 3
        nf.usesGroupingSeparator = true
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return (nf.string(from: NSNumber(value: self)) ?? "?") + currency
    }
}

//usage:
let dPrice = 16323423.50
let strPrice = dPrice.toPrice(currency: "€")
//=================================

//=================================
//string as dict
extension String {
    var asDict: [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}

//usage:
let json = "{\"hello\": \"world\"}"
let dictFromJson = json.asDict
//=================================

//=================================
//string as array
extension String {
    var asArray: [Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]
    }
}

let json1 = "[1, 2, 3]"
let arrFromJson = json1.asArray
//=================================

//=================================
//string as attributed string
extension String {
    var asAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
}

//usage:
let htmlstring = "<p>Hello, <strong>world!</strong></p>"
let attrString = htmlstring.asAttributedString
//=================================

//=================================
//bundle app version
extension Bundle {
    var appVersion: String? {
        self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var mainAppVersion: String? {
        Bundle.main.appVersion
    }
}

//usage:
let appVersion = Bundle.mainAppVersion
//=================================
