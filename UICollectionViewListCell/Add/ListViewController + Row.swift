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
        case clothRating
        case clothMemo(String?)
        case shoulder(Double?)
        case chest(Double?)
        case sleeve(Double?)
        case waist(Double?)
        case thigh(Double?)
        case rise(Double?)
        case ankle(Double?)
        case length(Double?)
        
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
            case .clothRating: return "Rating"
            case .clothMemo(_): return "Note"
            case .shoulder(_): return "Shoulder"
            case .chest(_): return "Chest"
            case .sleeve(_): return "Sleeve"
            case .waist(_): return "Waist"
            case .thigh(_): return "Thigh"
            case .rise(_): return "rise"
            case .ankle(_): return "ankle"
            case .length(_): return "length"
            }
        }
    }
}
