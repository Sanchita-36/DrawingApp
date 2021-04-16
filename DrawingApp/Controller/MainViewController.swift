    //
    //  MainViewController.swift
    //  DrawingApp
    //
    //  Created by Mac on 15/04/21.
    //  Copyright © 2021 Sanchita. All rights reserved.
    //
    
    import UIKit
    
    class MainViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
        
        @IBOutlet weak var colorCollectionView: UICollectionView!
        @IBOutlet weak var colorView: UIView!
        @IBOutlet weak var canvasView: CanvasView!
        @IBOutlet var pinchGesture: UIPinchGestureRecognizer!
        
        //arrayy of colors
        var colorArray: [UIColor] = [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), #colorLiteral(red: 0.09508886469, green: 0.9331450898, blue: 1, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.6660071931, green: 0.2693436678, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9565791629, green: 0.9686274529, blue: 0.1941664122, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.6940098517, green: 0.6005985704, blue: 0.8862745166, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            colorCollectionView.delegate = self
            colorCollectionView.dataSource = self
        }
        
        //To save the canvas drawing
        @IBAction func onClickSave(_ sender: UIButton) {
            let image = canvasView.takeScreenshot()
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextType:)), nil)
        }
        
        @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
            if error != nil {
                print("Unable to save the image.")
            }else {
                print("Image Saved.")
            }
        }
        
        //To clear the canvas drawing
        @IBAction func onClickClear(_ sender: UIButton) {
            canvasView.clearCanvasView()
        }
        
        //To increase - decrease the paintbrush stroke size
        @IBAction func brushSizeSlider(_ sender: UISlider) {
            canvasView.strokeWidth = CGFloat(sender.value)
        }
        
        //Too zoom in - zoom out the canvas sreen
        @IBAction func pinchGestureAction(_ sender: UIPinchGestureRecognizer) {
            guard let gesture = pinchGesture.view else{return}
            gesture.transform =  gesture.transform.scaledBy(x: pinchGesture.scale, y: pinchGesture.scale)
            pinchGesture.scale = 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return colorArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
            if let view = cell.viewWithTag(11) {
                view.backgroundColor = colorArray[indexPath.row]
                view.layer.cornerRadius = 3
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let color = colorArray[indexPath.row]
            colorView.backgroundColor = color
            canvasView.strokeColor = color
            colorView.layer.cornerRadius = 20
            
        }
    }
    
    extension UIView {
        //To save the image in local storage (Photos/Gallery)
        func takeScreenshot() -> UIImage {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false,UIScreen.main.scale)
            drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if image != nil {
                return image!
            }
            return UIImage()
        }
    }
