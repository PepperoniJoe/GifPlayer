////  Gif.swift
//  SwiftGif
//
//  Created by Arne Bahlo on 07.06.14.
//  Copyright (c) 2014 Arne Bahlo. All rights reserved.
//
//import UIKit
//import ImageIO
//
//extension UIImage {
//
//  //--------------------------------------------------
//  //MARK: Preferred: Get GIF files from Assets catalog
//  static func gif(asset: String) -> UIImage? {
//    guard let dataAsset = NSDataAsset(name: asset) else {
//      print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
//      return nil
//    }
//
//    return gif(data: dataAsset.data)
//  } // end of static func gif:asset:
//
//
//  //--------------------------------------------------
//  //MARK: Alternative: Get GIF files from target file
//  static func gif(name: String) -> UIImage? {
//    // Check for existance of gif
//    guard let bundleURL = Bundle.main
//      .url(forResource: name, withExtension: "gif") else {
//        print("SwiftGif: This image named \"\(name)\" does not exist")
//        return nil
//    }
//
//    // Validate data
//    guard let imageData = try? Data(contentsOf: bundleURL) else {
//      print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
//      return nil
//    }
//
//    return gif(data: imageData)
//  } // end of static func gif:name:
//
//
//  //--------------------------------------------------
//  //MARK: Convert GIF into multiple images for iOS
//  static func gif(data: Data) -> UIImage? {
//    // Create source from data
//    guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
//      print("SwiftGif: Source for the image does not exist")
//      return nil
//    }
//    return UIImage.animatedImageWithSource(source)
//  } // end of static func gif:data:
//
//
//  private class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
//
//    var images = [CGImage]()
//    var delays = [Int]()
//    var frames = [UIImage]()
//
//    let count = CGImageSourceGetCount(source)
//
//    var frame: UIImage
//    var frameCount: Int
//
//    // Build array with images
//    for index in 0..<count {
//      // Add image
//      if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
//        images.append(image)
//      }
//
//      // Create a delay for each image
//      let delaySeconds = UIImage.delayForImageAtIndex(Int(index), source: source)
//      delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
//    }
//
//    let gcd = gcdForArray(delays)
//    // Get frames
//    for index in 0..<count {
//      frame = UIImage(cgImage: images[Int(index)])
//      frameCount = Int(delays[Int(index)] / gcd)
//
//      for _ in 0..<frameCount {
//        frames.append(frame)
//      }
//    }
//
//    // Calculate full duration
//    let duration: Int = {
//      var sum = 0
//
//      for val: Int in delays {
//        sum += val
//      }
//
//      return sum
//    }()
//
//    // Create Animation
//
//    let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
//    return animation
//  }
//
//
//
//  private class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
//    var delay = 0.1
//
//    // Get dictionaries
//    let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
//    let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
//    defer {
//      gifPropertiesPointer.deallocate()
//    }
//    let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
//    if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
//      return delay
//    }
//
//    let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
//
//    // Get delay time
//    var delayObject: AnyObject = unsafeBitCast(
//      CFDictionaryGetValue(gifProperties,
//                           Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
//      to: AnyObject.self)
//
//    /* CFDictionary implements a container which pairs pointer-sized keys with pointer-sizeed values. Values are accessed via arbitrary user-defined keys.
//     */
//    if delayObject.doubleValue == 0 {
//      delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
//                    Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
//    }
//
//    if let delayObject = delayObject as? Double, delayObject > 0 {
//      delay = delayObject
//    } else {
//      delay = 0.1 // Make sure they're not too fast
//    }
//
//    return delay
//  }
//
//
//  private class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
//    var lhs = lhs
//    var rhs = rhs
//    // Check if one of them is nil
//    if rhs == nil || lhs == nil {
//      if rhs != nil {
//        return rhs!
//      } else if lhs != nil {
//        return lhs!
//      } else {
//        return 0
//      }
//    }
//
//    // Swap for modulo
//    if lhs! < rhs! {
//      let ctp = lhs
//      lhs = rhs
//      rhs = ctp
//    }
//
//    // Get greatest common divisor
//    var rest: Int
//    while true {
//      rest = lhs! % rhs!
//
//      if rest == 0 {
//        return rhs! // Found it
//      } else {
//        lhs = rhs
//        rhs = rest
//      }
//    }
//  }
//
//  private class func gcdForArray(_ array: [Int]) -> Int {
//
//    if array.isEmpty {
//      return 1
//    }
//
//    var gcd = array[0]
//
//    for val in array {
//      gcd = UIImage.gcdForPair(val, gcd)
//    }
//
//    return gcd
//  }
//
//
//
//}
//
//
