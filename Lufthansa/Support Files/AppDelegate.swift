import UIKit
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var dataService: DataService = APIService()
    private let clientSecretKey = "client_secret"
    private let clientSecretValue = "2MtCqPHtWj"
    private let clientIdKey = "client_id"
    private let clientIdValue = "ahe5wpv7w3w74kdukvqgu97p"
    private let tokenKey = "token"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if KeychainWrapper.standard.string(forKey: clientSecretKey) == nil {
            KeychainWrapper.standard.set(clientSecretValue, forKey: clientSecretKey)
        }
        
        if KeychainWrapper.standard.string(forKey: clientIdKey) == nil {
            KeychainWrapper.standard.set(clientIdValue, forKey: clientIdKey)
        }
        
        dataService.getToken(onSuccess: { (token) in
            KeychainWrapper.standard.set(token?.token ?? "", forKey: self.tokenKey)
        }) { (error) in
            
        }
        
        
       return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

