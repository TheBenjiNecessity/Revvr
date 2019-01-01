//
//  ScannerViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-12-22.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import AVFoundation

fileprivate let reviewableViewAnimationDuration = 0.5

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    var currentResult = ""
    
    @IBOutlet weak var reviewableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var reviewableImageView: UIImageView!
    @IBOutlet weak var reviewableLabel: UILabel!
    @IBOutlet weak var reviewableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewableView.layer.cornerRadius = 10.0
        
        guard let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device)
        else {
            showError()
            return
        }
        
        let output = AVCaptureMetadataOutput()

        session.addInput(input)
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        
        session.sessionPreset = .photo
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        
        view.layer.insertSublayer(previewLayer!, below: reviewableView.layer)
        
        session.startRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!session.isRunning) {
            session.startRunning()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (session.isRunning) {
            session.stopRunning()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //session.stopRunning() //start running again?
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                let result = readableObject.stringValue
            else { return }
            
            if currentResult != result {
                currentResult = result
                
                shouldShowReviewableView(show: true)
                
                print(currentResult)
                
                ReviewableAPIService.shared.get(tpId: currentResult, type: "products").then { reviewable in
                    if let titleImageUrl = reviewable.titleImageUrl {
                        self.reviewableImageView?.image = UIImage.image(from: titleImageUrl)
                    }
                    
                    self.reviewableLabel?.attributedText = NSAttributedString.attributedString(for: reviewable)
                }
            }
            
            //AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
    }
    
    func shouldShowReviewableView(show: Bool) {
        var constant = CGFloat(16.0)
        if !show {
            constant = CGFloat(-166.0)
        }
        
        UIView.animate(withDuration: TimeInterval(reviewableViewAnimationDuration), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.reviewableViewBottomConstraint.constant = constant
            self.view.layoutIfNeeded()
        })
    }
    
    func showError() {
        
    }
}
