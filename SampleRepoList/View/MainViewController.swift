//
//  ViewController.swift
//  SampleRepoList
//
//  Created by yusaku maki on 2021/06/10.
//

import UIKit
import SafariServices

class MainViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.backgroundImage = UIImage()
        }
    }

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.registerForCell(MainTableCell.self)
            tableView.delegate = self
            tableView.dataSource = self
//            tableView.tableFooterView = UIView()
//            tableView.backgroundColor = UIColor.systemBackground
        }
    }

    @IBAction private func clickSearchButton(_ sender: Any) {
        if let query = searchBar.text {
            fetchRepositories(query: query)
        }
    }

    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.blue
        indicator.isHidden = true
        return indicator
    }()

    private var isHideIndicator: Bool = true {
        didSet {
            DispatchQueue.main.async {
                self.isHideIndicator
                ? self.indicator.stopAnimating()
                : self.indicator.startAnimating()
                self.indicator.isHidden = self.isHideIndicator
            }
        }
    }

    private let gateway: APIGatewayProtocol = APIGateway()
    private var repositories: [GithubRepo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(indicator)
    }

    private func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func fetchRepositories(query: String) {
        isHideIndicator = false
        gateway.fetchRepositories(query) { [weak self] result in
            self?.isHideIndicator = true
            switch result {
            case .success(let repositories):
                self?.repositories = repositories.items
                self?.reload()
            case .failure(let error):
                let alert = UIAlertController(
                    title: "エラー",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableCell.defaultHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: repositories[indexPath.row].htmlUrl) else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellForIndexPath(indexPath) as MainTableCell
        cell.render(repo: repositories[indexPath.row])
        return cell
    }
}
