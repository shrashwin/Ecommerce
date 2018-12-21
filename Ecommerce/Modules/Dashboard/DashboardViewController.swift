import UIKit

class DashboardViewController: UIViewController
{
    var dashboardData: DashboardDataWrapper?
    var presenter: DashboardPresenterProtocol?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
        presenter?.fetchDashBoardData()
    }
    
    private func setup()
    {
        presenter = DashboardPresenter(with: self)
    }
    
}

extension DashboardViewController:DashboardViewProtocol {
 
    func didFetch(dashboardData: DashboardDataWrapper) {
        self.dashboardData = dashboardData
    }
}

