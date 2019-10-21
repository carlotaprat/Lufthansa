import Foundation
import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private let firstDuration = 1.5
    private let firstDelay = 0.0
    private let alphaLogo = CGFloat(1.0)
    private let firstScale = CGFloat(2.0)
    private let secondDuration = 0.75
    private let secondDelay = 0.0
    private let secondScale = CGFloat(1.8)
    private let segueName = "initialSegue"
    
     override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UIView.animate(withDuration: firstDuration, delay: firstDelay, options: .curveEaseIn, animations: {
            self.imageView.alpha = self.alphaLogo
            self.imageView.transform = CGAffineTransform.init(scaleX: self.firstScale, y: self.firstScale)
        }, completion: { (true) in
            UIView.animate(withDuration: self.secondDuration, delay: self.secondDelay, options: .curveEaseOut, animations: {
                self.imageView.transform = CGAffineTransform.init(scaleX: self.secondScale, y: self.secondScale)
            }, completion: { (true) in
                self.performSegue(withIdentifier: self.segueName, sender: self)
            })
        })
     }
}
