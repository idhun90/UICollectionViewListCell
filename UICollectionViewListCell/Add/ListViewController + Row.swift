//
//  ListViewController + Row.swift
//  UICollectionViewListCell
//
//  Created by 도헌 on 2023/01/30.
//

import UIKit

extension ListViewController {
    enum Row: Hashable {
        case header(String)
        case clothCategory
        case clothName(String)
        case clothBrand
        case clothColor(String?)
        case clothFit
        case clothSize
        case clothOrderDate(Date)
        case clothSatisfaction
        case clothOrderURL(String?)
        case clothMemo
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .header(_): return .subheadline
            default: return .body
            }
        }
        
        var name: String {
            switch self {
            case .header(_): return ""
            case .clothCategory: return "카테고리"
            case .clothName(_): return "제품명"
            case .clothBrand: return "브랜드"
            case .clothColor(_): return "색상"
            case .clothFit: return "핏"
            case .clothSize: return "사이즈"
            case .clothOrderDate: return "구매일"
            case .clothSatisfaction: return "만족도"
            case .clothOrderURL: return "URL"
            case .clothMemo: return "메모"
            }
        }
    }
}
