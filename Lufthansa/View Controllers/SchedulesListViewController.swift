import Foundation
import UIKit

class SchedulesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ServiceAlertProtocol {
    
    var viewModel: SchedulesListViewModel?
    var scheduleCellId = "ScheduleCell"
    var noResultsId = "NoResultsCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var refreshController = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        refreshController.tintColor = UIColor.BlueLufthansa
        refreshController.addTarget(self, action: #selector(fetchSchedules), for: .valueChanged)
        tableView.refreshControl = refreshController
        fetchSchedules()
    }
    
    @objc func fetchSchedules() {
        showLoading()
        viewModel?.fetchSchedules(onSuccess: { (response) in
            self.tableView.reloadData()
            self.finishLoading()
        }, onError: { (error) in
            if error != .noResultsError {
                AlertHelper.app.showAlert(error: error, vc: self)
            }
            self.finishLoading()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel?.getSchedulesCount() == 0 {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: noResultsId) as? NoResultsCell else {
              return UITableViewCell()
           }
           return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: scheduleCellId, for: indexPath) as? ScheduleListCell else {
            return UITableViewCell()
        }
        guard let schedule = self.viewModel?.getSchedule(index: indexPath.row) else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: ScheduleListCellViewModel(schedule: schedule))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.getSchedulesCount() ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let originAirport = viewModel?.getOriginAirport(),
            let destinationAirport = viewModel?.getDestinationAirport() else {
            return
        }
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Itinerary") as? ItineraryViewController else {
           return
        }
        vc.viewModel = ItineraryViewModel(originAirport: originAirport, destinationAirport: destinationAirport)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func finishLoading() {
        self.activityIndicator.stopAnimating()
        self.refreshController.endRefreshing()
        self.activityIndicator.isHidden = true
    }
    
    func showLoading() {
        if refreshController.isRefreshing {
            activityIndicator.isHidden = true
        } else {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }
    
    func reload() {
        self.fetchSchedules()
    }

}
