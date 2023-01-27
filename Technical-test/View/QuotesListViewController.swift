//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class QuotesListViewController: UIViewController {

    private let dataManager: DataManager = DataManager()
    private var market: Market? = nil
    private var tableView = UITableView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchQuotes()
    }

    private func configure() {
        title = "Quotes list"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureTableView()
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

    private func fetchQuotes() {
        Task {
            do {
                let quotes = try await dataManager.fetchQuotes()
                let market = Market()
                market.quotes = quotes
                self.market = market
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

extension QuotesListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let market = market,
              let quotes = market.quotes else {
            return 0
        }

        return quotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: QuoteCell.typeName,
            for: indexPath
        )

        guard let cell = cell as? QuoteCell,
              let market = market,
              let quotes = market.quotes else {
            return cell
        }

        var quote = quotes[indexPath.row]
        quote.myMarket = market
        cell.configure(with: quote)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell = tableView.cellForRow(at: indexPath) as? QuoteCell,
              let quote = cell.getQuote() else {
            return
        }

        navigationController?.pushViewController(
            QuoteDetailsViewController(quote: quote),
            animated: true
        )
    }
}
