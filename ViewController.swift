//
//  ViewController.swift
//  My2048
//
//  Created by eyal avisar on 08/09/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//


import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4 - 4, height: collectionView.frame.height / 4 - 4)
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var numbersCollection: UICollectionView!
    
    var squaresContent = Array(repeating: 0, count: 15)
    var lastPressed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersCollection.delegate = self
        numbersCollection.dataSource = self
        let value = Bool.random() ? 2 : 4
        squaresContent.append(value)
        squaresContent.shuffle()
        
        // Swipe (right and left)
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        
        swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
        
        swipeUpGesture.direction = UISwipeGestureRecognizer.Direction.up
        swipeDownGesture.direction = UISwipeGestureRecognizer.Direction.down
        
        view.addGestureRecognizer(swipeRightGesture)
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeUpGesture)
        view.addGestureRecognizer(swipeDownGesture)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            getNewTileContent()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.backgroundColor = .yellow
        cell.setup(cellNumber: indexPath.row)
        
        if squaresContent[indexPath.row] != 0 {
            cell.pointsLabel.text = String(squaresContent[indexPath.row])
            cell.pointsLabel.tintColor = .blue
        }
        return cell
    }
    
    
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {

//enter code here to sum squares if possible

        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            var index = 0
            while index <= 14 {
                if index % 4 < 3 && squaresContent[index + 1] == 0 && squaresContent[index] != 0{
                    squaresContent[index + 1] = squaresContent[index]
                    squaresContent[index] = 0
                    index += 1
                    print(squaresContent)
                    continue
                }
                if index % 4 < 3 && squaresContent[index + 1] == squaresContent[index] {
                    squaresContent[index + 1] *= 2
                    squaresContent[index] = 0
                    index += 2
                    print("\(squaresContent), \(index)")
                    continue
                }
                index += 1
            }
            
            print("swipe right")
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left
        {
            var index = 15
            while index >= 1 {
                if index % 4 > 0 && squaresContent[index - 1] == 0 && squaresContent[index] != 0{
                    squaresContent[index - 1] = squaresContent[index]
                    squaresContent[index] = 0
                    index -= 1
                    print(squaresContent)
                    continue
                }
                if index % 4 > 0 && squaresContent[index - 1] == squaresContent[index] {
                    squaresContent[index - 1] *= 2
                    squaresContent[index] = 0
                    index -= 2
                    print("\(squaresContent), \(index)")
                    continue
                }
                index -= 1
            }

            print("swipe left")
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.up
        {
            //start summing from top most
            //work with a for loop on 0,4,8,12 1...13 2...14 3...15 use mod 4
            print("swipe up")
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.down
        {
            //start summing from bottom most
            //work with a for loop on 0,4,8,12 1...13 2...14 3...15 use mod 4
            print("swipe down")
        }
        self.numbersCollection.reloadData()
    }
    
    func getNewTileContent() {
        var insertedANumber = false
        while !insertedANumber {
            let index = Int.random(in: 0..<16)
            if squaresContent[index] == 0 {
                squaresContent[index] = Bool.random() ? 2 : 4
                insertedANumber = true
            }
        }
    }
    
}

