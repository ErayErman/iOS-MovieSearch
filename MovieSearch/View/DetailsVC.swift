//
//  DetailsVC.swift
//  MovieSearch
//
//  Created by Eray on 26.09.2022.
//

import UIKit

class DetailsVC: UIViewController {

    var data: Displayable?
    var listData: [Displayable] = []
    
    @IBOutlet weak var plotText: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var imdbButton: UIButton!
    
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lookImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.plotText.text = data?.plotLabelText
        self.titleLabel.text = data?.titleLabelText
        self.yearLabel.text = data?.yearLabelText
        let imageURL = URL(string: data!.posterURLLabelText)
        if let imageData = try? Data(contentsOf: imageURL!) {
            posterView.image = UIImage(data: imageData)
        }
        fetchMoreInformation()
    }
    
    func fetchMoreInformation() {
        
        let vm = ViewModel()
        vm.getMovieDetailByIMDbID(imdbID: data!.imdbIDText) { (d, fetched) in
            if (fetched) {
                self.plotText.text = d?.plotLabelText
                self.directorLabel.text = d?.directorLabelText
            }
        }
    }
    
    
    @IBAction func didClickedImdbButton(_ sender: Any) {
        let imdbURL = "https://www.imdb.com/title/" + data!.imdbIDText + "/"
        guard let url = URL(string: imdbURL) else { return }
        UIApplication.shared.open(url)
    }
    
}
