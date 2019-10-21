import UIKit

class AirportSelectionViewContoller: UIViewController {

    var viewModel: AirportSelectionViewModel = AirportSelectionViewModel()
    
    @IBOutlet weak var landingImage: UIImageView!
    @IBOutlet weak var takeOffImage: UIImageView!
    @IBOutlet weak var originButton: UIButton!
    @IBOutlet weak var destinationButton: UIButton!
    @IBOutlet weak var searchButton: LufthansaButton!
    @IBOutlet weak var dateSelectionTextField: UITextField!
    let datePicker = UIDatePicker()
    let storyboardMain = "Main"
    let schedulesVC = "SchedulesList"
    let airportVC = "AirportsList"
    let doneLabel = "Done"
    let cancelLabel = "Cancel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = true
        searchButton.isEnabled = false
        searchButton.setupSearch()
        landingImage.transform = CGAffineTransform.init(rotationAngle: -(.pi / 6))
        takeOffImage.transform = CGAffineTransform.init(rotationAngle: .pi / 6)
        setupPicker()
    }
    
    @IBAction func selectOrigin(sender: Any) {
        selectAirport(fromOrigin: true)
    }
    
    @IBAction func selectDestination(sender: Any) {
        selectAirport(fromOrigin: false)
     }
    
    func setupPicker() {
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        let doneButton = UIBarButtonItem(title: doneLabel, style: .done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: cancelLabel, style: .plain, target: self, action: #selector(self.cancelPicker))
        
        doneButton.tintColor = UIColor.BlueLufthansa
        cancelButton.tintColor = UIColor.BlueLufthansa
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dateSelectionTextField.inputView = datePicker
        dateSelectionTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        dateSelectionTextField.resignFirstResponder()
        dateSelectionTextField.text = DateHelper.app.getString(from: datePicker.date)
    }
    
    @objc func cancelPicker() {
        dateSelectionTextField.resignFirstResponder()
    }
    
    @IBAction func searchFlights(sender: Any) {
        guard let originAirport = viewModel.getOriginAirport(),
            let destinationAirport = viewModel.getDestinationAirport() else {
            return
        }
        guard let vc = UIStoryboard.init(name: storyboardMain, bundle: Bundle.main).instantiateViewController(withIdentifier: schedulesVC) as? SchedulesListViewController else {
           return
        }
        vc.viewModel = SchedulesListViewModel(origin: originAirport, destination: destinationAirport, date: datePicker.date)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func selectAirport(fromOrigin: Bool) {
        guard let vc = UIStoryboard.init(name: storyboardMain, bundle: Bundle.main).instantiateViewController(withIdentifier: airportVC) as? AirportListViewController else {
           return
        }
        vc.delegate = self
        vc.origin = fromOrigin
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AirportSelectionViewContoller: SelectionAirportDelegate {
    func setAirport(airport: Airport, origin: Bool) {
        if origin {
            viewModel.setOriginAirport(airport: airport)
            originButton.setupWithAirport(airport: airport)
        } else {
            viewModel.setDestinationAirport(airport: airport)
            destinationButton.setupWithAirport(airport: airport)
        }
        if viewModel.getOriginAirport() != nil && viewModel.getDestinationAirport() != nil {
            searchButton.isEnabled = true
            searchButton.setupSearch()
        }
    }
}
