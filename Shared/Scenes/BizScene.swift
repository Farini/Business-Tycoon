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
        super.init()
        self.addLightsCameraSky()
        self.addFloor()
    }
    
    func addSceneModel(name:String){
        
        print("Adding Scene Model: \(name)")
        
        // Scene
        guard let scene = SCNScene(named: name) else{
            print("Could not load file")
            return
        }
        
        for node in scene.rootNode.childNodes{
            if let cam = node.camera{
                print("Child cam: X\(node.position.x) Y\(node.position.y) Z\(node.position.z) Scale\(cam.orthographicScale)")
            }
            
        }
        
        
        if let mesh:SCNNode = scene.rootNode.childNode(withName: "geometry", recursively: true){
            
            print("Mesh Node: \(mesh.name ?? "unnamed")")
            
            if let geometry = mesh.geometry{
                
                print("Geometry")
                print("GEO position: \(mesh.position)")
                
                if let material = geometry.firstMaterial{
                    
                    print("Material")
                    
                    print("Found Child, Geometry, and Material")
                    let cloner = duplicateNode(node: mesh, material: material)
                    
                    rootNode.addChildNode(cloner)
                
                    return
                }
            }
        }
    }
    
    func removeLights(){
        print("Removing lights")
        for node in rootNode.childNodes{
            if let light = node.light{
                print("Found light node: \(light.type.rawValue) Removing.")
                node.removeFromParentNode()
            }
        }
    }
    
    func removeCameras(){
        print("Removing cameras")
        for node in rootNode.childNodes{
            if let camera = node.camera{
                print("Found camera node: Orth: \(camera.usesOrthographicProjection) Removing.")
                node.removeFromParentNode()
            }
        }
    }
    
    func addFloor(){
        
        print("Adding floor")
        
        let floor = SCNFloor()
        floor.reflectivity = 0.2
        floor.reflectionFalloffEnd = 0.0
        floor.reflectionFalloffStart = 0.0
        floor.reflectionResolutionScaleFactor = 0.2
        
        floor.width = 0
        floor.length = 0
        
        if !floor.materials.isEmpty{
            for material in floor.materials{
                print("Floor material \(material.description)")
            }
        }
        
        let floorNode = SCNNode()
        floorNode.geometry = floor
        
        rootNode.addChildNode(floorNode)
        
        /*
         
         By default, a floor extends infinitely in the x- and z-axis dimensions of its local coordinate space, and is located in the plane whose y-coordinate is zero. To position and orient a floor in a scene, attach it to the geometry property of an SCNNode object. Often, you use a floor to provide a background for a scene.
         If a floor’s reflectivity property is greater than zero, SceneKit automatically renders reflections for all geometries above it. Optionally, you can add an opacity gradient so that reflections of scene contents closer to the floor appear more clearly than those of scene contents further from it. You control the floor’s reflectivity using the properties listed in Adding Reflections to a Floor.
         */
        // let floor = MDLMaterial(name: <#T##String#>, scatteringFunction: <#T##MDLScatteringFunction#>
//
//        let materialProperty = SCNMaterialProperty()
//        materialProperty.contents
        
        // floor.shaderModifiers = [SCNShaderModifierEntryPoint.surface
        
    }
    
    func addLightsCameraSky(){
        
        // MARK: - Lights
        
        print("Adding Lights")
        
        // Ambient
        let ambient = SCNLight()
        ambient.type = .ambient
        ambient.intensity = 120
        ambient.color = UIColor.lightGray
        
        let ambientNode = SCNNode()
        ambientNode.light = ambient
        rootNode.addChildNode(ambientNode)
        
        print("Ambient Light")
        
        // Omni
        let omni = SCNLight()
        omni.type = .omni
        omni.intensity = 700
        // Color
        omni.attenuationFalloffExponent = 2
        omni.castsShadow = true
        omni.shadowSampleCount = 3
        let omniColor = UIColor(red: 245, green: 239, blue: 200, alpha: 1.0)
        omni.color = omniColor//UIColor.yellow
        
        // position
        
        let omniNode = SCNNode()
        omniNode.position = SCNVector3.init(2.5, 2.4, -0.3)
        omniNode.light = omni
        rootNode.addChildNode(omniNode)
        
        print("Omni Light")
        
        // Camera
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 1.5
        camera.wantsHDR = false
        camera.wantsDepthOfField = false
        
        let camPosition = SCNVector3(10.28, 3.97, 5.535)
        // let camEuler = SCNVector3(-17.8, 63.475, 0.0)
        
        // let camPos = SCNVector3.init(-15.0, 52.0, 0.0)
        let camNode = SCNNode()
        camNode.position = camPosition
        // camNode.eulerAngles = camEuler
        camNode.camera = camera
        
        let center = SCNVector3(0, 0.5, 0)
        camNode.look(at: center)
        
        rootNode.addChildNode(camNode)
        rootNode.camera = camera
        
        print("Camera")
        
        // Setup Sky
        
        let sky = MDLSkyCubeTexture(name: nil,
                                channelEncoding: MDLTextureChannelEncoding.uInt8,
        textureDimensions: [Int32(160), Int32(160)],
        turbidity: 1.0,
        sunElevation: 0.778,
        upperAtmosphereScattering: 0.4,
        groundAlbedo: 0.33)
        
        sky.saturation = -2
        
        // background
        self.background.contents = sky.imageFromTexture()?.takeUnretainedValue()
        
        print("SKY")
    }
    
    func duplicateNode(node:SCNNode, material:SCNMaterial) -> SCNNode{
        
        let newNode = node.clone()
        
        guard let geometry = node.geometry?.copy() as? SCNGeometry else{
            fatalError()
        }
        
        newNode.geometry = geometry// node.geometry?.copy() as? SCNGeometry
        newNode.geometry?.firstMaterial = material
        
        return newNode
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
