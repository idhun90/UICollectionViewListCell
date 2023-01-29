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
        snapShot.appendSections([.category, .cloth, .size, .url, .memo])
        snapShot.appendItems([.header(Section.category.name), .clothCategory], toSection: .category)
        snapShot.appendItems([.header(Section.cloth.name), .clothName(""), .clothBrand, .clothColor(""), .clothOrderDate(Date.now)], toSection: .cloth)
        snapShot.appendItems([.header(Section.size.name), .clothSize, .clothFit, .clothSatisfaction], toSection: .size)
        snapShot.appendItems([.header(Section.url.name), .clothOrderURL("")], toSection: .url)
        snapShot.appendItems([.header(Section.memo.name), .clothMemo], toSection: .memo)
        
        dataSource.apply(snapShot)
    }
    
    
    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            cell.contentConfiguration = headerContentConfiguration(for: cell, with: title)
        case (.category, _):
            cell.contentConfiguration = ListContentConfiguration(for: cell, with: Row.clothCategory.name)
        case (.cloth, .clothName(let text)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: text, placeholder: "제품명")
        case (.cloth, .clothBrand):
            cell.contentConfiguration = ListContentConfiguration(for: cell, with: Row.clothBrand.name)
        case (.cloth, .clothColor(let text?)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: text, placeholder: "색상")
        case (.cloth, .clothOrderDate(let date)):
            cell.contentConfiguration = dateContentConfiguration(for: cell, with: date)
        case (.url, .clothOrderURL(let url)):
            cell.contentConfiguration = textFieldContentConfiguration(for: cell, with: url, placeholder: "URL")
        default:
            cell.contentConfiguration = defaultContentConfiguration(for: cell, at: row)
        }
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("매칭되는 section 없음")
        }
        
        return section
    }
    
}

extension ListViewController {
    
    private func defaultContentConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = "테스트"
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
    
    private func ListContentConfiguration(for cell: UICollectionViewListCell, with text: String) -> UIListContentConfiguration {
        var contentConfiguration = UIListContentConfiguration.valueCell()
        contentConfiguration.text = text
        contentConfiguration.secondaryText = "없음"
        contentConfiguration.prefersSideBySideTextAndSecondaryText = true
        cell.contentConfiguration = contentConfiguration
        cell.accessories = [.disclosureIndicator(displayed: .always)]
        return contentConfiguration
    }
    
    private func textFieldContentConfiguration(for cell: UICollectionViewListCell, with text: String?, placeholder: String?) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = text
        contentConfiguration.placeholder = placeholder
        return contentConfiguration
    }
    
    private func dateContentConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickercontentView.Configuration {
        var contentConfiguration = cell.datePickerConfiguration()
        contentConfiguration.date = date
        return contentConfiguration
    }
}

extension ListViewController: UICollectionViewDelegate {
    
}

