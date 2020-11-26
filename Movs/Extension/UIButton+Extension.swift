import UIKit

extension UIButton {
    public enum ConfirmButton {
        public static func build(title: String) -> UIButton {
            let button = UIButton(frame: .zero)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont(name: "System", size: 20)
            button.backgroundColor = UIColor(named: "colorYellow")
            button.layer.cornerRadius = 10
            
            return button
        }
    }
    
}
