
import Foundation

protocol DashboardViewProtocol: BaseProtocol {
    func didFetch(dashboardData: DashboardDataWrapper)
}

protocol DashboardPresenterProtocol
{
    func fetchDashBoardData()
}
