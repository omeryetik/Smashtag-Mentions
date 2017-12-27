//
//  SmashtagCommons.swift
//  Smashtag
//
//  Created by Ömer Yetik on 26/12/2017.
//  Copyright © 2017 Ömer Yetik. All rights reserved.
//

import Foundation
import UIKit

struct MentionColors {
    static let hashtagColor:     UIColor = .brown
    static let urlColor:         UIColor = .blue
    static let userMentionColor: UIColor = .orange
}

struct TableProperties {
    static let headerForImages = "Images"
    static let headerForHashtags = "Hashtags"
    static let headerForUrls = "URLs"
    static let headerForUserMentions = "Users"
}

struct Keys {
    static let keyForRecentsArray = "Default.recent.searches"
}

struct SegueIdentifiers {
    static let fromMentionToImage = "Segue.show.image"
    static let fromMentionToSearch = "Segue.show.tweets.from.mention"
    static let fromRecentToSearch = "Segue.show.tweets.from.recent"
}

struct CellIdentifiers {
    static let forTextMentions = "Cell.mention.text"
    static let forImageMentions = "Cell.mention.image"
    static let forTweets = "Cell.tweet"
    static let forRecents = "Cell.recent"
}
