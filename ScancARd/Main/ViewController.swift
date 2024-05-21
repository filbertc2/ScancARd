//
//  ViewController.swift
//  Nano Challenge 2
//
//  Created by Filbert Chai on 15/05/24.
//


import UIKit
import SceneKit
import ARKit
import MessageUI

class ViewController: UIViewController, ARSCNViewDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        let scene = SCNScene()
        
        sceneView.scene = scene
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else{return }
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
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        
    }
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
        if let hitNode = hitTestResults.first?.node {
            switch hitNode.name {
            case "call1":
                if let url = URL(string: "tel://+6281234567891") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case "email1":
                sendCustomEmail1()
            case "map1":
                if let url = URL(string: "http://maps.apple.com/?q=6,30168S,106,65109E") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case "call2":
                if let url = URL(string: "tel://+6281234567892") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case "email2":
                sendCustomEmail2()
            case "map2":
                if let url = URL(string: "http://maps.apple.com/?q=6,30168S,106,65109E") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case "call3":
                if let url = URL(string: "tel://+6281234567893") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case "email3":
                sendCustomEmail3()
            case "map3":
                if let url = URL(string: "http://maps.apple.com/?q=6,30168S,106,65109E") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case "call4":
                if let url = URL(string: "tel://+6281234567894") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case "email4":
                sendCustomEmail4()
            case "map4":
                if let url = URL(string: "http://maps.apple.com/?q=6,30168S,106,65109E") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            default:
                break
            }
        }
    }
    
    func sendCustomEmail1() {
        guard MFMailComposeViewController.canSendMail() else {
            let alertController = UIAlertController(title: "Error", message: "Your device cannot send email.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["steven@icloud.com"])
        mailComposer.setSubject("Subject")
        mailComposer.setMessageBody("Message body", isHTML: false)
        
        self.present(mailComposer, animated: true, completion: nil)
    }
    
    func sendCustomEmail2() {
        guard MFMailComposeViewController.canSendMail() else {
            let alertController = UIAlertController(title: "Error", message: "Your device cannot send email.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["vincent@icloud.com"])
        mailComposer.setSubject("Subject")
        mailComposer.setMessageBody("Message body", isHTML: false)
        
        self.present(mailComposer, animated: true, completion: nil)
    }
    
    func sendCustomEmail3() {
        guard MFMailComposeViewController.canSendMail() else {
            let alertController = UIAlertController(title: "Error", message: "Your device cannot send email.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["jason@icloud.com"])
        mailComposer.setSubject("Subject")
        mailComposer.setMessageBody("Message body", isHTML: false)
        
        self.present(mailComposer, animated: true, completion: nil)
    }
    func sendCustomEmail4() {
        guard MFMailComposeViewController.canSendMail() else {
            let alertController = UIAlertController(title: "Error", message: "Your device cannot send email.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["james@icloud.com"])
        mailComposer.setSubject("Subject")
        mailComposer.setMessageBody("Message body", isHTML: false)
        
        self.present(mailComposer, animated: true, completion: nil)
    }
}
