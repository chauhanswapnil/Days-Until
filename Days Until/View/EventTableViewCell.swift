//
//  EventTableViewCell.swift
//  Days Until
//
//  Created by Swapnil Chauhan on 04/10/20.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var daysLabel: UILabel!
    
    var uuid: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
