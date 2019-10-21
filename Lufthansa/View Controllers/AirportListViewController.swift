import UIKit

protocol SelectionAirportDelegate {
    func setAirport(airport: Airport, origin: Bool)
}

class AirportListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ServiceAlertProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: AirportListViewModel = AirportListViewModel()
    var delegate: SelectionAirportDelegate?
    var origin: Bool = false
    let airportCellId = "AirportCell"
    let noResultsId = "NoResultsCell"
    let paginationNumber = 60
    let codeCountNumber = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        fetchAirports()
    }
    
    func fetchAirports() {
        viewModel.fetchAirports(onSuccess: { _ in
            self.tableView.reloadData()
            self.hideKeyboard()
        }, onError: { error in
            if error != .noResultsError {
                AlertHelper.app.showAlert(error: error, vc: self)
            }
            self.tableView.reloadData()
            self.hideKeyboard()
        
        })
    }
    
    func searchAirport(code: String) {
        self.searchBar.endEditing(true)
        viewModel.searchAirport(code: code, onSuccess: { _ in
            self.tableView.reloadData()
            self.hideKeyboard()
        }, onError: { error in
            if error != .noResultsError {
                AlertHelper.app.showAlert(error: error, vc: self)
            }
            self.tableView.reloadData()
            self.hideKeyboard()
        })
    }
    
    func reload() {
        viewModel.resetPagination()
        searchBar.text = ""
        self.fetchAirports()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.viewModel.getAirportsCount() == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: noResultsId) as? NoResultsCell else {
                return UITableViewCell()
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: airportCellId, for: indexPath) as? AirportListCell else {
            return UITableViewCell()
        }
        guard let airport = self.viewModel.getAirport(index: indexPath.row) else {
            return UITableViewCell()
        }
        let currentAirportsCount = viewModel.getAirportsCount()
        if currentAirportsCount < viewModel.getTotalAirports() &&
        indexPath.row == (currentAirportsCount - paginationNumber) {
            self.fetchAirports()
        }
        cell.setupCell(viewModel: AirportListCellViewModel(airport: airport))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAirportsCount() == 0 ? 1 : viewModel.getAirportsCount()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let airport = viewModel.getAirport(index: indexPath.row) else {
            return
        }
        delegate?.setAirport(airport: airport, origin: origin)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refresh() {
        viewModel.resetPagination()
        tableView.reloadData()
        self.searchBar.text = ""
        self.fetchAirports()
    }
    
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let code = searchBar.text, code.count == codeCountNumber {
            searchAirport(code: code)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let code = searchBar.text, code.count == codeCountNumber {
            searchAirport(code: code)
        } else if let code = searchBar.text, code.count == 0 {
            refresh()
        }
    }
    
    @objc func hideKeyboard() {
        self.searchBar.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    
}
