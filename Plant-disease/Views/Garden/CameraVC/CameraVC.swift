//
//  CameraVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 18/10/22.
//
import UIKit
import AVFoundation
import Vision

class CameraVC: BaseVC, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    

    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label"
        label.font = label.font.withSize(17)
        return label
    }()
    
        override func viewDidLoad() {
            // call the parent function
            super.viewDidLoad()
            
            // establish the capture session and add the label
            setupCaptureSession()
            view.addSubview(label)
            setupLabel()
        }


    func setupCaptureSession() {
        
        DispatchQueue.main.async {
            // create a new capture session
            let captureSession = AVCaptureSession()
            
            // find the available cameras
            let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
            
            do {
                // select a camera
                if let captureDevice = availableDevices.first {
                    captureSession.addInput(try AVCaptureDeviceInput(device: captureDevice))
                }
            } catch {
                // print an error if the camera is not available
                print(error.localizedDescription)
            }
            
            // setup the video output to the screen and add output to our capture session
            let captureOutput = AVCaptureVideoDataOutput()
            captureSession.addOutput(captureOutput)
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = self.view.frame
            self.view.layer.addSublayer(previewLayer)
            
            // buffer the video and start the capture session
            captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession.startRunning()
        }
      
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
           // load our CoreML Pokedex model
           guard let model = try? VNCoreMLModel(for: coreml_model().model) else { return }
    
           // run an inference with CoreML
           let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
    
               // grab the inference results
               guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
               
               // grab the highest confidence result
               guard let Observation = results.first else { return }
               
               // create the label text components
               let predclass = "\(Observation.identifier)"
               let predconfidence = String(format: "%.02f%", Observation.confidence * 100)
    
               // set the label text
               DispatchQueue.main.async(execute: {
                   self.label.text = "\(predclass) \(predconfidence)"
               })
           }
           
           // create a Core Video pixel buffer which is an image buffer that holds pixels in main memory
           // Applications generating frames, compressing or decompressing video, or using Core Image
           // can all make use of Core Video pixel buffers
           guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
           
           // execute the request
           try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
       }
    
    func setupLabel() {
        // constrain the label in the center
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // constrain the the label to 50 pixels from the bottom
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
    }
}

