//
//  DebtCell.swift
//  Должник
//
//  Created by Егор Аблогин on 17.02.2024.
//

import UIKit

final class DebtCell: UITableViewCell {
    
    @IBOutlet var dates: [UILabel]!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var debtSizeLabel: UILabel!
    @IBOutlet weak var debtDirectionImage: UIImageView!
    @IBOutlet weak var hasCommentImage: UIImageView!
    
}
