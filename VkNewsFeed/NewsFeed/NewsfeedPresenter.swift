//
//  NewsfeedPresenter.swift
//  VkNewsFeed
//
//  Created by test on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
      switch response{
          
      case .some:
          print("Presenter: .some")
      case .presentNewsfeed:
          print("Presenter: .presentNewsfeed")
          viewController?.displayData(viewModel: .displayNewsfeed)
      }
  }
  
}
