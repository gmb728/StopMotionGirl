//
//  ViewController.swift
//  StopMotionGirl
//
//  Created by Chang Sophia on 4/17/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var ratio = "1:1"
 
    
    @IBOutlet weak var mySlilder: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myRotate: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mySize: UIButton!
    @IBOutlet weak var myFilter: UISlider!
    @IBOutlet weak var myReverse: UIButton!
    @IBOutlet weak var filterLabel: UILabel!
    
    
    let images = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!]
    
   let reverseImages = [UIImage(named: "10")!, UIImage(named: "9")!, UIImage(named: "8")!, UIImage(named: "7")!, UIImage(named: "6")!, UIImage(named: "5")!, UIImage(named: "4")!, UIImage(named: "3")!, UIImage(named: "2")!, UIImage(named: "1")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySize.clipsToBounds = true
        mySize.layer.cornerRadius = 25
        view.layer.masksToBounds = false
       imageView.layer.shadowOffset = CGSize(width:-10,height:10)
       imageView.layer.shadowColor = UIColor.darkGray.cgColor
       imageView.layer.shadowOpacity = 0.8
    }
    
   
    @IBAction func mySliderAction(_ sender: Any) {
        
        let animatedImage = UIImage.animatedImage(with: images, duration: TimeInterval(CGFloat(mySlilder.value)))
        imageView.image = animatedImage
        
        timeLabel.text = String(format:"%.2f", mySlilder.value)
    }
    
    
  
    
    
    @IBAction func myFilterAction(_ sender: UISlider) {
        
        var images = [UIImage]()
        for number in 1...10 {
            let image = UIImage(named: String(number))!
            
            let ciImage = CIImage(image: image)
         
            let filter = CIFilter(name: "CIColorMonochrome")
         
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
            filter?.setValue(sender.value, forKey: kCIInputIntensityKey)
           
            filter?.setValue(CIColor(red: 1, green: 0, blue: 0, alpha: 0.5), forKey: kCIInputColorKey)
            if let outputImage = filter?.outputImage, let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent){
                let image = UIImage(cgImage: cgImage)
                images.append(image)
                
            }
        }
        let animatedImage = UIImage.animatedImage(with: images, duration: 1)
        imageView.image = animatedImage
         filterLabel.text = String(format:"%.2f", myFilter.value)
    }
    @IBAction func myReverseAction(_ sender: UIButton) {
        if sender.currentTitle == "Right" {
            let animatedImage = UIImage.animatedImage(with: reverseImages, duration: TimeInterval(CGFloat(mySlilder.value)))
            imageView.image = animatedImage
             sender.setTitle("Left", for: .normal)
            
            
        } else if sender.currentTitle == "Left" {
            let animatedImage = UIImage.animatedImage(with: images, duration: TimeInterval(CGFloat(mySlilder.value)))
            imageView.image = animatedImage

             sender.setTitle("Right", for: .normal)
        }
        
    }
    
    var fullScreenSize: CGSize!
    
    @IBAction func mySizeButtonAction(_ sender: UIButton) {
        
        fullScreenSize = UIScreen.main.bounds.size
        
        let width: CGFloat = fullScreenSize.width-20
        var height: CGFloat = 0
        
        if sender.currentTitle == "1:1" {
            ratio = "3:4"
            height = width / 3 * 4
            
        }
        else if sender.currentTitle == "3:4" {
            ratio = "16:9"
            height = width / 16 * 9
            
        }
        else {
            ratio = "1:1"
            height = fullScreenSize.width
            
        }
        
        sender.setTitle(ratio, for: UIControl.State.normal)
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height)
    }
   
    @IBAction func myRotateButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            if sender.currentTitle == "Rotate" {
           self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
         sender.setTitle("Recover", for: .normal)
            } else if sender.currentTitle == "Recover" {
         self.imageView.transform = .identity
             sender.setTitle("Rotate", for: .normal)
           
                        }
      
}
    

    )

}
}
