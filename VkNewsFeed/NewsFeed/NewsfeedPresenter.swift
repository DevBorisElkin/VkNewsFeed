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
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = NewsfeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response{
            
        case .presentNewsfeed(feed: let feed):
            
            let cells = feed.items.map { feedItem in
                cellViewModel(feedItem: feedItem, profiles: feed.profiles, groups: feed.groups)
            }
            
            let feedViewModel = FeedViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
        }
        
    }
    
    private func cellViewModel(feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell{
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachement = self.photoAttachement(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachement: photoAttachement)
        
        return FeedViewModel.Cell.init(
            iconUrlString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0),
            photoAttachement: photoAttachement,
            sizes: sizes
        )
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable{
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
    private func photoAttachement(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachement? {
        // compact map runs through data and if it finds that data, it passes it into photos array
        guard let photos = feedItem.attachments?.compactMap({ attachement in
            attachement.photo
        }), let firstPhoto = photos.first else{
            //print("Error 227")
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachement.init(
            photoUrlString: firstPhoto.srcBIG,
            width: firstPhoto.width,
            height:firstPhoto.height
        )
    }
}
