protocol ScreenPresenterProtocol: AnyObject {
    func present(_ screen: ScreenPresenterProtocol, style: ScreenPresentStyle)
    func dismiss(animated: Bool)
}
