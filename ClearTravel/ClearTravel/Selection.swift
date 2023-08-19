//
//  Selection.swift
//  ClearTravel
//

//

import UIKit

class Selection: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var select: UISegmentedControl!
    @IBOutlet var option: UITableView!
    @IBOutlet var iv1: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var link: UILabel!
    @IBOutlet var nextButton: UIButton!

    // Flight Details
    let flightNames = ["SpiceJet", "IndiGo", "Air India"]
    let flightUrls = ["https://www.spicejet.com", "https://www.goindigo.in", "https://www.airindia.in"]
    let flightLogo = ["SpiceJet", "IndiGo", "AirIndia"]

    // Train Details
    let trainNames = ["IRCTC", "Indian Railways"]
    let trainUrls = ["https://www.irctc.co.in/nget/train-search", "https://www.indianrail.gov.in/enquiry/SEAT/SeatAvailability.html"]
    let trainLogo = ["IRCTC", "Indian Railways"]

    // Bus Details
    let busNames = ["redBus", "AbhiBus"]
    let busUrls = ["https://www.redbus.in", "https://www.abhibus.com/"]
    let busLogo = ["RedBus", "Abhibus"]

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let alert = UIAlertController(title: "Suggestion", message: "For the weather condition, flight is more suitable", preferredStyle: .alert)

        // Add actions to the alert (optional)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in }
        alert.addAction(okAction)

        // Present the alert
        present(alert, animated: true, completion: nil)

        option.delegate = self
        option.dataSource = self
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = select.selectedSegmentIndex
        switch selectedIndex {
            
        case 0: // Flights
            return flightNames.count
            
        case 1: // Trains
            return trainNames.count
            
        case 2: // Buses
            return busNames.count
        
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selectedIndex = select.selectedSegmentIndex
        switch selectedIndex {
            
        case 0: // Flights
            cell.textLabel?.text = flightNames[indexPath.row]
            
        case 1: // Trains
            cell.textLabel?.text = trainNames[indexPath.row]
        
        case 2: // Buses
            cell.textLabel?.text = busNames[indexPath.row]
         
        default:
            break
        }

        cell.accessoryType = .disclosureIndicator
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.font = boldFont

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedIndex = select.selectedSegmentIndex
        switch selectedIndex {
        case 0: // Flights
            iv1.image = UIImage(named: flightLogo[indexPath.row])
            name.text = flightNames[indexPath.row]
            link.text = flightUrls[indexPath.row]
            nextButton.isHidden = false
            
        case 1: // Trains
            iv1.image = UIImage(named: trainLogo[indexPath.row])
            name.text = trainNames[indexPath.row]
            link.text = trainUrls[indexPath.row]
            nextButton.isHidden = false
            
        case 2: // Buses
            iv1.image = UIImage(named: busLogo[indexPath.row])
            name.text = busNames[indexPath.row]
            link.text = busUrls[indexPath.row]
            nextButton.isHidden = false
         
        default:
           break
        }
    }
    
    @IBAction func segmentedControlValueChanged() {
            // Reload the table view data
            option.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let thirdScreen = segue.destination as! Webview
        thirdScreen.titleString = name.text
        thirdScreen.urlString = link.text
        
    }

}
