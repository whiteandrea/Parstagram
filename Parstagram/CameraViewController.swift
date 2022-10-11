//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Andrea White on 10/10/22.
//

import UIKit
import AlamofireImage
import Parse


class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
   
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true)
        
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        {
            let image = info[.editedImage] as! UIImage
            
            let size = CGSize(width: 300, height: 300)
            let scaledImage = image.af_imageScaled(to: size)
            
            imageView.image = scaledImage
            dismiss(animated: true)
            
        }
        
    
    @IBAction func submitButton(_ sender: Any) {
        let posts = PFObject(className: "Posts")
        
        posts["caption"] = commentField.text!
        posts["author"] = PFUser.current()!
       
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        posts["image"] = file
        
        posts.saveInBackground{(success, error) in
            if success {
                print("saved!")
                self.dismiss(animated: true)
            }
            else{
                print("error!")
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
