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
            
        case .presentNewsfeed(feed: let feed, let revealPostIds):
            
            let cells = feed.items.map { feedItem in
                cellViewModel(feedItem: feedItem, profiles: feed.profiles, groups: feed.groups, revealPostIds: revealPostIds)
            }
            
            let feedViewModel = FeedViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
        case .presentUserInfo(userResponse: let userResponse):
            let userViewModel = UserViewModel.init(photoUrlString: userResponse?.photo100)
            viewController?.displayData(viewModel: .displayUser(userViewModel: userViewModel))
        }
        
    }
    
    private func cellViewModel(feedItem: FeedItem, profiles: [Profile], groups: [Group], revealPostIds: [Int]) -> FeedViewModel.Cell{
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachements = self.photoAttachements(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealPostIds.contains { (postId) in
            return postId == feedItem.postId
        }
        //let isFullSized2 = revealPostIds.contains(feedItem.postId)
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachements: photoAttachements, isFullSizedPost: isFullSized)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        return FeedViewModel.Cell.init(
            postId: feedItem.postId,
            iconUrlString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: postText,
            likes: feedItem.likes?.count.roundedWithAbbreviationsKM ?? "0",
            comments: feedItem.comments?.count.roundedWithAbbreviationsKM ?? "0",
            shares: feedItem.reposts?.count.roundedWithAbbreviationsKM ?? "0",
            views: feedItem.views?.count.roundedWithAbbreviationsKM ?? "0",
            photoAttachements: photoAttachements,
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
    
    private func photoAttachements(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachement] {
        // compact map runs through data and if it finds that data, it passes it into photos array
        guard let attachements = feedItem.attachments else { return [] }
        
        return attachements.compactMap {(attachement) -> FeedViewModel.FeedCellPhotoAttachement? in
            guard let photo = attachement.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: photo.srcBIG, width: photo.width, height: photo.height)
        }
    }
}
