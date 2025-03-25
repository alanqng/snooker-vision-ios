import UIKit
import Vision
import QuartzCore

class DetectionView: UIView {
    private let detectionLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .black
        layer.addSublayer(detectionLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        detectionLayer.frame = bounds
    }
    
    func updateDetections(_ detections: [VNRecognizedObjectObservation]) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        detectionLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        for detection in detections {
            let box = detection.boundingBox
            let boxView = createBoxView(for: box)
            detectionLayer.addSublayer(boxView)
            
            if let topLabel = detection.labels.first {
                let labelView = createLabelView(for: topLabel, at: box)
                detectionLayer.addSublayer(labelView)
            }
        }
        
        CATransaction.commit()
    }
    
    private func createBoxView(for box: CGRect) -> CALayer {
        let layer = CALayer()
        layer.frame = VNImageRectForNormalizedRect(box, Int(bounds.width), Int(bounds.height))
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 2
        return layer
    }
    
    private func createLabelView(for label: VNClassificationObservation, at box: CGRect) -> CATextLayer {
        let text = "\(label.identifier): \(Int(label.confidence * 100))%"
        
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.fontSize = 14
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.backgroundColor = UIColor.green.withAlphaComponent(0.7).cgColor
        textLayer.cornerRadius = 4
        textLayer.masksToBounds = true
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: VNImageRectForNormalizedRect(box, Int(bounds.width), Int(bounds.height)).minX,
                                y: VNImageRectForNormalizedRect(box, Int(bounds.width), Int(bounds.height)).minY - 20,
                                width: 100,
                                height: 20)
        return textLayer
    }
}