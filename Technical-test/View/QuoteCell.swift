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

    var quote: Quote? {
        didSet {
            update()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func update() {
        updateLabels()
        updateFavoriteState()
    }

    private func updateLabels() {
        nameLabel.text = quote?.name
        lastLabel.text = quote?.last
        currencyLabel.text = quote?.currency
        readableLastChangePercentLabel.text = quote?.readableLastChangePercent
        readableLastChangePercentLabel.textColor = quote?.percentColor
    }

    private func updateFavoriteState() {
        if quote?.myMarket?.favoriteQuotesNames.contains(quote?.name) ?? false {
            favoriteImage.image = UIImage(named: AppConstants.ImageNames.favorite)
        } else {
            favoriteImage.image = UIImage(named: AppConstants.ImageNames.noFavorite)
        }
    }
}
