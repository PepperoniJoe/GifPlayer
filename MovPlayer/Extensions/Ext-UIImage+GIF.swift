//
//  Ext-UIImage+GIF.swift
//  MovPlayer
//
//  Created by Marcy Vernon on 10/31/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//
import UIKit
import ImageIO

//MARK: Extension for creating animated images from GIF files
extension UIImage {
  
  //MARK: - Preferred: Get GIF files from Assets catalog
  static func gif(asset: String) -> UIImage? {
    guard let dataAsset = NSDataAsset(name: asset) else {
      print("Cannot turn image named \"\(asset)\" into NSDataAsset. Check file spelling and case.")
      return nil
    }
    
    return createAnimatedImage(data: dataAsset.data)
  } // end of static func gif:asset:
  
  
  //MARK: - Alternative: Get GIF files from target file
  static func gif(name: String) -> UIImage? {
    // Check for existance of gif
    guard let bundleURL = Bundle.main
      .url(forResource: name, withExtension: "gif") else {
        print("This gif named \"\(name)\" does not exist")
        return nil
    }
    
    var imageData = Data()
    
    do {
        imageData = try Data(contentsOf: bundleURL)
    } catch let error {
        print(error.localizedDescription)
        return nil
    }
    
    return createAnimatedImage(data: imageData)
  } // end of static func gif:name:
  
  
  //MARK: - Convert GIF into multiple images for iOS animated image
  private static func createAnimatedImage(data: Data) -> UIImage? {
    // Create source from data
    guard let source  = CGImageSourceCreateWithData(data as CFData, nil) else {
      print("Source for the image does not exist")
      return nil
    }

    var frames       = [UIImage]()
    let count        = CGImageSourceGetCount(source)
    let delaySeconds = delayForImageAtIndex(0, source: source)
    let duration     = Double(count) * delaySeconds
    
    // Build array with images
    for index in 0..<count {
      if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
        frames.append(UIImage(cgImage: image))
      }
    }
    // Create Animation
    return UIImage.animatedImage(with: frames, duration: duration)
  }
  

  //MARK: - Get delay time from GIF properties
  private static func delayForImageAtIndex(_ index: Int, source: CGImageSource) -> Double {
    
    var delay = 0.1 // Default time
    
    if let gifProperties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as Dictionary? {
        if let delayTime = gifProperties[kCGImagePropertyGIFDictionary as NSString]?[kCGImagePropertyGIFDelayTime as NSString] {
            delay = Double(truncating: delayTime as? NSNumber ?? 0.1)
        }
    }
    return delay
  }
  
} // end of extension

