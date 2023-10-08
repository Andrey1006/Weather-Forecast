//
//  BaseDataSource.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 25.09.2023.
//

import UIKit

// MARK: - Data Source
public struct BaseDataSource<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel> {
    public typealias SectionViewModel = BaseSectionViewModel<ID, Header, Cell, Footer>
    
    private(set) public var sections: [SectionViewModel] = []
    private var sectionPriorityHandler: SectionPriorityHandler<ID>
    
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    var count: Int {
        return sections.count
    }
    
    init(sectionPriorityHandler: SectionPriorityHandler<ID> = .init()) {
        self.sectionPriorityHandler = sectionPriorityHandler
    }
    
    public subscript(_ index: Int) -> SectionViewModel {
        return sections[index]
    }
    

        
    public mutating func inject(section: SectionViewModel) {
        if let index = sections.firstIndex(where: { $0.id == section.id }) {
            sections[index] = section
        } else {
            let sectionPriority: Int = sectionPriorityHandler.priority(for: section.id)
            
            if let index = sections.firstIndex(where: { sectionPriority < sectionPriorityHandler.priority(for: $0.id) }) {
                sections.insert(section, at: index)
            } else {
                sections.append(section)
            }
        }
    }
    
    public mutating func replaceAll(sections: [SectionViewModel]) {
        self.sections.removeAll()
        var exictedIds: Set<ID> = []
        
        for section in sections {
            if !exictedIds.contains(section.id) {
                exictedIds.insert(section.id)
                self.sections.append(section)
            } else {
                BaseSectionViewModelLogger.onErrorLog?("Found collision item in base data source", [
                    "method": #function,
                    "section": "\(section.id)",
                    "item": "\(type(of: self))"
                ])
            }
        }
    }
    
    public mutating func removeSection(id: ID) {
        guard let index = sections.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        sections.remove(at: index)
    }
}

// MARK: - Diffable
extension BaseDataSource {
    public typealias DiffableDataSource = UICollectionViewDiffableDataSource<SectionViewModel, LinkedCellViewModel<ID, Cell>>
    public typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<SectionViewModel, LinkedCellViewModel<ID, Cell>>
    
    public var snapshot: DiffableSnapshot {
        var snapshot: DiffableSnapshot = .init()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.innerItems, toSection: section)
        }
        
        return snapshot
    }
}

// you can use it for data sources without priority
// by default it is data source with single section
open class SectionPriorityHandler<ID> {
    open func priority(for id: ID) -> Int {
        return 0
    }
}


//MARK: - Nothing

public struct Nothing: BaseCellViewModel, BaseHeaderViewModel, BaseFooterViewModel {
    public var id: UUID = .init()
    
    public var size: CGSize {
        return .zero
    }
    
    public var height: CGFloat {
        return size.height
    }
    
    init() { }
}


extension Nothing: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


extension Nothing: Equatable {
    public static func == (lhs: Nothing, rhs: Nothing) -> Bool {
        return lhs.id == rhs.id
    }
}

//MARK: - Section
public struct BaseSectionViewModel<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel> {
    public let id: ID
    public var header: Header?
    var innerItems: [LinkedCellViewModel<ID, Cell>] // saves from ids collisions in different sections
    public var footer: Footer?
    
    public var items: [Cell] {
        return innerItems.map(\.source)
    }
    
    // just for collections
    public var insets: UIEdgeInsets = .zero
    public var interitemSpacing: CGFloat = 0
    public var lineSpacing: CGFloat = 0
    
    public var count: Int {
        return innerItems.count
    }
    
    public subscript(_ index: Int) -> Cell {
        return innerItems[index].source
    }
    
    public init(
        id: ID,
        header: Header? = nil,
        items: [Cell] = [],
        footer: Footer? = nil,
        insets: UIEdgeInsets = .zero,
        interitemSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0
    ) {
        self.id = id
        self.header = header
        self.footer = footer
        self.insets = insets
        self.interitemSpacing = interitemSpacing
        self.lineSpacing = lineSpacing
        
        self.innerItems = []
        self.insertUnique(items: items)
    }
    
    private mutating func insertUnique(items: [Cell]) {
        var exictedIds: Set<Cell.ID> = []
        
        for item in items {
            if !exictedIds.contains(item.id) {
                exictedIds.insert(item.id)
                self.innerItems.append(.init(sectionID: id, source: item))
            } else {
                BaseSectionViewModelLogger.onErrorLog?("Found collision item in base data source", [
                    "section": "\(id)",
                    "item": "\(item.id)"
                ])
            }
        }
    }
}

// MARK: - Nothing
extension BaseSectionViewModel where ID == Nothing {
    public init(
        header: Header? = nil,
        items: [Cell] = [],
        footer: Footer? = nil,
        insets: UIEdgeInsets = .zero,
        interitemSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0
    ) {
        self.init(
            id: .init(),
            header: header,
            items: items,
            footer: footer,
            insets: insets,
            interitemSpacing: interitemSpacing,
            lineSpacing: lineSpacing
        )
    }
}

// MARK: - Copy
extension BaseSectionViewModel: CopyableViewModel where ID: CopyableViewModel, Header: CopyableViewModel, Cell: CopyableViewModel, Footer: CopyableViewModel {
    public var copy: BaseSectionViewModel<ID, Header, Cell, Footer> {
        return copy()
    }
    
    public func copy(
        id: ID? = nil,
        header: Header?? = nil,
        items: [Cell]? = nil,
        footer: Footer?? = nil,
        insets: UIEdgeInsets? = nil,
        interitemSpacing: CGFloat? = nil,
        lineSpacing: CGFloat? = nil
    ) -> BaseSectionViewModel<ID, Header, Cell, Footer> {
        return .init(
            id: id ?? self.id.copy,
            header: header ?? self.header?.copy,
            items: items ?? self.items.copy,
            footer: footer ?? self.footer?.copy,
            insets: insets ?? self.insets,
            interitemSpacing: interitemSpacing ?? self.interitemSpacing,
            lineSpacing: lineSpacing ?? self.lineSpacing
        )
    }
}

// MARK: Hashable
extension BaseSectionViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension BaseSectionViewModel: Equatable {
    public static func == (
        lhs: BaseSectionViewModel<ID, Header, Cell, Footer>,
        rhs: BaseSectionViewModel<ID, Header, Cell, Footer>
    ) -> Bool {
        return [
            lhs.id == rhs.id,
            lhs.header == rhs.header,
            lhs.items == rhs.items,
            lhs.footer == rhs.footer,
            lhs.insets == rhs.insets,
            lhs.interitemSpacing == rhs.interitemSpacing,
            lhs.lineSpacing == rhs.lineSpacing
        ].allSatisfy({ $0 })
    }
}

// MARK: - Log
public struct BaseSectionViewModelLogger {
    /// (message: String, params: [String: String])
    public static var onErrorLog: ((String, [String: String]) -> ())?
}
