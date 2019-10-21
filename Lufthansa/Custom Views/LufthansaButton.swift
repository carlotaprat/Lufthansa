import Foundation
import UIKit

class LufthansaButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    func setupSearch() {
        if self.isEnabled {
            self.backgroundColor = UIColor.YellowLufthansa
            self.tintColor = UIColor.BlueLufthansa
        } else {
            self.backgroundColor = UIColor.lightGray
            self.tintColor = UIColor.darkGray
        }
    }
    
}
