//
//  ForgotPassword.swift
//  ClearTravel
//

//

import UIKit

class ForgotPassword: UIViewController {
    
    @IBOutlet var emailid: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailid.SetLeftSideImage(imageViewNamed: "envelope.fill")
        
    }

    
    // Keyboard hidding
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailid.resignFirstResponder()
    }
    
    // when return key presed in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension UITextField{
    
    func SetLeftSideImage(imageViewNamed: String){
        let imageview = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageview.image = UIImage(systemName: imageViewNamed)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewContainerView.addSubview(imageview)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
}
