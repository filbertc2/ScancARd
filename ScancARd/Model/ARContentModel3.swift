import Foundation
import SceneKit
import ARKit

struct ARContentModel3 {
    static func addPlane(anchor: ARImageAnchor, node: SCNNode) {
        let plane = SCNPlane(width: anchor.referenceImage.physicalSize.width, height: anchor.referenceImage.physicalSize.height)
        plane.materials.first?.diffuse.contents = UIImage(named: "card33")
        plane.materials.first?.isDoubleSided = true
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(x: 0, y: 0, z: 0)
        planeNode.scale = SCNVector3(1.5, 1.5, 1.5)
        planeNode.eulerAngles = SCNVector3(x: Float(-Double.pi / 2), y: 0.0, z: 0.0)
        node.addChildNode(planeNode)
        
        if let callScene = SCNScene(named: "art.scnassets/call3.scn") {
            if let callNode = callScene.rootNode.childNode(withName: "scene", recursively: true) {
                let xOffset: CGFloat = CGFloat(anchor.referenceImage.physicalSize.width / 2 + 0.061)
                let zOffset: CGFloat = CGFloat(anchor.referenceImage.physicalSize.height / 2 - 0.065)
                callNode.position = SCNVector3(x: Float(xOffset), y: 0, z: Float(zOffset))
                callNode.scale = SCNVector3(0.0003, 0.0003, 0.0003)
                node.addChildNode(callNode)
            }
        }
        
        if let emailScene = SCNScene(named: "art.scnassets/email3.scn") {
            if let emailNode = emailScene.rootNode.childNode(withName: "scene", recursively: true) {
                let xOffset: CGFloat = CGFloat(anchor.referenceImage.physicalSize.width / 2 + 0.045)
                let zOffset: CGFloat = CGFloat(anchor.referenceImage.physicalSize.height / 2 - 0.017)
                emailNode.position = SCNVector3(x: Float(xOffset), y: 0, z: Float(zOffset))
                emailNode.scale = SCNVector3(0.00007, 0.00007, 0.00007)
                node.addChildNode(emailNode)
            }
        }
        
        if let mapScene = SCNScene(named: "art.scnassets/map3.scn") {
            if let mapNode = mapScene.rootNode.childNode(withName: "scene", recursively: true) {
                let xOffset: CGFloat = CGFloat(anchor.referenceImage.physicalSize.width / 2 + 0.045)
                let zOffset: CGFloat = CGFloat(anchor.referenceImage.physicalSize.height / 2 - 0.00005)
                mapNode.position = SCNVector3(x: Float(xOffset), y: 0, z: Float(zOffset))
                mapNode.scale = SCNVector3(0.00007, 0.00007, 0.00007)
                node.addChildNode(mapNode)
            }
        }
    }
}
