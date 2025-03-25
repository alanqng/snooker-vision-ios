# Snooker Vision iOS

A native iOS application for real-time snooker ball detection using computer vision and machine learning.

## Features

- Real-time snooker ball detection using CoreML and Vision framework
- High-performance camera frame processing
- GPU-accelerated image processing using Metal
- Live visualization of detected balls and their positions
- Support for both iPhone and iPad

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+
- iPhone/iPad with A12 Bionic chip or newer (for optimal ML performance)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/alanqng/snooker-vision-ios.git
cd snooker-vision-ios
```

2. Open the project in Xcode:
```bash
open SnookerVision.xcodeproj
```

3. Build and run the project on your device or simulator.

## Architecture

The app follows a clean architecture pattern with the following key components:

- **CameraService**: Handles camera setup, frame capture, and processing
- **MLService**: Manages CoreML model loading and inference
- **VisionService**: Processes frames using Vision framework
- **DetectionView**: Renders camera feed and detection overlays
- **DetectionViewModel**: Manages detection state and UI updates

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.