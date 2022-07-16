//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by test on 16.07.2022.
//

import Foundation
import VKSdkFramework

class AuthService : NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "8220334"
    private let vkSkd: VKSdk
    
    override init(){
        vkSkd = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSDK.initialize()")
        vkSkd.register(self)
        vkSkd.uiDelegate = self
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
