//
//  UploadImageController.swift
//  ImageUploader
//
//  Created by Everett Tsang on 10/3/20.
//

import UIKit
import AWSS3
import Amplify
import AmplifyPlugins


class UploadImageController: UIViewController{
    @IBOutlet var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    var localPath: URL!
    //var resultSink: AnyCancellable?
    //var progressSink: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    @IBAction func pickImage(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func uploadPicture(){
        let img = imageView.image
        let data = img?.pngData()
        let remote = "test.png"
        let file = NSTemporaryDirectory() + remote
        let fileURL = URL(fileURLWithPath: file)
        do{
            try data?.write(to: fileURL)
            localPath = fileURL
            Amplify.Storage.uploadFile(key: "hello.png", local: localPath, resultListener: { (event) in
                switch event {
                case .success(let data):
                    print("Completed: \(data)")
                case .failure(let storageError):
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        })
            
        }
        catch {
            print("File save fail")
        }
     
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = (info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage){
            imageView.image = image
        }
        dismiss(animated:true, completion: nil)
        
    }


}
extension UploadImageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
       
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
