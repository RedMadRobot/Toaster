@testable import Toaster_Example
import XCTest

final class ViewControllerTests: ViewControllerTestCase {
    
    private var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    private func setupViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { fatalError() }
        viewController = controller
        rootViewController = controller
    }
    
    func testSuccessOperation() {
        setupViewController()
        viewController.showFeedback(view: FeedbackNotification.successOperation.view)
        XCTAssertEqual(currentFeedbackNotificationText, "Операция выполнена успешно")
    }
    
    func testWarningOperation() {
        setupViewController()
        viewController.showFeedback(view: FeedbackNotification.warningOperation.view)
        XCTAssertEqual(currentFeedbackNotificationText, "Операция выполнена с ограничениями")
    }
    
    func testsSomethingWentWrong() {
        setupViewController()
        viewController.showFeedback(view: FeedbackNotification.somethingWentWrong.view)
        XCTAssertEqual(currentFeedbackNotificationText, "Что-то пошло не так")
    }
    
    func testsokOperation() {
        setupViewController()
        viewController.showFeedback(view: FeedbackNotification.okOperation.view)
        XCTAssertEqual(currentFeedbackNotificationText, "Ваш запрос успешно обработан")
    }
    
    func testsbadOperation() {
        setupViewController()
        viewController.showFeedback(view: FeedbackNotification.badOperation.view)
        XCTAssertEqual(currentFeedbackNotificationText, "Невозможно выполнить данную операцию")
    }

}

