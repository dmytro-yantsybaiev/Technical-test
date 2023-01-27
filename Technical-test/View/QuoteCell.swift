//
//  QuoteCell.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 25.01.2023.
//

import UIKit

class QuoteCell: UITableViewCell, TypeIdentifiable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var readableLastChangePercentLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!

    private var quote: Quote?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with quote: Quote) {
        self.quote = quote
        update()
    }

    func getQuote() -> Quote? {
        quote
    }

    private func update() {
        guard let quote else { return }
        updateLabels(with: quote)
        updateFavoreiteState(with: quote)
    }

    private func updateLabels(with quote: Quote) {
        nameLabel.text = quote.name
        lastLabel.text = quote.last
        currencyLabel.text = quote.currency
        readableLastChangePercentLabel.text = quote.readableLastChangePercent
        readableLastChangePercentLabel.textColor = quote.percentColor
    }

    private func updateFavoreiteState(with quote: Quote) {

        guard let myMarket = quote.myMarket,
              let quoteName = quote.name else {
            return
        }

        if myMarket.favoriteQuotesNames.contains(quoteName) {
            favoriteImage.image = UIImage(named: AppConstants.ImageNames.favorite)
        } else {
            favoriteImage.image = UIImage(named: AppConstants.ImageNames.noFavorite)
        }
    }
}
