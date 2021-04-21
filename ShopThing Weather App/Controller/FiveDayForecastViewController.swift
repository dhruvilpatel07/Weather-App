//
//  FiveDayForecastViewController.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import UIKit

class FiveDayForecastViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var weatherTableView: UITableView!
    
    var fiveDayForecastViewModel: FiveDayForecastViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        //Removes today's weather info so it doesn't display in 5 day forecast table
        fiveDayForecastViewModel?.consolidatedWeather.remove(at: 0)
    }

}
//MARK: - UITableViewDataSource
extension FiveDayForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDayForecastViewModel?.consolidatedWeather.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FiveDayForecastTableViewCell
        let weather = fiveDayForecastViewModel?.consolidatedWeather[indexPath.row]
        cell.consolidatedWeatherViewModel = ConsolidatedWeatherViewModel(consolidatedWeather: weather!)
        return cell
    }
    
    
}



