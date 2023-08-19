//
//  Weather.swift
//  ClearTravel
//

//

import UIKit
import CoreLocation

class Weather: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var name: UISearchBar!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var windspeed: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var feelslike: UILabel!
    @IBOutlet var temp_max: UILabel!
    @IBOutlet var temp_min: UILabel!
    
    @IBOutlet var stack1: UIStackView!
    @IBOutlet var stack2: UIStackView!
    @IBOutlet var stack3: UIStackView!
    @IBOutlet var stack4: UIStackView!
    @IBOutlet var stack5: UIStackView!
    @IBOutlet var stack6: UIStackView!
    
    var placeName: String?
    var latitude: Double?
    var longitude: Double?
    var temp: String?
    var address: String?
    
    var layer1: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layer1 = stack1.layer
        layer1.cornerRadius = 15
        
        layer1 = stack2.layer
        layer1.cornerRadius = 15
        
        layer1 = stack3.layer
        layer1.cornerRadius = 15
        
        layer1 = stack4.layer
        layer1.cornerRadius = 15
        
        layer1 = stack5.layer
        layer1.cornerRadius = 15
        
        layer1 = stack6.layer
        layer1.cornerRadius = 15
        
        //Searchbar delegate
        name.delegate = self
    }
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTemperature()
    }
    
    func searchTemperature(){
        
        guard ((name.text!.count) > 0) else {
            
            let alert = UIAlertController(title: "No city entered!", message: "Please enter valid city.", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
            
            return
        }
        
        let session1 = URLSession.shared
        
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name.text!)?&APPID=f31356634fbc4c64c86edd02aaf817c2&units=metric")!
        
        print("weatherURL: \(weatherURL)")
        
        let task1 = session1.dataTask(with: weatherURL){
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error1 = error{
                print("error: \(error1.localizedDescription)")
            }
            else{
                if let data1 = data{
                    // server sends data in the form of bytes
                    
                    // converting to  string
                    
                    let dataString = String(data: data1, encoding: String.Encoding.utf8)!
                    
                    print("weatherData: \(dataString)")
                    
                    // json parsing
                    
                    if  let firstDictionary = try? JSONSerialization.jsonObject(with: data1, options: .allowFragments) as? NSDictionary {
                        print("first Dictionary values: \(firstDictionary)")
                        
                        if let coordinate = firstDictionary.value(forKey: "coord") as? NSDictionary{
                            
                            if let lat = coordinate.value(forKey: "lat"){
                                self.latitude = lat as? Double
                                
                                DispatchQueue.main.async {
                                    print("latitude:  \(lat)")
                                }
                            }
                            
                            if let lon = coordinate.value(forKey: "lon"){
                                self.longitude = lon as? Double
                                
                                DispatchQueue.main.async {
                                    print("longitude:  \(lon)")
                                }
                            }
                            
                            let currentCoordinates = CLLocation(latitude: self.latitude!, longitude: self.longitude!)
                                
                                CLGeocoder().reverseGeocodeLocation(currentCoordinates, completionHandler: { placemarks, error in
                                    
                                    if let placemark1 = (placemarks?[0]) {
                                        
                                        let name = placemark1.name!
                                        let country = placemark1.country!
                                        let administration = placemark1.administrativeArea!
                                        let locality = placemark1.locality!
                                        let postsalCode = placemark1.postalCode!
                                        
                                        print(name,country,administration,locality,postsalCode, separator: ",")
                                        
                                    }
                                    
                                })
                            
                            
                        }
                        
                        
                        if let secondDictionary = firstDictionary.value(forKey: "main") as? NSDictionary {
                            print("Second Dictionary values: \(secondDictionary)")
                            
                            //to diplay temprature
                            
                            if let tempValue = secondDictionary.value(forKey: "temp"){
                                self.temp = "\(tempValue)"
                                
                                DispatchQueue.main.async {
                                    self.temperature.text = "\(tempValue) ˚C"
                                }
                            }
                            
                            if let humidity = secondDictionary.value(forKey: "humidity"){
                                
                                DispatchQueue.main.async {
                                    print("humidity: \(humidity) %")
                                    self.humidity.text = "\(humidity) %"
                                }
                            }
                            
                            if let pressure = secondDictionary.value(forKey: "pressure"){
                                
                                DispatchQueue.main.async {
                                    print("pressure: \(pressure) hPa")
                                    self.pressure.text = "\(pressure) hPa"
                                }
                            }
                            
                            if let feels = secondDictionary.value(forKey: "feels_like"){
                                
                                DispatchQueue.main.async {
                                    print("feels_like: \(feels) ˚C")
                                    self.feelslike.text = "\(feels) ˚C"
                                }
                            }
                            
                            if let mint = secondDictionary.value(forKey: "temp_min"){
                                
                                DispatchQueue.main.async {
                                    print("Minimum Temperature: \(mint) ˚C")
                                    self.temp_min.text = "\(mint) ˚C"
                                }
                            }
                            
                            if let maxt = secondDictionary.value(forKey: "temp_max"){
                                
                                DispatchQueue.main.async {
                                    print("Maximum Temperature: \(maxt) ˚C")
                                    self.temp_max.text = "\(maxt) ˚C"
                                }
                            }
                            
                        }
                        
                        if let windInfo = firstDictionary.value(forKey: "wind") as? NSDictionary{
                            if let windSpeed = windInfo.value(forKey: "speed"){
                                
                                DispatchQueue.main.async {
                                    print("windspeed: \(windSpeed) kph")
                                    self.windspeed.text = "\(windSpeed) kph"
                                }
                            }
                        }
                        
                        
                        if let weatherInfo = firstDictionary.value(forKey: "weather") as? NSArray{
                            let firstWeatherObject = weatherInfo[0] as? NSDictionary
                            if let desc = firstWeatherObject!.value(forKey: "description"){
                                
                                DispatchQueue.main.async {
                                    print("description: \(desc)")
                                    self.desc.text = "\(desc)"
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        
        task1.resume()
    }
}




    
    
    

    
