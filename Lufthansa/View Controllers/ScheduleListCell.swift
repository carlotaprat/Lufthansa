import UIKit

class ScheduleListCell: UITableViewCell {

    @IBOutlet weak var depDayLabel: UILabel!
    @IBOutlet weak var depMonthLabel: UILabel!
    @IBOutlet weak var depAirportLabel: UILabel!
    @IBOutlet weak var depTimeLabel: UILabel!
    @IBOutlet weak var arrDayLabel: UILabel!
    @IBOutlet weak var arrMonthLabel: UILabel!
    @IBOutlet weak var arrAirportLabel: UILabel!
    @IBOutlet weak var arrTimeLabel: UILabel!
    @IBOutlet weak var noDirectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(viewModel: ScheduleListCellViewModel) {
        depDayLabel.text = viewModel.getDepartureDay()
        depMonthLabel.text = viewModel.getDepartureMonth()
        depAirportLabel.text = viewModel.getDepartureAirport()
        depTimeLabel.text = viewModel.getDepartureTime()
        arrDayLabel.text = viewModel.getArrivalDay()
        arrMonthLabel.text = viewModel.getArrivalMonth()
        arrAirportLabel.text = viewModel.getArrivalAirport()
        arrTimeLabel.text = viewModel.getArrivalTime()
        noDirectLabel.isHidden = viewModel.isDirectFlight()
    }
}
