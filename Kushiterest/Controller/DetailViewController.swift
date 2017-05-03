//
//  DetailViewController.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    
    var imageToPresent: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: ImageDistinationTransitionType {}
