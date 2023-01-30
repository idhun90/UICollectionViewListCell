//
//  ListViewController + Section.swift
//  UICollectionViewListCell
//
//  Created by 도헌 on 2023/01/30.
//

import UIKit

extension ListViewController {
    enum Section: Int, Hashable {
        case category
        case info
        case size
        case url
        case memo
        
        var name: String {
            switch self {
            case .category: return NSLocalizedString("Category", comment: "category Section Name")
            case .info: return NSLocalizedString("Info", comment: "info Section Name")
            case .size: return NSLocalizedString("Size", comment: "size Section Name")
            case .url: return NSLocalizedString("URL", comment: "URL Section Name")
            case .memo: return NSLocalizedString("Note", comment: "Memo Section Name")
            }
        }
    }
}
