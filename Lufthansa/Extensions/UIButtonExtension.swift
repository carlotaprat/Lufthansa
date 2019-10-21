import Foundation
import UIKit

extension UIButton {
    
    func setupWithAirport(airport: Airport) {
        self.setTitle(airport.getNameFormatted(), for: .normal)
        self.setTitleColor(UIColor.BlueLufthansa, for: .normal)
    }
    
    
}
