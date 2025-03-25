import UIKit
import Vision
import CoreImage

class DetectionViewController: UIViewController {
    private let cameraService = CameraService()
    private let mlService = MLService()
    private let detectionView = DetectionView()
    
    override func loadView() {
        view = detectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraService.startSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraService.stopSession()
    }
    
    private func setupCamera() {
        cameraService.setPreviewLayer(in: detectionView)
        cameraService.onFrameProcessed = { [weak self] image in
            self?.processFrame(image)
        }
    }
    
    private func processFrame(_ image: CIImage) {
        mlService.processImage(image) { [weak self] detections in
            guard let detections = detections else { return }
            self?.detectionView.updateDetections(detections)
        }
    }
}