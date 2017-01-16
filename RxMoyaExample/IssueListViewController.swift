//
//  ViewController.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-12.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Moya
import UIKit
import RxCocoa
import RxSwift

class IssueListViewController: UIViewController, UITableViewDelegate {

	let tableView = UITableView()
	let searchController = UISearchController(searchResultsController: nil)
	let disposeBag = DisposeBag()

	var provider: RxMoyaProvider<GitHub>!
	var issueTrackerModel: IssueTrackerModel!
	var latestRepositoryName: Observable<String> {
		return searchController.searchBar.rx
						.text
						.filterNil()
						.filter { text in !text.isEmpty }
						.debounce(0.5, scheduler: MainScheduler.instance)
						.distinctUntilChanged()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
		tableView.tableHeaderView = searchController.searchBar
		view = tableView

		setupRx()
	}

	func setupRx() {
		// First part of the puzzle, create our Provider
		provider = RxMoyaProvider<GitHub>()

		// Now we will setup our model
		issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)
		// Here we tell table view that if user clicks on a cell,
		// and the keyboard is still visible, hide it

		issueTrackerModel
			.trackIssues()
			.bindTo(tableView.rx.items(cellIdentifier: String(describing: UITableViewCell.self), cellType: UITableViewCell.self)) { (row, element, cell) in
				cell.textLabel?.text = element.title
			}
			.addDisposableTo(disposeBag)
	}
}
