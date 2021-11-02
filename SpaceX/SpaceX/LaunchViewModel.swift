//
//  LaunchViewModel.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 02.11.2021.
//

import Foundation

class LaunchViewModel{
    let launch: Launch
    let links: LinksViewModel
    let staticFireDateUTC: String
    let rocket: String
    let success: String
    let details: String
    let name: String
    let dateUTC: String
    let id: String
    
    init(_ launch: Launch){
        self.launch = launch
        self.links = LinksViewModel(launch)
        self.staticFireDateUTC = LaunchViewModel.fireDate(launch.staticFireDateUTC)
        self.rocket = launch.rocket
        self.success = launch.success ? "Yes" : "No"
        self.details = launch.details
        self.name = launch.name
        self.dateUTC = LaunchViewModel.fireDate(launch.dateUTC)
        self.id = launch.id
    }
    
    static func fireDate(_ stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let date = dateFormatter.date(from: stringDate) else { return "" }
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd, yyyy")
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
}

extension LaunchViewModel {
    
    struct LinksViewModel: Equatable {
        let patch: PatchViewModel
        let reddit: RedditViewModel
        let flickr: FlickrViewModel
        let presskit: URL?
        let webcast: URL?
        let youtubeID: String
        let article, wikipedia: URL?
    
        enum CodingKeys: String, CodingKey {
            case patch, reddit, flickr, presskit, webcast
            case youtubeID = "youtube_id"
            case article, wikipedia
        }
        
        init(_ launch: Launch){
            self.patch = PatchViewModel(launch)
            self.reddit = RedditViewModel(launch)
            self.flickr = FlickrViewModel(launch)
            self.presskit = LaunchViewModel.getURL(from: launch.links.presskit)
            self.webcast = LaunchViewModel.getURL(from: launch.links.webcast)
            self.youtubeID = launch.links.youtubeID
            self.article = LaunchViewModel.getURL(from: launch.links.article)
            self.wikipedia = LaunchViewModel.getURL(from: launch.links.wikipedia)
        }
    }
    
    struct FlickrViewModel: Equatable {
        let small: [URL]
        let original: [URL]
        
        init(_ launch: Launch){
            self.small = LaunchViewModel.getArrayOfURLs(from: launch.links.flickr.small)
            self.original = LaunchViewModel.getArrayOfURLs(from: launch.links.flickr.original)
        }
    }
    
    struct PatchViewModel:  Equatable {
        let small, large: URL?
        
        init(_ launch: Launch){
            self.small = LaunchViewModel.getURL(from: launch.links.patch.small)
            self.large = LaunchViewModel.getURL(from: launch.links.patch.large)
        }
    }
    
    struct RedditViewModel: Equatable {
        let campaign, launch, media, recovery: URL?
        
        init(_ launch: Launch){
            self.campaign = LaunchViewModel.getURL(from: launch.links.reddit.campaign)
            self.launch = LaunchViewModel.getURL(from: launch.links.reddit.launch)
            self.media = LaunchViewModel.getURL(from: launch.links.reddit.media)
            self.recovery = LaunchViewModel.getURL(from: launch.links.reddit.recovery)
        }
    }
    
    static func getURL(from string: String?) -> URL?{
        if let urlString = string {
            return URL(string: urlString)
        }
        else { return nil }
    }
    
    static func getArrayOfURLs(from strings: [String]) -> [URL] {
        var urls =  [URL]()
        if !strings.isEmpty{
            for string in strings {
                urls.append(URL(string: string)!)
            }
        }
        return urls
    }
    
}
