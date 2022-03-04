//
//  MagneticViewController.swift
//  Bubble
//
//  Created by Zhibek Rahymbekkyzy on 03.03.2022.
//

import UIKit
import SpriteKit
import Magnetic

class MagneticViewController: UIViewController, MagneticDelegate {
    var selectedAllergens = [String]()
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
//        for node in allNodes {
//            if let index = allNodes.firstIndex(where: { $0.text == node.text}){
//               allNodes.remove(at: index)
//            }
//        }
//        selectedAllergens.append(node.text!)
        allNodes.append(node)
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
//        for allergen in selectedAllergens {
//            if let index = selectedAllergens.firstIndex(where: { $0 == allergen}){
//                selectedAllergens.remove(at: index)
//                allNodes.append(node)
//            }
//        }
//        node.removeFromParent()
    }
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet {
                    magnetic.magneticDelegate = self
                    magnetic.removeNodeOnLongPress = true
                    #if DEBUG
                    magneticView.showsFPS = true
                    magneticView.showsDrawCount = true
                    magneticView.showsQuadCount = true
                    magneticView.showsPhysics = true
                    #endif
                }
    }
    
    var magnetic: Magnetic {
           return magneticView.magnetic
       }
    
    var allNodes = [Node]()
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       
       for name in UIImage.names {
           let color = UIColor.systemPink
           let node = Node(text: name.capitalized, image: UIImage(named: name), color: color, radius: 50)
           node.selectedColor = UIColor.colors.randomItem()
           magnetic.addChild(node)
       }
    }

    
    
    @IBAction func go(_ sender: UIButton) {
        print("I am here\n")
        print(allNodes)
        for node in allNodes {
            node.removeFromParent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


// MARK: - MagneticDelegate
extension ViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didRemove node: Node) {
        print("didRemove -> \(node)")
    }
    
}

// MARK: - ImageNode
class ImageNode: Node {
    override var image: UIImage? {
        didSet {
            texture = image.map { SKTexture(image: $0) }
        }
    }
    override func selectedAnimation() {}
    override func deselectedAnimation() {}
}


extension UIImage {
    
    static let names: [String] = ["Глютен-содержающие злаки", "Ракообразные продукты", "Яйца", "Рыба", "Арахис", "Соевые бабы", "Молочные продукты", "Орехи", "Сельдерей", "Горчица", "Кунжут", "Алкаголь", "Люпина", "Молюски", "Цитрус", "Мёд"]
    
}

extension Array {
    
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}

extension CGPoint {
    
    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
    
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    
    static var red: UIColor {
        return UIColor(red: 255, green: 59, blue: 48)
    }
    
    static var orange: UIColor {
        return UIColor(red: 255, green: 149, blue: 0)
    }
    
    static var yellow: UIColor {
        return UIColor(red: 255, green: 204, blue: 0)
    }
    
    static var green: UIColor {
        return UIColor(red: 76, green: 217, blue: 100)
    }
    
    static var tealBlue: UIColor {
        return UIColor(red: 90, green: 200, blue: 250)
    }
    
    static var blue: UIColor {
        return UIColor(red: 0, green: 122, blue: 255)
    }
    
    static var purple: UIColor {
        return UIColor(red: 88, green: 86, blue: 214)
    }
    
    static var pink: UIColor {
        return UIColor(red: 255, green: 45, blue: 85)
    }
    
    static let colors: [UIColor] = [.red, .orange, .yellow, .green, .tealBlue, .blue, .purple, .pink]
    
}
