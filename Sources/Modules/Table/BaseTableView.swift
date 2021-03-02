//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 02.03.2021.
//

import UIKit
import SQDifferenceKit

// MARK: - Base Table View
@objc public protocol BaseTableView where Self: UIViewController {

// MARK: - Variables
    var tableView: UITableView! { get }

    var fabric: SQTableFabric! { get }
    var refreshControl: UIRefreshControl? { get set }

// MARK: - Methods
    func setupRefreshControl()
    func setupTableView()
    func setupFabric()

// MARK: - Actions
    @objc func onRefreshControlChanged()
}

// MARK: - Base Table View - Default implementation
public extension BaseTableView where Self: UITableViewDelegate,
                                     Self: UITableViewDataSource {

// MARK: - Methods
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.onRefreshControlChanged), for: .valueChanged)
        self.tableView.refreshControl = refreshControl

        self.refreshControl = refreshControl
    }

    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self

        if self.tableView.style == .plain {
            self.tableView.tableHeaderView = UIView(frame: .zero)
            self.tableView.tableFooterView = UIView(frame: .zero)
        }

        self.setupFabric()
    }
}

// MARK: - Base Table View - Data Source
public extension BaseTableView where Self: UITableViewDataSource,
                                     Self: DiffTableProtocol {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.data[section].elements.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.data[indexPath.section].elements[indexPath.row]

        return self.fabric.cell(forModelRow: model,
                                atIndexPath: indexPath)
    }
}

// MARK: - Base Table View - Table Delegate
public extension BaseTableView where Self: UITableViewDelegate,
                                     Self: DiffTableProtocol {
// MARK: - Displaying cells
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        self.storeHeight(forCell: cell, atIndexPath: indexPath)
        self.restoreScrollPosition(forCell: cell, atIndexPath: indexPath)
    }

    func tableView(_ tableView: UITableView,
                   didEndDisplaying cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        self.storeScrollPosition(forCell: cell, atIndexPath: indexPath)
    }

// MARK: - Section header
    func tableView(_ tableView: UITableView,
                   estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return (self.data[section].model.header == nil) ? CGFloat.leastNonzeroMagnitude : 44
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return (self.data[section].model.header == nil) ? 0 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        return self.fabric.header(forModelSection: self.data[section].model.header,
                                  atSection: section)
    }

// MARK: - Rows height
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.height(forCellAtIndexPath: indexPath)
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

// MARK: - Section footer
    func tableView(_ tableView: UITableView,
                   estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return (self.data[section].model.footer == nil) ? CGFloat.leastNonzeroMagnitude : 44
    }

    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return (self.data[section].model.footer == nil) ? 0 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        return self.fabric.footer(forModelSection: self.data[section].model.footer,
                                  atSection: section)
    }

// MARK: - Interaction with cells
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Base Table View - Collection Cell Delegate
public extension BaseTableView where Self: CollectionCellDelegate,
                                     Self: DiffTableProtocol {
    func saveScrollPosition(_ position: CGPoint,
                            forModel model: CollectionModelRow?) {
        guard let model = model,
              let sectionIndex = self.data.firstIndex(where: { $0.elements.contains(where: { $0.differenceIdentifier == model.differenceIdentifier }) }) else { return }

        let key = self.cacheKey(forModel: model, inSection: sectionIndex)
        self.storeScrollPosition(position, forKey: key)
    }
}

