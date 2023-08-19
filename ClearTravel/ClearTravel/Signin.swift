//
//  Signin.swift
//  ClearTravel
//

//

import UIKit
import CoreData

class Signin: UIViewController {
    
    @IBOutlet var emailid: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var pview: UIButton!
    @IBOutlet var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        //Icons for text fields
        emailid.setUpLeftSideImage(imageViewNamed: "envelope.fill")
        password.setUpLeftSideImage(imageViewNamed: "lock.fill")
        
        
        //Placeholder
        emailid.attributedPlaceholder = NSAttributedString(string: "Email-id", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        
        //Password visbility
        let image = UIImage(systemName: "eye")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 13))
        let imageSlash = UIImage(systemName: "eye.slash")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 13))
        
        pview.setImage(image, for: .normal)
        pview.setImage(imageSlash, for: .selected)
        pview.layer.cornerRadius = 5
        
    }
    
    //Password visbility
    @IBAction func onClick(){
        password.isSecureTextEntry.toggle()
        pview.isSelected = !pview.isSelected
    }
    
    
    // Keyboard hidding
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailid.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    // when return key presed in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func verifyButtonClicked(){
        guard let enteredEmail = emailid.text, !enteredEmail.isEmpty else {
            // Handle empty email
            return
        }
        
        guard let enteredPassword = password.text, !enteredPassword.isEmpty else {
            // Handle empty password
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        fetchRequest.predicate = NSPredicate(format: "email = %@", enteredEmail)
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            if let user = results.first, let storedPassword = user.value(forKey: "pass") as? String {
                if enteredPassword == storedPassword {
                    // Verification successful, perform desired action
                    // Enable the button or perform any other logic
                    
                    // For example, enable the button:
                    self.performSegue(withIdentifier: "Signin", sender: self)
                } else {
                    // Incorrect password, display a warning
                    warning.text = "Incorrect password."
                }
            } else {
                // User not found, display a warning
                warning.text = "User not found."
            }
        } catch {
            // Handle error fetching from Core Data
        }
    }
    
}
    
extension UITextField{
    
    func setUpLeftSideImage(imageViewNamed: String){
        let imageview = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageview.image = UIImage(systemName: imageViewNamed)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewContainerView.addSubview(imageview)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
    
}
