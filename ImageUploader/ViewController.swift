//
//  ViewController.swift
//  ImageUploader
//
//  Created by Everett Tsang on 10/3/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func tapButton(){
        guard let vc = storyboard?.instantiateViewController(identifier: "upload_view")as? UploadImageController
        else{
            return
        }
        present(vc, animated:true)
    }
}

