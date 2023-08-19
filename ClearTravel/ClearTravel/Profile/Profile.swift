import UIKit
import CoreData

class Profile: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tv: UITableView!
    var DataArray: [String] = []
    var ImageArray: [String] = []
    @IBOutlet var iv1: UIImageView!
    var layer1: CALayer!
    @IBOutlet var name: UILabel!
    @IBOutlet var phonenumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To hide back button in tab bar controller
        //navigationController?.isNavigationBarHidden = true
        
        layer1 = iv1.layer
        layer1.cornerRadius = iv1.frame.height/2
        
        DataArray = ["     Account", "     Ticket Booking History", "     Log Out"]
        ImageArray = ["person", "clock.arrow.circlepath", "power"]
        
        tv.delegate = self
        tv.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
        cell.textLabel?.text = DataArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.font = boldFont
        
        let imageName = ImageArray[indexPath.row]
        let icon = UIImage(systemName: imageName)
        let iconView = UIImageView(image: icon)
        iconView.frame = CGRect(x: 10, y: 15, width: 20, height: 20)
        cell.contentView.addSubview(iconView)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let segueIdentifier: String
        
        switch indexPath.row {
        case 0:
            segueIdentifier = "Account"
        case 1:
            segueIdentifier = "TicketBookingHistory"
        case 2:
            segueIdentifier = "LogOut"
        default:
            return
        }
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
}
