//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit
import Combine

final class QuotesListViewController: BaseViewController {

    private var tableView = UITableView()

    private var market: Market?
    private var cancellable = Set<AnyCancellable>()
    private let fetchQuotesSubject = PassthroughSubject<Void, Never>()
    private let viewModel = QuotesListViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        loadMarket()
    }

    private func configure() {
        title = "Quotes list"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureTableView()
    }

    private func bind() {
        let input = QuotesListViewModel.Input(fetchQuotes: fetchQuotesSubject)
        let output = viewModel.transform(input: input)

        output.quotes.sink { result in
            self.processQuotes(result)
        }
        .store(in: &cancellable)
    }

    private func configureTableView() {
        tableView.setConstraints(to: view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 95
        tableView.register(
            UINib(nibName: QuoteCell.nibName, bundle: nil),
            forCellReuseIdentifier: QuoteCell.typeName
        )
    }

    private func loadMarket() {
        if let market = Storage.shared.market {
            self.market = market
        } else {
            market = Market()
        }
        fetchQuotesSubject.send(Void())
    }

    private func processQuotes(_ result: Result<[Quote], Error>) {
        switch result {
        case .success(let quotes):
            Task {
                market?.quotes = quotes
                Storage.shared.market = market
                tableView.reloadData()
            }
        case .failure(let error):
            Task {
                let alert = UIAlertController(
                    title: "Error",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                presentAlert(alert: alert, needCloseWhenTapOutside: true)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension QuotesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        market?.quotes?.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: QuoteCell.typeName,
            for: indexPath
        )

        guard let cell = cell as? QuoteCell else {
            return cell
        }

        var quote = market?.quotes?[indexPath.row]
        quote?.myMarket = market
        cell.quote = quote

        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuotesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)

        guard let cell = cell as? QuoteCell else {
            return
        }

        navigationController?.pushViewController(
            QuoteDetailsViewController(quote: cell.quote),
            animated: true
        )
    }
}
