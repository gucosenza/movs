import UIKit

class SpinnerView: UIView {
    
    let ai: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.style = .large
        return ai
    }()

    func startSpinner(_ rect: CGRect) -> UIView {
        self.frame = rect
        self.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        ai.startAnimating()
        setupViews()
        return self
    }
    
    func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
}

extension SpinnerView: CodeView{
    func buildViewHierarchy() {
        self.addSubview(ai)
    }
    
    func setupConstraints() {
        ai.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        ai.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
//     func setupAdditionalConfiguration() {
//        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
//    }
     
}
