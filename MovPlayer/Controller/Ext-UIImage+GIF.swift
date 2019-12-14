//
//  Ext-UIImage+GIF.swift
//  MovPlayer
//
//  Created by Arne Bahlo on 07.06.14.
//  Copyright (c) 2014 Arne Bahlo. All rights reserved.
//  Updated for Swift 5 by Marcy Vernon
//
import UIKit
import ImageIO

//MARK: Extension for creating animated images from GIF files
extension UIImage {
  
  //--------------------------------------------------
  //MARK: Preferred: Get GIF files from Assets catalog
  static func gif(asset: String) -> UIImage? {
    guard let dataAsset = NSDataAsset(name: asset) else {
      print("Cannot turn image named \"\(asset)\" into NSDataAsset. Check file spelling and case.")
      return nil
    }
    
    return createAnimatedImage(data: dataAsset.data)
  } // end of static func gif:asset:
  
  
  //--------------------------------------------------
  //MARK: Alternative: Get GIF files from target file
  static func gif(name: String) -> UIImage? {
    // Check for existance of gif
    guard let bundleURL = Bundle.main
      .url(forResource: name, withExtension: "gif") else {
        print("This gif named \"\(name)\" does not exist")
        return nil
    }
    
    // Validate data
    guard let imageData = try? Data(contentsOf: bundleURL) else {
      print("Cannot turn gif named \"\(name)\" into Data. Check file spelling and case.")
      return nil
    }
    
    return createAnimatedImage(data: imageData)
  } // end of static func gif:name:
  
  
  //--------------------------------------------------
  //MARK: Convert GIF into multiple images for iOS animated image
  private static func createAnimatedImage(data: Data) -> UIImage? {
    // Create source from data
    guard let source  = CGImageSourceCreateWithData(data as CFData, nil) else {
      print("Source for the image does not exist")
      return nil
    }

    var frames = [UIImage]()
    let count = CGImageSourceGetCount(source)
    let delaySeconds = delayForImageAtIndex(0, source: source)
    let duration = Double(count) * delaySeconds
    
    // Build array with images
    for index in 0..<count {
      if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
        frames.append(UIImage(cgImage: image))
      }
    }
    // Create Animation
    return UIImage.animatedImage(with: frames, duration: duration)
  }
  
  //--------------------------------------------------
  //MARK: Get delay time from GIF properties
  private static func delayForImageAtIndex(_ index: Int, source: CGImageSource) -> Double {
    
    var delay = 0.1 // Default time
    
    if let gifProperties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as Dictionary? {
        if let delayTime = gifProperties[kCGImagePropertyGIFDictionary as NSString]?[kCGImagePropertyGIFDelayTime as NSString] {
            delay = Double(truncating: delayTime as? NSNumber ?? 0.1)
        }
    }
    
    //print("the image delay is: \(delay)")
    return delay
  }
  
} // end of extension

