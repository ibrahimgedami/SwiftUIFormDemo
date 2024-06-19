//
//  DropDownListViewModel.swift
//  DropDownList
//
//  Created by Ibrahim Mo Gedami on 10/13/23.
//

import Foundation

public protocol Searchable {
    
    var searchText: String? { get }
    var object: Self? { get }
    
}

public protocol Displayable {
    
    var displayedText: String? { get }
    
}


protocol DropDownListViewModelProtocol {
    
    var getDataSourceCount: Int { get }
    func setCell(_ cell: DropDownTableViewCellProtocol, indexPath: IndexPath)
    func didSelectCell<DataModel>(indexPath: IndexPath) -> DataModel?
    func searchBarTextDidChange(searchingText: String)
    func searchBarCancelButtonClicked()
    
}

class DropDownListViewModel<DataModel> {
    
    private var searching = false
    private var filteredArray: [DataModel] = []
    private var tempArray: [DataModel] = []
    private var dataSource: [DataModel]
    
    init(dataSource: [DataModel]) {
        self.dataSource = dataSource
    }
    
}

extension DropDownListViewModel: DropDownListViewModelProtocol {
    
    var getDataSourceCount: Int {
        return searching ? filteredArray.count : dataSource.count
    }
    
    func setCell(_ cell: DropDownTableViewCellProtocol, indexPath: IndexPath) {
        let entity = searching ? filteredArray[indexPath.row] : dataSource[indexPath.row]
        guard let object = entity as? Displayable else {
            return cell.setTitle("\(entity)")
        }
        let title = object.displayedText
        cell.setTitle(title)
    }
    
    func didSelectCell<DataModel>(indexPath: IndexPath) -> DataModel? {
        let entity = searching ? filteredArray[indexPath.row] : dataSource[indexPath.row]
        return entity as? DataModel
    }
    
    func searchBarTextDidChange(searchingText: String) {
        if searchingText.isEmpty == true {
            searching = false
            filteredArray = dataSource
        } else {
            let searchTerm = searchingText.lowercased()
            guard let searchableArray = dataSource as? [Searchable] else { return }
            let result = searchableArray.filter { ($0.searchText?.lowercased().contains(searchTerm)) ?? false }
            guard let filteredResult = result as? [DataModel] else { return }
            tempArray = filteredResult
            searching = true
            filteredArray = tempArray
        }
    }
    
    func searchBarCancelButtonClicked() {
        searching = false
    }
    
}
