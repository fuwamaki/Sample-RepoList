//
//  MainTableCell.swift
//  SampleRepoList
//
//  Created by yusaku maki on 2021/06/10.
//

import UIKit

class MainTableCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

    private let gateway: APIGatewayProtocol = APIGateway()

    var iconImageUrl: String? {
        didSet {
            guard let urlString = iconImageUrl, let url = URL(string: urlString) else { return }
            gateway.fetchImage(url: url) { [weak self] result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.iconImageView.image = image
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var subTitle: String? {
        didSet {
            subTitleLabel.text = "☆ " + (subTitle ?? "")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MainTableCell: NibLoadable {}
