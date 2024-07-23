//
//  InspectionListViewController.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import UIKit
import Combine

class InspectionListViewController: UIViewController {

    @IBOutlet private var inspectionListTableView: UITableView!
    
    private var cancellable: Set<AnyCancellable> = []
    private let viewModel: InspectionListViewModelType
    required init?(coder: NSCoder,viewModel: InspectionListViewModelType) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUIElements()
    }
    func setupUIElements() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupBindings() {
        viewModel.inspectionListResult.sink { [weak self] complition in
            if case let .failure(error) = complition{
                self?.showNetworkError(error)
            }
        } receiveValue: { [weak self] inspection in
            self?.inspectionListTableView.reloadData()
        }.store(in: &cancellable)
        //viewModel.loadInspections()
    }
   
    // MARK: - Action Methods
    @IBAction private func didTapOnNewInspection() {
        viewModel.moveToInspectionDetails()
    }

}
// MARK: - Table View Datasource & Delegates
extension InspectionListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfInspections()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(UpcomingInspectionCell.self) else { return UITableViewCell() }
        cell.inspectionDetails = viewModel.inspectionAt(indexPath.row)
        return cell
    }
}
