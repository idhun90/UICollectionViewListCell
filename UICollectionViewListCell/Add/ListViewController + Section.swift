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
        case cloth
        case size
        case url
        case memo
        
        var name: String {
            switch self {
            case .category: return NSLocalizedString("카테고리", comment: "category Name")
            case .cloth: return NSLocalizedString("세부사항", comment: "cloth Section Name")
            case .size: return NSLocalizedString("사이즈", comment: "size Section Name")
            case .url: return NSLocalizedString("URL", comment: "URL Section Name")
            case .memo: return NSLocalizedString("메모", comment: "Memo Section Name")
            }
        }
    }
}
