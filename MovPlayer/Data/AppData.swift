//
//  AppData.swift
//  MovPlayer
//
//  Created by Marcy Vernon on 11/4/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//

import UIKit

struct AppData {
  
  let gifData: [(name: String, stillImageNumber: Int, bgColor: UIColor, contentMode: UIView.ContentMode, loops: Int, speed: Double)] =
    [
      ("Pig", 1, #colorLiteral(red: 0.5528588891, green: 0.7616898417, blue: 0.420261234, alpha: 1), .scaleAspectFit, 0, 1),
      ("BlueMoon", 1, .clear, .scaleToFill, 1, 1),
      ("CloudySun", 1, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , .scaleAspectFit, 1, 1),
      ("CatAnimated", 1, #colorLiteral(red: 0.8684641719, green: 0.8040748835, blue: 0.4735165238, alpha: 1) , .scaleAspectFit, 0, 1),
      ("GoldDog", 73, .black, .scaleAspectFit, 1, 1),
      ("Chick2", 1, #colorLiteral(red: 0.424493134, green: 0.3560110629, blue: 0.5905451179, alpha: 1) , .scaleAspectFill, 0, 1),
      ("GoldHouse", 1, #colorLiteral(red: 0.7893047929, green: 0.4369269609, blue: 0.5225962996, alpha: 1) , .scaleAspectFit, 1, 1),
      ("DesertAnimation3", 1, .clear, .scaleToFill, 1, 1),
      ("CloudySunColored", 1, #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) , .scaleAspectFit, 1, 1),
      ("Owl", 1, #colorLiteral(red: 0.424493134, green: 0.3560110629, blue: 0.5905451179, alpha: 1) , .scaleAspectFit, 0, 1),
      ("DogRun", 1, #colorLiteral(red: 0.5528588891, green: 0.7616898417, blue: 0.420261234, alpha: 1) , .scaleAspectFit, 0, 3),
    ]
}
