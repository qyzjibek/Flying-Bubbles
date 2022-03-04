//
//  ViewController.swift
//  Bubble
//
//  Created by Zhibek Rahymbekkyzy on 03.03.2022.
//

import UIKit
import WobbleBubbleButton

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: WobbleBubbleButton!
    
    @IBAction func button1(_ sender: WobbleBubbleButton) {
        sender.backgroundColor = UIColor.red
    }
    @IBOutlet weak var button2: WobbleBubbleButton!
    @IBOutlet weak var button3: WobbleBubbleButton!
     

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBubbleButton()
    }
    
    func setUpBubbleButton() {
        configBubbleButton(button1, primaryText: "Аллергия", subText: "выберите", backgroundColor: UIColor.systemPink.withAlphaComponent(0.5))
        configBubbleButton(button2, primaryText: "Вкус", subText: "выберите", backgroundColor: UIColor.purple.withAlphaComponent(0.5))
        configBubbleButton(button3, primaryText: "Рестораны", subText: "выберите", backgroundColor: UIColor.cyan.withAlphaComponent(0.5))
    }
    
    func configBubbleButton(_ button: WobbleBubbleButton, primaryText: String, subText: String, backgroundColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        let attributedText = NSAttributedString(string: primaryText + "\n",
          attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)
          ])
        let attributedDetailText = NSAttributedString(string: subText,
          attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
          ])
        let attributedCombinedText = NSMutableAttributedString()
        attributedCombinedText.append(attributedText)
        attributedCombinedText.append(attributedDetailText)
        button.setAttributedTitle(attributedCombinedText, for: UIControl.State())
      }
    
    
}
