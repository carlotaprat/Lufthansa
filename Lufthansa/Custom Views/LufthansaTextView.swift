import Foundation
import UIKit

class LufthansaTextField: UITextField {
    
     override init(frame: CGRect) {
         super.init(frame: frame)
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
        self.borderRect(forBounds: CGRect(x: 0, y: self.frame.maxY, width: self.frame.width, height: 1.0))
        self.layer.borderWidth = 1.0
     }
}
