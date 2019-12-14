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
      ("pig", 1, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), .scaleAspectFit, 0, 1),
      ("6233-honey-bee", 1, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), .scaleAspectFit, 0, 4),
      ("WalkingTest", 1, .white, .scaleAspectFit, 0, 3),
    //  ("Coworkers", 1, .white, .scaleAspectFit, 1, 1),
      ("DesertAnimation3", 1, .clear, .scaleToFill, 1, 1),
      ("GoldDog", 73, .clear, .scaleAspectFit, 1, 1),
      ("BlueMoon", 1, .clear, .scaleToFill, 1, 1),
    //  ("CloudySun", 1, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , .scaleAspectFit, 1, 1),
      ("cat", 1, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , .scaleAspectFit, 0, 1),
      ("8840-sheep-in-the-middle-of-rain", 1, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), .scaleAspectFit, 1, 1),
      ("8841-running-sheep-with-chart-loader", 1, .white, .scaleAspectFit, 1, 1),
      ("7929-run-man-run", 1, .white, .scaleAspectFit, 0, 1.4),
      ("CloudySunColored", 1, #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) , .scaleAspectFit, 0, 1),
      ("Chick2", 1, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , .scaleAspectFill, 0, 1),
      ("GoldHouse", 1, .clear, .scaleAspectFit, 1, 1),
    ]
}
