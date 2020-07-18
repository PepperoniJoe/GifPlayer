//
//  SingleViewController.swift
//  MovPlayer
//
//  Created by Marcy Vernon on 7/17/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//


import UIKit

class SingleViewController: UIViewController {
  
  private let gifData     = AppData().gifData
  private let display     = GifDisplay()
  
  @IBOutlet weak var collectionViewGifs: UICollectionView!

      override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewGifs.dataSource = self
        collectionViewGifs.delegate = self
      }
  
} // end of SingleViewController()



//MARK: - UICollectionViewDataSource
extension SingleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! SingleCell

        let i = indexPath.row
        cell.backgroundColor = gifData[i].bgColor

        display.displayGif(imageView              : cell.imageviewCell,
                                 name             : gifData[i].name,
                                 stillImageNumber : gifData[i].stillImageNumber,
                                 bgColor          : gifData[i].bgColor,
                                 contentMode      : gifData[i].contentMode,
                                 loops            : gifData[i].loops,
                                 speed            : gifData[i].speed)
        return cell
    }
}


//MARK: - UICollectionViewDelegate
extension SingleViewController: UICollectionViewDelegate {
    
      func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {return true}
      func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {return true}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SingleCell else { return }
        if let imageView = cell.imageviewCell {
            imageView.isAnimating ?  imageView.stopAnimating() : imageView.startAnimating()
        }
    }
    
}

