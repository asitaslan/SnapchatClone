//
//  snapVC.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 13.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import ImageSlideshow

class snapVC: UIViewController {

    @IBOutlet weak var timeLbl: UILabel!
    
    var selectedSnap : Snap?
    

        
    var inputArray = [KingfisherSource]()
        
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if let snap =  selectedSnap {
            
            timeLbl.text = "Time Lift: \(snap.timeDifferance)"
            
            for imageUrl in snap.imageUrlArray{
                inputArray.append(KingfisherSource(urlString: imageUrl)!)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.90))
            imageSlideShow.backgroundColor = UIColor.white
            
            let pageIndigator = UIPageControl()
            pageIndigator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndigator.pageIndicatorTintColor = UIColor.black
            imageSlideShow.pageIndicator = pageIndigator
            
            
            
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLbl)
        }
        
        
    }
    

 

}
