//
//  ViewController.swift
//  MovPlayer
//
//  Created by Marcy Vernon on 10/31/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//

import UIKit

class MultipleViewController: UIViewController {
  
  private let gifData = AppData().gifData
  private let display = GifDisplay()
  
  @IBOutlet var gifs: [UIImageView]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buildAllImageViews()
    addTapGestures()
  }

  
  private func buildAllImageViews() {
    
    let count = gifs.count > gifData.count ? gifData.count : gifs.count
    
    for i in 0..<count {
      display.displayGif(imageView        : gifs[i],
                         name             : gifData[i].name,
                         stillImageNumber : gifData[i].stillImageNumber,
                         bgColor          : gifData[i].bgColor,
                         contentMode      : gifData[i].contentMode,
                         loops            : gifData[i].loops,
                         speed            : gifData[i].speed)
    }
  }
  
  
  private func addTapGestures() {
    
    for gif in gifs {
      let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
      gif.addGestureRecognizer(tap)
    }
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    let tappedGif = gifs[sender?.view?.tag ?? 0]
    tappedGif.isAnimating ? tappedGif.stopAnimating() : tappedGif.startAnimating()
  }
}




