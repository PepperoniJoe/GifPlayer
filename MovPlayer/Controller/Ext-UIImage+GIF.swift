//
//  Gif.swift
//  SwiftGif
//
//  Created by Arne Bahlo on 07.06.14.
//  Copyright (c) 2014 Arne Bahlo. All rights reserved.
//
import UIKit
import ImageIO

extension UIImage {
  
  //--------------------------------------------------
  //MARK: Preferred: Get GIF files from Assets catalog
  static func gif(asset: String) -> UIImage? {
    guard let dataAsset = NSDataAsset(name: asset) else {
      print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
      return nil
    }
    
    return gif(data: dataAsset.data)
  } // end of static func gif:asset:
  
  
  //--------------------------------------------------
  //MARK: Alternative: Get GIF files from target file
  static func gif(name: String) -> UIImage? {
    // Check for existance of gif
    guard let bundleURL = Bundle.main
      .url(forResource: name, withExtension: "gif") else {
        print("SwiftGif: This image named \"\(name)\" does not exist")
        return nil
    }
    
    // Validate data
    guard let imageData = try? Data(contentsOf: bundleURL) else {
      print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
      return nil
    }
    
    return gif(data: imageData)
  } // end of static func gif:name:
  
  
  //--------------------------------------------------
  //MARK: Convert GIF into multiple images for iOS animated image
  static func gif(data: Data) -> UIImage? {
    // Create source from data
    guard let source  = CGImageSourceCreateWithData(data as CFData, nil) else {
      print("Source for the image does not exist")
      return nil
    }
    return animatedImageWithSource(source)
  } // end of static func gif:data:
  
  
//--------------------------------------------------
//MARK: Convert gif to animation
  static func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {

    var images = [CGImage]()
    var delays = [Int]()
    var frames = [UIImage]()
    
    let count = CGImageSourceGetCount(source)

    var frame: UIImage
    var frameCount: Int
    
    // Build array with images
    for index in 0..<count {
      // Add image
      if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
        images.append(image)
      }
      
      // Create a delay for each image
      let delaySeconds = delayForImageAtIndex(Int(index), source: source)
      //  print("delaySeconds", delaySeconds)
      delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
    }
    
    let gcd = gcdForArray(delays)
    
    // Get frames
    for index in 0..<count {
      frame = UIImage(cgImage: images[index])
      frameCount = delays[index] / gcd
    //  print(frameCount) // Always 1???????????????????
      for _ in 0..<frameCount {
        frames.append(frame)
      }
    }
    
    // Calculate full duration in millisecs
    let duration = Double(delays.reduce(0, + )) / 1000.0
  
    // Create Animation
    return UIImage.animatedImage(with: frames, duration: duration)
  }
  
  
  //--------------------------------------------------
  //MARK:
  static func delayForImageAtIndex(_ index: Int, source: CGImageSource) -> Double {
    var delay = 0.1
    
    // Get dictionaries
    let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
    let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
    defer {
      gifPropertiesPointer.deallocate()
    }
    let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
    if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
      return delay
    }
    
    let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
    
    // Get delay time
    var delayObject: AnyObject = unsafeBitCast(
      CFDictionaryGetValue(gifProperties,
                           Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
      to: AnyObject.self)
    
    /* CFDictionary implements a container which pairs pointer-sized keys with pointer-sizeed values. Values are accessed via arbitrary user-defined keys.
     */
    if delayObject.doubleValue == 0 {
      delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                    Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
    }
    
    if let delayObject = delayObject as? Double, delayObject > 0 {
      delay = delayObject
    } else {
      delay = 0.1 // Make sure they're not too fast
    }
    
    return delay
  }
  
  //--------------------------------------------------
  //MARK: Gets greatest common denominator
    
    static func gcdForArray(_ array: [Int]) -> Int {
      if array.isEmpty { return 1 }
      
      var gcd = array[0]
      
      for value in array {
        gcd = gcdForPair(value, gcd)
      }
      
      return gcd
    }
    
    
    static func gcdForPair(_ lhs: Int, _ rhs: Int) -> Int {
        let remainder = lhs % rhs
        return remainder != 0 ? gcdForPair(rhs, remainder) : rhs
    }
    

} // end of extension

