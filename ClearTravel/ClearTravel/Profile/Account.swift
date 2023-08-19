//
//  Account.swift
//  ClearTravel
//
//

import UIKit

class Account: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var done: UIButton!
    @IBOutlet var iv1: UIImageView!
    @IBOutlet var photo: UIButton!
    var photoLibraryImagePicker1: UIImagePickerController!
    var cameraImagePicker2: UIImagePickerController!
    
    var layer1: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layer1 = iv1.layer
        layer1.cornerRadius = iv1.frame.height/2

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(changeDetails))
        
    }
                                                                 
     @objc func changeDetails(){
        photo.isHidden = false
        name.isUserInteractionEnabled = true
        phone.isUserInteractionEnabled = true
        email.isUserInteractionEnabled = true
        done.isHidden = false
        done.addTarget(self, action: #selector(savedetails), for: .touchUpInside)
    }
    
    @objc func savedetails(){
        photo.isHidden = true
        done.isHidden = true
        name.isUserInteractionEnabled = false
        phone.isUserInteractionEnabled = false
        email.isUserInteractionEnabled = false
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        let menu = UIMenu(children: [
            UIAction(title: "Camera") { _ in
                self.conClick()
            },
            UIAction(title: "Photo Library") { _ in
                self.ponClick()
            }
        ])
        
        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true

    }
    
    @objc func ponClick() {
        photoLibraryImagePicker1 = UIImagePickerController()
        photoLibraryImagePicker1.sourceType = .photoLibrary
        photoLibraryImagePicker1.allowsEditing = true
        photoLibraryImagePicker1.delegate = self
        self.present(photoLibraryImagePicker1, animated: true)
    }
    
    @objc func conClick(){
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            cameraImagePicker2 = UIImagePickerController()
            cameraImagePicker2.delegate = self
            cameraImagePicker2.sourceType = .camera
            cameraImagePicker2.cameraDevice = .rear
            cameraImagePicker2.allowsEditing = true
            self.present(cameraImagePicker2, animated: true)
        }
        else{
            print("Camera not found in simulator")
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker == photoLibraryImagePicker1{
            print("Selected Image Details: \(info)")
            let image1 = info[.editedImage] as! UIImage
            iv1.image = image1
            self.dismiss(animated: true, completion: nil)
        }
        else{
            //camera
            print("\(info)")
            let image2 = info[.editedImage] as! UIImage
            iv1.image = image2
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if picker == photoLibraryImagePicker1{
            self.dismiss(animated: true)
        }
        else{
            self.dismiss(animated: true)
        }
    }



}
     
