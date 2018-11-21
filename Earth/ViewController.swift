//
//  ViewController.swift
//  Earth
//
//  Created by AlexanderKogut on 2/11/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    let scene = SCNScene()
    var radius: CGFloat = 0.1
    var yPostion: CGFloat = 0.0
    var raduisButtons:[ERButton] = [ERButton(),ERButton()]
    var upDouwnbuttons:[ERButton] = [ERButton(),ERButton()]
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
    
        presentGlobe()
        sceneView.scene = scene
        setupButtonsUpDouw()
        setupButtonsPlusMinus()
        constraintsUpDpunButtons()
        constraintsRaiusButtons()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func createGlobe(radius: CGFloat, positions: SCNVector3) -> SCNNode {
        let sphera = SCNSphere(radius: radius)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/earth.jpeg")
        sphera.firstMaterial = material
        let spheraNode = SCNNode(geometry: sphera)
        spheraNode.position = positions
        return spheraNode
    }
    
    func presentGlobe() {
        
        UIView.animate(withDuration: 0.3) {
            let position = SCNVector3.init(0.0, self.yPostion, -0.3)
            let globe = self.createGlobe(radius: self.radius, positions: position)
            self.scene.rootNode.addChildNode(globe)
            
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

//MARK: - Constraints
extension ViewController {

    func constraints(items: Any,
                     attributes: NSLayoutAttribute,
                     related: NSLayoutRelation,
                     toItem: Any?,
                     attributestoItem: NSLayoutAttribute,
                     multiplier: CGFloat,
                     constant: CGFloat) {
        
        NSLayoutConstraint(item: items,
                           attribute: attributes,
                           relatedBy: related,
                           toItem: toItem,
                           attribute: attributestoItem,
                           multiplier: multiplier,
                           constant: constant).isActive = true
    }
    
    func constraintsUpDpunButtons() {
        
        constraints(items: upDouwnbuttons[0], attributes: .left, related: .equal, toItem: sceneView, attributestoItem: .left, multiplier: 1, constant: 0)
        constraints(items: upDouwnbuttons[1], attributes: .right, related: .equal, toItem: sceneView, attributestoItem: .right, multiplier: 1, constant: 0)
        
        for (up, plus)  in zip (upDouwnbuttons, raduisButtons) {
            constraints(items: up, attributes: .top, related: .equal, toItem: plus, attributestoItem: .top, multiplier: 1, constant: -100)
        }
        
    }

    func constraintsRaiusButtons() {
        
        constraints(items: raduisButtons[0], attributes: .left, related: .equal, toItem: sceneView, attributestoItem: .left, multiplier: 1, constant: 0)
        constraints(items: raduisButtons[1], attributes: .right, related: .equal, toItem: sceneView, attributestoItem: .right, multiplier: 1, constant: 0)
        
        for i in raduisButtons {
            constraints(items: i, attributes: .bottom, related: .equal, toItem: sceneView, attributestoItem: .bottom, multiplier: 1, constant: -20)
        }
    }
}

//MARK: - Buttons and Actions
extension ViewController {
    
    func setupButtonsUpDouw() {
        
        let up = UIImage(named: "icons8-circled_up_filled")!
        let down = UIImage(named: "icons8-circled_down_2_filled")!
        let buttonsImage: [UIImage] = [down, up]
        
        upDouwnbuttons[0].tag = 2
        upDouwnbuttons[1].tag = 3
        for (button, image) in zip (upDouwnbuttons, buttonsImage) {
            button.setBackgroundImage(image, for: .normal)
        }
        
        for up in upDouwnbuttons {
            sceneView.addSubview(up)
        }
    }
    
    func setupButtonsPlusMinus() {
        
        let plus = UIImage(named: "icons8-plus_filled")!
        let minus = UIImage(named: "icons8-minus_filled")!
        let buttonsImage: [UIImage] = [minus, plus]
        
        for ((offset: index, element: button), image) in zip (raduisButtons.enumerated(), buttonsImage) {
            button.setBackgroundImage(image, for: .normal)
            button.tag = index
        }
        
        for i in raduisButtons {
            sceneView.addSubview(i)
        }
    }
    
    
    @objc func pressButton(sender: UIButton) {
        
        switch sender.tag {
        case 0:
            radius -= 0.05
        case 1:
            radius += 0.05
        case 2:
            yPostion -= 0.05
        case 3:
            yPostion += 0.05
        default:
            print("default")
        }
        
        print(yPostion)
        presentGlobe()
        print(radius)
    }
    
}
