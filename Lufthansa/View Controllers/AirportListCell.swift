import UIKit

class AirportListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(viewModel: AirportListCellViewModel) {
        nameLabel.text = " - " + viewModel.getAirportName()
        shortNameLabel.text = viewModel.getAirportShortname().uppercased()
    }
}
