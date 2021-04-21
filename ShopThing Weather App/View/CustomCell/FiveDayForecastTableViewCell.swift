//
//  FiveDayForecastTableViewCell.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import UIKit

class FiveDayForecastTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgWeatherState: UIImageView!
    @IBOutlet weak var lblWeatherState: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    
    var consolidatedWeatherViewModel: ConsolidatedWeatherViewModel! {
        didSet {
            imgWeatherState.loadImage(from: consolidatedWeatherViewModel.imageAbbURL)
            lblWeatherState.text = consolidatedWeatherViewModel.weatherState
            lblDate.text = consolidatedWeatherViewModel.date
            lblMaxTemp.text = consolidatedWeatherViewModel.maxTemp
            lblMinTemp.text = consolidatedWeatherViewModel.minTemp
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
