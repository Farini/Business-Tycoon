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
        
        // Ambient
        let ambient = SCNLight()
        ambient.type = .ambient
        ambient.intensity = 120
        
        // Omni
        let omni = SCNLight()
        omni.type = .omni
        omni.intensity = 700
        // Color
        omni.attenuationFalloffExponent = 2
        omni.castsShadow = true
        omni.shadowSampleCount = 3
        // position
        // comes with empty node?
        
        let empty = SCNNode()
        empty.position = SCNVector3.init(2.5, 2.4, -0.3)
        empty.light = omni
        
        // Camera
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 3.0
        camera.wantsHDR = false
        camera.wantsDepthOfField = false
        
        let camPos = SCNVector3.init(-15.0, 52.0, 0.0)
        let camNode = SCNNode()
        camNode.position = camPos
        camNode.eulerAngles = SCNVector3.init(9.0, 3.5, 7.0)
        camNode.camera = camera
        
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
