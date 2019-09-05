//
//  ViewController.swift
//  googleNews
//
//  Created by Станислава on 18.08.2019.
//  Copyright © 2019 Stminchuk. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UITableViewController {
    
    var pieceOfNews = [PieceOfNews]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        //let urlString = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=ae7cf38efb07483fa144376e08a71f89"
        //let urlString = "https://newsapi.org/v2/everything?q=apple&from=2019-08-18&to=2019-08-19&sortBy=popularity&apiKey=ae7cf38efb07483fa144376e08a71f89"
        
        
    switch navigationController?.tabBarItem.tag {
        case 0:
            urlString = "https://newsapi.org/v2/everything?q=Russia&from=2019-08-21&to=2019-08-21&sortBy=popularity&apiKey=ae7cf38efb07483fa144376e08a71f89"
        case 1:
            urlString = "https://newsapi.org/v2/everything?q=apple&from=2019-08-21&to=2019-08-21&sortBy=popularity&apiKey=ae7cf38efb07483fa144376e08a71f89"
        case 2:
            urlString = "https://newsapi.org/v2/everything?q=apple&from=2019-08-21&to=2019-08-21&sortBy=popularity&apiKey=ae7cf38efb07483fa144376e08a71f89"
        default:
            urlString = "https://newsapi.org/v2/everything?q=apple&from=2019-08-21&to=2019-08-21&sortBy=popularity&apiKey=ae7cf38efb07483fa144376e08a71f89"
    }
       /*
        if navigationController?.tabBarItem.tag == 0 {
            //urlString = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=ae7cf38efb07483fa144376e08a71f89"
            urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ae7cf38efb07483fa144376e08a71f89"
        } else {
            urlString = "https://newsapi.org/v2/everything?q=apple&from=2019-08-21&to=2019-08-21&sortBy=popularity&apiKey=ae7cf38efb07483fa144376e08a71f89"
        }
        
        */
        
        if let url = URL(string: urlString) {
            //convert url to data instance
            if let data = try? Data(contentsOf: url) {
                //we're OK to parse data
                parse(json: data)
            } else {
                showError()
            }
        } else {
            showError()
        }
    }
    
    func parse(json: Data) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            let decoder = JSONDecoder()
            if let jsonGoogleNews = try? decoder.decode(News.self, from: json) {
                self?.pieceOfNews = jsonGoogleNews.articles
        }
       
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "Please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
        
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pieceOfNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = pieceOfNews[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.description
        
        //let height = tableView.rowHeight
        //let size = CGSize(width: 300, height: height)
        //cell.imageView?.frame = CGRect(x:0.0,y:0.0,width:2.0,height: height)
        //cell.imageView?.widthAnchor.constraint(equalToConstant: 20)
        //cell.imageView?.transform = CGAffineTransform(translationX: 20, y: 20)
        //cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.layer.cornerRadius = 4.0
        cell.imageView?.layer.masksToBounds = true
        let data = try? Data(contentsOf: article.urlToImage)
        if let imageData = data {
            let image = UIImage(data: imageData)
            
            cell.imageView?.image = image?.resize(toTargetSize: CGSize(width: 83, height: 83))
           
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = pieceOfNews[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIImage {
    
    func resize(toTargetSize targetSize: CGSize) -> UIImage {
        
        let newScale = self.scale // change this if you want the output image to have a different scale
        let originalSize = self.size
        
        let widthRatio = targetSize.width / originalSize.width
        let heightRatio = targetSize.height / originalSize.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: floor(originalSize.width * heightRatio), height: floor(originalSize.height * heightRatio))
        } else {
            newSize = CGSize(width: floor(originalSize.width * widthRatio), height: floor(originalSize.height * widthRatio))
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale
        format.opaque = true
        let newImage = UIGraphicsImageRenderer(bounds: rect, format: format).image() { _ in
            self.draw(in: rect)
        }
        
        return newImage
    }
}

