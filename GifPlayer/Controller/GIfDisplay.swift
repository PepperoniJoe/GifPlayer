//
//  GIfDisplay.swift
//  MovPlayer
//
//  Created by Marcy Vernon on 11/5/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//

import UIKit

struct GifDisplay {
  /*
   Parameters:
   > imageView - View that will display GIF
   > gif - Name of the gif file. Do not include .gif file extension in name.
   > stillImageNumber - Optional integer that designates one image in the gif to use as the still image. This number corresponds to the image in the file, NOT THE INDEX. Default is 1, the first image.
   > bgColor - Background color of the imageView. Default is .clear
   > contentMode - Determines how the Gif should be scaled within the UIImageView. Default is .scaleAspectFit.
   > loops - Number of times the gif should play. Use 0 to loop infinitely. Default is 1 to play once.
   */
  
  func displayGif(
    imageView        : UIImageView,
    name             : String,
    stillImageNumber : Int                = 1,
    bgColor          : UIColor            = .clear,
    contentMode      : UIView.ContentMode = .scaleAspectFit,
    loops            : Int                = 1,
    speed            : Double             = 1) {
    
    guard let gif = UIImage.gif(asset: name) ?? UIImage.gif(name: name) else { return }

    imageView.contentMode          = contentMode
    imageView.backgroundColor      = bgColor
    imageView.animationImages      = gif.images
    imageView.animationRepeatCount = loops
    
    let duration = gif.duration
    imageView.animationDuration = duration / speed
  
    // get the still image for animation. Default uses the first image
    if stillImageNumber > 0 {
      let stillImageIndex = stillImageNumber - 1
      if imageView.animationImages?.count ?? 0 > stillImageIndex {
        imageView.image = imageView.animationImages?[stillImageIndex]
      }
    }
  }
}
