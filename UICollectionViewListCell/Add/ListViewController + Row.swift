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
        case clothPrice
        case clothOrderURL(String?)
        case clothFit
        case clothSize
        case clothOrderDate(Date)
        case clothSatisfaction
        case clothMemo(String?)
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .header(_): return .subheadline
            default: return .body
            }
        }
        
        var name: String {
            switch self {
            case .header(_): return ""
            case .clothCategory: return "Category"
            case .clothName(_): return "Name"
            case .clothBrand: return "Brand"
            case .clothColor(_): return "Color"
            case .clothPrice: return "Price"
            case .clothOrderURL(_): return "Url"
            case .clothFit: return "Fit"
            case .clothSize: return "Size"
            case .clothOrderDate(_): return "OrderDate"
            case .clothSatisfaction: return "SatisFaction"
            case .clothMemo(_): return "Note"
            }
        }
    }
}
