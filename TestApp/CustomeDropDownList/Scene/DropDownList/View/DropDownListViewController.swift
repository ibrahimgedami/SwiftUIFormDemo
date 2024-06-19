//
//  DropDownListViewController.swift
//  DropDownList
//
//  Created by Ibrahim Mo Gedami on 10/13/23.
//

import UIKit

public class DropDownListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar?
    
    private var viewModel: DropDownListViewModelProtocol
    public var closure: ((Searchable?) -> ())?
    
    init(viewModel: DropDownListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        searchBar?.addAttributesToSearchBar(size: 13, color: UIColor.white)
        searchBar?.delegate = self
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(cellType: DropDownTableViewCell.self)
        tableView?.setupTableViewDesign()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView?.reloadData()
    }
    
}

extension DropDownListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getDataSourceCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DropDownTableViewCell.self, for: indexPath)
        viewModel.setCell(cell, indexPath: indexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.6) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
}

extension DropDownListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity: Searchable? = viewModel.didSelectCell(indexPath: indexPath)
        closure?(entity)
        dismiss(animated: true)
    }
    
}

extension DropDownListViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextDidChange(searchingText: searchText)
        tableView?.reloadData()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarCancelButtonClicked()
        searchBar.text = ""
        tableView?.reloadData()
    }
    
}

extension DropDownListViewController: Initializable {

    static func instantiate() -> Self {
        instantiateFromNib()
    }
    
}

public class DropDownListViewControllerConfigurator: NSObject {
    
    static func make() -> DropDownListViewController {
        DropDownListViewController.instantiate()
    }
    
}

protocol Initializable {
    
    static func instantiateFromNib<T: UIViewController>() -> T
    
}

extension Initializable where Self: UIViewController {
    
    static func instantiateFromNib<T: UIViewController>() -> T {
        T()
    }

}
