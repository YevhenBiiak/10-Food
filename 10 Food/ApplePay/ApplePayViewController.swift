//
//  ApplePayViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 28.01.2023.
//

import UIKit

class ApplePayViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.animationImages = loadImages()
        imageView.animationRepeatCount = 1
        imageView.animationDuration = 2.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
            self.dismiss(animated: true)
        }
    }
    
    private func loadImages() -> [UIImage]? {
        guard let path = Bundle.main.path(forResource: "faceId", ofType: "gif"),
              let gifData = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let source = CGImageSourceCreateWithData(gifData as CFData, nil)
        else { return nil }
        
        var images = [UIImage]()
        
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        return images
    }
}
