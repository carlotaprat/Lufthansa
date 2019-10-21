import Foundation
import UIKit

class AlertHelper {
    
    static var app: AlertHelper = {
        return AlertHelper()
    }()
    
    func showAlert(error: LufthansaError, vc: UIViewController) {
        
        var title = ""
        var message = ""
        
        switch error {
        case .internalError:
            title = "internal_error_title".localized
            message = "internal_error_description".localized
            
        case .serviceError:
            title = "service_error_title".localized
            message = "service_error_description".localized
            
        default:
            title = "general_error_title".localized
            message = "general_error_description".localized
        }
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.view.tintColor = UIColor.BlueLufthansa
        alertController.addAction(UIAlertAction(title: "ok_dialog".localized,
                                                style: .cancel,
                                                handler: nil))
        if LufthansaError.serviceError == error, let delegate = vc as? ServiceAlertProtocol  {
            let retryAction = UIAlertAction(title: "retry_dialog".localized,
                                       style: .default) { (action) in
                                        delegate.reload()
            }
            alertController.addAction(retryAction)
        }
        vc.present(alertController, animated: true, completion: nil)
        
    }
}
