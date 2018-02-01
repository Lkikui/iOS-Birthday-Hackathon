//
//  CustomCell.swift
//  birthday
//
//  Created by Maria Teresa Rojo on 1/31/18.
//  Copyright © 2018 Maria Rojo. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var giftListLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
}

protocol AddBirthdayDelegate: class {
    func save(_ controller: AddEditViewController, with name: String, gifts: String, and date: Date, at indexPath: IndexPath?)
}
