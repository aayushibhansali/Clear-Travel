//
//  Ticket.swift
//  ClearTravel
//

//


import UIKit
import CoreLocation
import QuartzCore

class Ticket: UIViewController {
    
    @IBOutlet var start: UITextField!
    @IBOutlet var destination: UITextField!
    @IBOutlet var range: UILabel!
    @IBOutlet var iv: UIImageView!
    var layer1: CALayer!
    var layer2: CALayer!
    @IBOutlet var tempButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    var temp1: Float!
    var temp2: Float!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iv.loadGif(name: "travel")
        
        layer1 = iv.layer
        layer1.cornerRadius = 25
        
        destination.LeftImage(imageViewNamed: "mappin")
        start.LeftImage(imageViewNamed: "mappin")
        
    }
    
    @IBAction func temperatureRange() {
        
        tempButton.isHidden = true
        nextButton.isHidden = false
        
        guard let startLocation = start.text, !startLocation.isEmpty,
              let destinationLocation = destination.text, !destinationLocation.isEmpty else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please enter valid start and destination locations.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
            return
        }
        
        let session = URLSession.shared
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(startLocation)&APPID=f31356634fbc4c64c86edd02aaf817c2&units=metric")!
        
        print("weatherURL: \(weatherURL)")
        
        let task = session.dataTask(with: weatherURL) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let main = json["main"] as? [String: Any],
                       let minTemperature = main["temp_min"] as? Double,
                       let maxTemperature = main["temp_max"] as? Double {
                        DispatchQueue.main.async {
                            self.range.text = "Start Location: \(minTemperature) °C - \(maxTemperature) °C"
                        }
                        self.temp1 = main["temp"] as? Float
                    }
                } catch {
                    print("JSON parsing error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
        
        
        let session1 = URLSession.shared
        let weatherURL1 = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(destinationLocation)&APPID=f31356634fbc4c64c86edd02aaf817c2&units=metric")!
        
        print("weatherURL: \(weatherURL1)")
        
        let task1 = session1.dataTask(with: weatherURL1) { (data, response, error) in
            if let error1 = error {
                print("Error: \(error1.localizedDescription)")
            } else if let data1 = data {
                do {
                    if let json1 = try JSONSerialization.jsonObject(with: data1, options: []) as? [String: Any],
                       let main1 = json1["main"] as? [String: Any],
                       let minTemperature1 = main1["temp_min"] as? Double,
                       let maxTemperature1 = main1["temp_max"] as? Double {
                        DispatchQueue.main.async {
                            let Text = "\nDestination Location: \(minTemperature1) °C - \(maxTemperature1) °C"
                            self.range.text! += Text
                            self.temp1 = main1["temp"] as? Float
                        }
                    }
                } catch {
                    print("JSON parsing error: \(error.localizedDescription)")
                }
            }
        }
        
        task1.resume()
    }
    
}

extension UITextField{
    
    func LeftImage(imageViewNamed: String){
        let imageview = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageview.image = UIImage(systemName: imageViewNamed)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        imageViewContainerView.addSubview(imageview)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
    
}



