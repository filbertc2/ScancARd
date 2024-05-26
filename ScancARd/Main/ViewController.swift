import UIKit
import SceneKit
import ARKit
import MessageUI

class ViewController: UIViewController, ARSCNViewDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        configuration.trackingImages = referenceImages
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) { }
    func sessionWasInterrupted(_ session: ARSession) { }
    func sessionInterruptionEnded(_ session: ARSession) { }
}

extension ViewController {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        DispatchQueue.main.async {
            print(imageAnchor.referenceImage.name!)
            self.addPlaneForAnchor(imageAnchor, node: node)
        }
    }
    
    private func addPlaneForAnchor(_ anchor: ARImageAnchor, node: SCNNode) {
        switch anchor.referenceImage.name {
        case "card1":
            ARContentModel1.addPlane(anchor: anchor, node: node)
        case "card2":
            ARContentModel2.addPlane(anchor: anchor, node: node)
        case "card3":
            ARContentModel3.addPlane(anchor: anchor, node: node)
        case "card4":
            ARContentModel4.addPlane(anchor: anchor, node: node)
        default:
            break
        }
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(location, options: nil)
        if let hitNode = hitTestResults.first?.node, let nodeName = hitNode.name {
            print(nodeName)
            handleNodeTap(nodeName: nodeName)
        }
    }
    
    
    private func handleNodeTap(nodeName: String) {
        if let phoneNumber = NodeActions.phoneNumbers[nodeName] {
            openURL(urlString: "tel://\(phoneNumber)")
        } else if let emailRecipient = NodeActions.emailRecipients[nodeName] {
            sendEmail(to: emailRecipient)
        } else if let coordinates = NodeActions.mapCoordinates[nodeName] {
            openURL(urlString: "http://maps.apple.com/?q=\(coordinates)")
        }
    }
    
    
    
    private func openURL(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func sendEmail(to recipient: String) {
        guard MFMailComposeViewController.canSendMail() else {
            let alertController = UIAlertController(title: "Error", message: "Your device cannot send email.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([recipient])
        mailComposer.setSubject("Subject")
        mailComposer.setMessageBody("Message body", isHTML: false)
        
        self.present(mailComposer, animated: true, completion: nil)
    }
}
