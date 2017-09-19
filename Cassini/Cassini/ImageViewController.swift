//
//  ImageViewController.swift
//  Cassini
//
//  Created by Gyurme on 19/09/17.
//  Copyright © 2017 Gyurme. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
  
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 2.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    var imageURL: URL? {
        didSet {
            image = nil
            if(view.window != nil) {
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            let urlContents =  try? Data(contentsOf: url)
            if let imageContents = urlContents {
                image = UIImage(data: imageContents)
            }
        }
    }
    
    fileprivate var imageView = UIImageView()
    
    private var image:UIImage? {
        get {
            return imageView.image
        }
        
        set {
            imageView.image = newValue;
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = DemoURL.stanford
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(image == nil) {
            fetchImage()
        }
    }
}

extension ImageViewController:UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
