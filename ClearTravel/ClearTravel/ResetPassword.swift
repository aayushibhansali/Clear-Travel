//
//  ResetPassword.swift
//  ClearTravel
//

//

import UIKit

class ResetPassword: UIViewController {

    @IBOutlet var password: UITextField!
    @IBOutlet var cpassword: UITextField!
    @IBOutlet var pview: UIButton!
    @IBOutlet var cpview: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.LeftSideImage(imageViewNamed: "lock.fill")
        cpassword.LeftSideImage(imageViewNamed: "lock.fill")

        
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
    
    //Password visbility
    @IBAction func onpClick(){
        password.isSecureTextEntry.toggle()
        pview.isSelected = !pview.isSelected
    }
    
    @IBAction func oncpClick(){
        cpassword.isSecureTextEntry.toggle()
        cpview.isSelected = !cpview.isSelected
    }
    
    @IBAction func reset() {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    // Keyboard hidding
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    
    func LeftSideImage(imageViewNamed: String){
        let imageview = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageview.image = UIImage(systemName: imageViewNamed)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewContainerView.addSubview(imageview)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
}

