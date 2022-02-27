//
//  ViewController.swift
//  Poke3D
//
//  Created by Dishant Nagpal on 19/02/22.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    // var pokeScene=SCNScene()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting=true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        
        if let imageToTrack=ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main){
            configuration.trackingImages=imageToTrack
            configuration.maximumNumberOfTrackedImages=2
            print("images successfully added")
            
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node=SCNNode()
        
        if let imageAnchor=anchor as? ARImageAnchor{
            let cardName=imageAnchor.referenceImage.name
            let plane=SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents=UIColor(white: 1.0, alpha: 0.5)
            let planeNode=SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -Float.pi/2
            node.addChildNode(planeNode)
            DispatchQueue.main.async {
                if cardName=="evee"{
                    
                    if let pokeScene=SCNScene(named: "art.scnassets/eevee.scn"){
                        print("yes1")
                        if let pokeNode=pokeScene.rootNode.childNode(withName: "eevee", recursively: true){
                            print("yes2")
                            pokeNode.eulerAngles.x = Float.pi/2
                            planeNode.addChildNode(pokeNode)
                        }
                    }
                }
                else if cardName=="oddish"{
                    
                    if let pokeScene=SCNScene(named: "art.scnassets/oddish.scn"){
                        print("yes1")
                        if let pokeNode=pokeScene.rootNode.childNode(withName: "oddish", recursively: true){
                            print("yes2")
                            pokeNode.eulerAngles.x = Float.pi/2
                            planeNode.addChildNode(pokeNode)
                        }
                    }
                }
            }
            
        }
        return node
    }
}
