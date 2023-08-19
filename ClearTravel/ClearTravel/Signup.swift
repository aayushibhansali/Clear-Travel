//
//  Signup.swift
//  ClearTravel
//


import UIKit
import CoreData

class Signup: UIViewController{
    
    @IBOutlet var username: UITextField!
    @IBOutlet var phonenumber: UITextField!
    @IBOutlet var emailid: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var cpassword: UITextField!
    @IBOutlet var pview: UIButton!
    @IBOutlet var cpview: UIButton!
    @IBOutlet var warning: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.setupLeftSideImage(imageViewNamed: "person.fill")
        phonenumber.setupLeftSideImage(imageViewNamed: "phone.fill")
        emailid.setupLeftSideImage(imageViewNamed: "envelope.fill")
        password.setupLeftSideImage(imageViewNamed: "lock.fill")
        cpassword.setupLeftSideImage(imageViewNamed: "lock.fill")

        
        username.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        phonenumber.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailid.attributedPlaceholder = NSAttributedString(string: "Email-id", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cpassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        
        //Password visbility
        let image = UIImage(systemName: "eye")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 13))
        let imageSlash = UIImage(systemName: "eye.slash")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 13))

        pview.setImage(image, for: .normal)
        pview.setImage(imageSlash, for: .selected)
        pview.layer.cornerRadius = 5
        
        cpview.setImage(image, for: .normal)
        cpview.setImage(imageSlash, for: .selected)
        cpview.layer.cornerRadius = 5
        
    }
    
    @IBAction func saveButtonClick() {
        let context = appDelegate.persistentContainer.viewContext
        
        guard let passwordValue = password.text, !passwordValue.isEmpty else {
            // Handle empty password
            return
        }
        
        guard let confirmPasswordValue = cpassword.text, !confirmPasswordValue.isEmpty else {
            // Handle empty confirm password
            return
        }
        
        if passwordValue != confirmPasswordValue {
            // Passwords do not match, display a warning
            warning.text = "Passwords do not match."
            return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(username.text, forKey: "name")
        newUser.setValue(phonenumber.text, forKey: "phno")
        newUser.setValue(emailid.text, forKey: "email")
        newUser.setValue(passwordValue, forKey: "pass")
        
        do {
            if username.text != "", phonenumber.text != "", emailid.text != "", password.text != "", confirmPasswordValue != "" {
                self.performSegue(withIdentifier: "Signup", sender: self)
            }
            
            try context.save()
            username.text = ""
            phonenumber.text = ""
            emailid.text = ""
            password.text = ""
            cpassword.text = ""
            warning.text = "" // Reset the warning label
            
        } catch {
            // Handle error saving to Core Data
        }
        
    }
    
    //Password visbility
    @IBAction func onpClick(){
        password.isSecureTextEntry.toggle()
        pview.isSelected = !pview.isSelected
    }
    
    @IBAction func oncpClick(){
        cpassword.isSecureTextEntry.toggle()
        cpview.isSelected = !cpview.isSelected
    }
    
    // Keyboard hidding
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
        phonenumber.resignFirstResponder()
        emailid.resignFirstResponder()
        password.resignFirstResponder()
        cpassword.resignFirstResponder()
    }
    
    // when return key presed in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension UITextField{
    
    func setupLeftSideImage(imageViewNamed: String){
        let imageview = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageview.image = UIImage(systemName: imageViewNamed)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewContainerView.addSubview(imageview)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
}
