//
//  MVPTableViewCell.swift
//  carplay_tutorial
//
//  Created by 小柳智之 on 2021/09/14.
//

import UIKit

class MVPTableViewCell: UITableViewCell {

    
    static var className: String { String(describing: MVPTableViewCell.self)}
    
    @IBOutlet weak private var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(githubModel: GithubModel) {
        label.text = githubModel.fullName
    }
    
}
