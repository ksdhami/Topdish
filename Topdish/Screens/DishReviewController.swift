//
//  DishReviewController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-08.
//  Copyright © 2019 Topdish Inc. All rights reserved.

import Foundation
import UIKit

struct dishrev {
    var id:Int
    var title:String
    var rate: String
}


class DishReviewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate{
    
        

        //variables
        var reviewHolder:[DishReview] = []
        var dishHolder:[String]=[]
        var rateHolder:[Int]=[]
    
        var nameofDish:String = ""
        var rate:Int = -1
        var exp:String = ""
    
        //Modal View Buttons
        @IBOutlet weak var dishName: UITextField!
        @IBOutlet weak var dishRate: UITextField!
        @IBOutlet weak var dishexp: UITextView!
        @IBOutlet weak var dishupload: UIButton!
        @IBOutlet weak var dishpic: UIImageView!
        @IBOutlet weak var adddish: UIButton!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        dishexp.delegate = self
        dishexp.textColor = .lightGray
        dishexp.text = "Tell us about your experience..."
        dishRate.delegate = self
    }
    
    
    @IBAction func nameentered(_ sender: UITextField) {
        dishName.resignFirstResponder()
        nameofDish = dishName.text!
        return
    }
    
    @IBAction func receivedishrate(_ sender: Any) {
        dishRate.resignFirstResponder()
        rate = Int(dishRate.text!)!
        //print(rate)
        return
    }

    
    @IBAction func uploaddish(_ sender: Any) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated:true, completion: nil)
        
        
    }
    
    func textViewDidBeginEditing(_ dishexp: UITextView) {
           if dishexp.textColor == UIColor.lightGray {
               dishexp.text = nil
               dishexp.textColor = UIColor.black
           }
       }
       
       func textViewDidEndEditing(_ dishexp: UITextView) {
           if dishexp.text.isEmpty {
               dishexp.text = "Tell us about your experience..."
               dishexp.textColor = UIColor.lightGray
           }else{
               print(dishexp.text as! String)
           }
       }
       
    func textField(_ textField:UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:String) -> Bool {
        return string == string.filter("0123456789".contains)
    }
    
    //Cancels changes
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           //This is when no image is picked and user pressed cancel
           dismiss(animated: true, completion: nil)
       }
    
    //Opens photo gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Here save picture, and change it as well - Save onto DB here
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                      dishpic.contentMode = .scaleAspectFit
                      dishpic.image = pickedImage
                  }
        dismiss(animated: true, completion: nil)
        
        self.dishupload.isEnabled = false
        //disabled new upload lol
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("gjkfhgjh")
        print("rate: ", rate, "\n\n\n")
        if segue.identifier == "backtoreview"{
            let dest = segue.destination as! ReviewController
            let dishAdded = DishReview(name: nameofDish, rating: rate)
            reviewHolder.append(dishAdded)
            dest.reviewHold = reviewHolder
        }
       }
    
    @IBAction func donefunc(_ sender: UIButton) {
       performSegue(withIdentifier: "backtoreview" ,sender: Any?.self)

    }
    
    
}