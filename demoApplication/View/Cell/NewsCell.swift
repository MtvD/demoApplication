//
//  NewsCell.swift
//  demoApplication
//
//  Created by Macbook  on 8/19/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var imgView: AsyncImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    var data: Article! {
        didSet {
            imgView.loadImgUsingUrlString(urlString: data.urlToImage!)
            titleLbl.text = data.author
            contentLbl.text = data.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        contentLbl.numberOfLines = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
