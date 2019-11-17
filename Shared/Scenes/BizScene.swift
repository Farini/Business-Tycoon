//
//  BizScene.swift
//  Business Tycoon
//
//  Created by Farini on 11/15/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit
import SceneKit

class BizScene: SCNScene {
    
    var bizModelName:String?{
        didSet{
            
            print("Showing model")
            
            // Scene
            guard let scene = SCNScene(named: bizModelName!) else{
                print("Could not load file")
                return
            }
            
            if let bNode:SCNNode = scene.rootNode.childNode(withName: "businessMesh", recursively: true)?.copy() as? SCNNode{
                // add node to scene
                rootNode.addChildNode(bNode)
            }
        }
    }
    
    
    override init() {
        
        // Setup lights
        let light1 = SCNLight()
        
        // setup background
        
        // Setup camera
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
