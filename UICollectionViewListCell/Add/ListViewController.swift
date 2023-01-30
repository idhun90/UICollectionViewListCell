//
//  AddViewController.swift
//  UICollectionViewListCell
//
//  Created by 도헌 on 2023/01/29.
//

import UIKit

final class ListViewController: UIViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureHierarchy()
        configureDataSource()
        applySnapshot()
    }
    
}

extension ListViewController {
    private func configureNavigation() {
        navigationItem.title = NSLocalizedString("Add Item", comment: "Add Item Title")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    @objc private func add() {
        print("Add Item Successed")
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.headerMode = .firstItemInSection
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    private func applySnapshot() {
        var snapShot = Snapshot()
        snapShot.appendSections([.category, .info, .size, .url, .memo])
        snapShot.appendItems([.header(Section.category.name), .clothCategory],
                             toSection: .category)
        snapShot.appendItems([.header(Section.info.name), .clothName(""), .clothBrand, .clothColor(""), .clothPrice, .clothOrderDate(Date.now)],
                             toSection: .info)
        snapShot.appendItems([.header(Section.size.name), .clothSize, .clothFit, .clothRating, .shoulder(0.0), .chest(0.0), .sleeve(0.0), .length(0.0)],
                             toSection: .size)
        snapShot.appendItems([.header(Section.url.name), .clothOrderURL("")],
                             toSection: .url)
        snapShot.appendItems([.header(Section.memo.name), .clothMemo("Note")],
                             toSection: .memo)
        
        dataSource.apply(snapShot)
    }
    
    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            cell.contentConfiguration = headerContentConfiguration(for: cell, with: title)
        case (.category, _):
            cell.contentConfiguration = listContentConfiguration(for: cell, with: Row.clothCategory.name)
        case (.info, .clothName(let text)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: text, placeholder: Row.clothName("").name)
        case (.info, .clothBrand):
            cell.contentConfiguration = listContentConfiguration(for: cell, with: Row.clothBrand.name)
        case (.info, .clothColor(let text?)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: text, placeholder: Row.clothColor(nil).name)
        case (.info, .clothPrice):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: nil, placeholder: Row.clothPrice.name, keyboardType: .numberPad)
        case (.info, .clothOrderDate(let date)):
            cell.contentConfiguration = dateContentConfiguration(for: cell, with: date)
        case (.size, .clothFit):
            cell.contentConfiguration = listContentConfiguration(for: cell, with: Row.clothFit.name)
        case (.size, .clothSize):
            cell.contentConfiguration = listContentConfiguration(for: cell, with: Row.clothSize.name)
        case (.size, .clothRating):
            cell.contentConfiguration = listContentConfiguration(for: cell, with: Row.clothRating.name)
        case (.size, .shoulder(let number?)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: nil, placeholder: Row.shoulder(nil).name, keyboardType: .decimalPad)
        case (.size, .chest(let number?)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: nil, placeholder: Row.chest(nil).name, keyboardType: .decimalPad)
        case (.size, .sleeve(let number?)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: nil, placeholder: Row.sleeve(nil).name, keyboardType: .decimalPad)
        case (.size, .length(let number?)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: nil, placeholder: Row.length(nil).name, keyboardType: .decimalPad)
        case (.url, .clothOrderURL(let url)):
            var contentConfiguration = textFieldContentConfiguration(for: cell, with: url, placeholder: Row.clothOrderURL(nil).name, keyboardType: .URL)
            contentConfiguration.textColor = .link
            cell.contentConfiguration = contentConfiguration
        case (.memo, .clothMemo(let text?)):
            cell.contentConfiguration = TextViewContentConfiguration(for: cell, with: text)
        default:
            fatalError("Can't matching (section, row)")
        }
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Can't find section ")
        }
        return section
    }
    
}

extension ListViewController {
    private func defaultContentConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        cell.contentConfiguration = contentConfiguration
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .secondarySystemGroupedBackground
        cell.backgroundConfiguration = backgroundConfiguration
        
        return contentConfiguration
    }
    
    private func headerContentConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        
        return contentConfiguration
    }
    
    private func listContentConfiguration(for cell: UICollectionViewListCell, with text: String) -> UIListContentConfiguration {
        var contentConfiguration = UIListContentConfiguration.valueCell()
        contentConfiguration.text = text
        contentConfiguration.secondaryText = "None"
        contentConfiguration.prefersSideBySideTextAndSecondaryText = true
        cell.contentConfiguration = contentConfiguration
        cell.accessories = [.disclosureIndicator(displayed: .always)]
        return contentConfiguration
    }
    
    private func textFieldContentConfiguration(for cell: UICollectionViewListCell, with text: String?, placeholder: String?, keyboardType: UIKeyboardType = .default) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = text
        contentConfiguration.placeholder = placeholder
        contentConfiguration.keyboardType = keyboardType
        return contentConfiguration
    }
    
    private func dateContentConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickercontentView.Configuration {
        var contentConfiguration = cell.datePickerConfiguration()
        contentConfiguration.date = date
        contentConfiguration.text = Row.clothOrderDate(Date.now).name
        return contentConfiguration
    }
    
    private func TextViewContentConfiguration(for cell: UICollectionViewListCell, with text: String?) -> TextViewContentView.Configuration {
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = text
        return contentConfiguration
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}

