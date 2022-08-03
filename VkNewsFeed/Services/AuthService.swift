//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by test on 16.07.2022.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate : class{
    func authSerciceShouldShow(viewController: UIViewController)
    func authSerciceSignIn()
    func authSerciceSignInDidFailed()
}

class AuthService : NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "8220334"
    private let vkSkd: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String?{
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken().userId
    }
    
    override init(){
        vkSkd = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSDK.initialize()")
        vkSkd.register(self)
        vkSkd.uiDelegate = self
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil{
            delegate?.authSerciceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authSerciceSignInDidFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authSerciceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
    //
    
    // https://stackoverflow.com/questions/56833726/authorization-vk-api-error-uerrorinvalid-request-error-descriptionse ???
    func wakeUpSession(){
        let scopes = ["offline, wall, friends"] // let scopes = ["offline, groups, friends"]
        VKSdk.wakeUpSession(scopes) { [delegate] (state, error) in
            switch state{
            
            case .initialized:
                print("initialized")
                VKSdk.authorize(scopes)
            case .authorized:
                print("authorized")
                delegate?.authSerciceSignIn()
            default:
                print("fatal error: \(state)")
                delegate?.authSerciceSignInDidFailed()
                //fatalError(error!.localizedDescription)
            }
        }
    }
}
