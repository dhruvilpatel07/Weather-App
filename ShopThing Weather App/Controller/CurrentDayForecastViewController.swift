//
//  CurrentDayForecastViewController.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import UIKit

class CurrentDayForecastViewController: UIViewController {

    @IBOutlet weak var textFieldSearchCity: UITextField!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblWeatherState: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var imgViewWeatherState: UIImageView!
    
    var weatherAPI = WeatherAPI()
    var fiveDayForecastViewModel: FiveDayForecastViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        weatherAPI.delegate = self
        textFieldSearchCity.delegate = self
        
        weatherAPI.fetchWeather(cityName: "Toronto")
    }
    
    /// Calls this method when search button is pressed
    /// - Parameter sender: UIButton
    @IBAction func searchPressed(_ sender: UIButton) {
        
        if let city = textFieldSearchCity.text, textFieldSearchCity.text != "" {
            weatherAPI.fetchWeather(cityName: city)
            textFieldSearchCity.text = ""
        } else {
            displayAlertSheetWithMessage(with: "Please enter city name!")
        }
    }
    
    /// Calls this method when 5 day forecast button is pressed
    /// - Parameter sender: UIButton
    @IBAction func fiveDayForecastPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "checkFiveDayWeather", sender: self)
    }
    
    func displayAlertSheetWithMessage(with errorMessage: String) {
        textFieldSearchCity.placeholder = "Please enter city name"
        let alert = UIAlertController(title: "Opss!!", message: errorMessage, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkFiveDayWeather" {
            let destinationVC = segue.destination as! FiveDayForecastViewController
            destinationVC.fiveDayForecastViewModel = fiveDayForecastViewModel
        }
    }
    
}

//MARK: - WeatherAPIDelegate
extension CurrentDayForecastViewController: WeatherAPIDelegate {
    func didUpdateWeather(_ weatherAPI: WeatherAPI, weatherViewModel: WeatherViewModel) {
        DispatchQueue.main.async { [self] in
            let consolidatedWeather = weatherViewModel.weather.consolidated_weather
            fiveDayForecastViewModel = FiveDayForecastViewModel(consolidatedWeather: consolidatedWeather)
            imgViewWeatherState.loadImage(from: weatherViewModel.imageAbbURL)
            lblCityName.text = weatherViewModel.cityName
            lblWeatherState.text = weatherViewModel.weatherState
            lblCurrentTemp.text = weatherViewModel.currentTemp
            lblMaxTemp.text = weatherViewModel.maxTemp
            lblMinTemp.text = weatherViewModel.minTemp
            
        }
    }
    
    func didFailWithError(error: Error, errorMessage: String) {
        displayAlertSheetWithMessage(with: errorMessage)
    }
}

//MARK: - UITextFieldDelegate
extension CurrentDayForecastViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = "Enter city name"
    }
}
