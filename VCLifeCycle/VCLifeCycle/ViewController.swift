import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var clickMeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        animateButton()
        print("View Loaded")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View appeared")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View is about to appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View disappeared")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View is about to disappear")
    }
    private func animateButton() {
        UIView.animate(withDuration: 2, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.buttonTopConstraint.constant = 150
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    private func setUpView() {
        clickMeButton.layer.cornerRadius = 5
        clickMeButton.layer.shadowOpacity = 0.5
        clickMeButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        clickMeButton.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

