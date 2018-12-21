import UIKit

class DashboardPresenter
{
    weak var view: DashboardViewProtocol!
    
    init(with view: DashboardViewProtocol) {
        self.view = view
    }
    
    func fetchData() {
        view.showHud(message: HudMessages.pleaseWait)
        DashboardDataManager.fetchDashboardData(onSuccess: {
            [weak self] dashboardData in
            guard let sSelf = self else { return }
            sSelf.view.hideHud()
            sSelf.view.didFetch(dashboardData: dashboardData)
        }) { [weak self] (failureModel) in
            guard let sSelf = self else { return }
            sSelf.view.hideHud()
            sSelf.view.handleFailure(response: failureModel, completion: nil)
        }
    }
}

extension DashboardPresenter: DashboardPresenterProtocol {
    
    func fetchDashBoardData() {
        fetchData()
    }
}
