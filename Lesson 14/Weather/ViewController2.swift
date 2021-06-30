//
//  ViewController.swift
//  lesson 12
//
//  Created by Левон Амбарцумян on 04.05.2021.
//

import UIKit
import RealmSwift

class ViewController2: UIViewController {
    
    var currentTemperaturess: CurrentTemperature = CurrentTemperature()
    let realm = try! Realm()
    var city: Results<City>!
    var list: Results<Lists>!
   // var weather: Results<Weather>!
   // var main: Results<Main>!
   // var wind: Results<Wind>!
    
    var lists: [Lists] = []

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var nameCurrentLabel: UILabel!
    @IBOutlet weak var tempCurrentLabel: UILabel!
    @IBOutlet weak var cloudyLabel: UILabel!
    @IBOutlet weak var maxAndMinTempLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    var resutLabelArray: [String] = []
    var infoLabelArray: [String] = []
    
    func cityUp(city: Results<City>){
        self.nameCurrentLabel.text = city[0].name
    }
    
    func upDateTemperature(list: Results<Lists>) {
        
        //self.currentTemperaturess = currentTemperatures
        
        self.tempCurrentLabel.text = String(Int(list[0].main!.temp)) + "º"
        self.cloudyLabel.text = DataSource.weatherIDs[list[0].weather[0].id]
        self.maxAndMinTempLabel.text = "Макс. \(Int(list[0].main!.temp_max))º, мин. \(Int(list[0].main!.temp_min))º"
        
        let weathersTwo = list[0]
        var degs = ""
        
        
        switch weathersTwo.wind!.deg {
        case 0,360:
            degs = "северный"
        case 1...89:
            degs = "северо-восточный"
        case 90:
            degs = "восточный"
        case 91...179:
            degs = "юго-восточный"
        case 180:
            degs = "южный"
        case 181...269:
            degs = "юго-западный"
        case 270:
            degs = "западный"
        case 271...359:
            degs = "северо-западный"
        default: break
        }
        
        self.infoLabel.text = "Сегодня: \(DataSource.weatherIDs[weathersTwo.weather[0].id]!), скорость ветра \(Int(weathersTwo.wind!.speed)) м/с, ветер \(degs). Максимальная температура воздуха \(Int(weathersTwo.main!.temp_max))º, минимальная температура воздуха \(Int(weathersTwo.main!.temp_min))º. Влажность \(weathersTwo.main!.humidity) %"
        self.resutLabelArray = ["\(Int(weathersTwo.pop * 100)) %","\(weathersTwo.main!.humidity) %","\(Int(weathersTwo.wind!.speed)) м/с, \(degs)","\(Int(weathersTwo.main!.feels_like))º","\(Int(round(weathersTwo.main!.pressure * 0.750063755419211))) мм рт. ст.","\(weathersTwo.visibility / 1000) км."]
        self.infoLabelArray = ["вероятность дождя","влажность","ветер","ощущается как","даление","видимость"]
        

        self.TableView.reloadData()
 
        
        
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        list = self.realm.objects(Lists.self)
        city = self.realm.objects(City.self)

        CurrentTemperatureLoader().loadCurrentTemperature2() { currentTemperatures in
           
          //  self.city = self.realm.objects(City.self)
           // self.main = self.realm.objects(Main.self)
           // self.weather = self.realm.objects(Weather.self)//
//self.wind = self.realm.objects(Wind.self)
            self.list = self.realm.objects(Lists.self)
            self.city = self.realm.objects(City.self)
            for i in currentTemperatures.list {

                self.lists.append(i)

            }
           // print(self.lists)
            let city = City()

            if self.city.count == 0{
            
            
                city.name = currentTemperatures.city.name
                try! self.realm.write {
                    self.realm.add(city)
                }
                print("Условие города 1")

            }else{
                try! self.realm.write {
                    self.city[0].name = currentTemperatures.city.name
                }
                print("Условие города 2")
            }
            print(self.city)
            
           //// self.list = self.realm.objects(Lists.self)
            
            print(self.lists.count)
            
            func upWetherList(i: Int, list: Lists) {

                list.dt = self.lists[i].dt
                list.visibility = currentTemperatures.list[i].visibility
                list.pop = currentTemperatures.list[i].pop
                
               // list.weather[0].icon = currentTemperatures.list[i].weather[0].icon
               // list.weather[0].main = currentTemperatures.list[i].weather[0].main
                
                
                list.main!.temp = currentTemperatures.list[i].main!.temp
                list.main!.temp_min = currentTemperatures.list[i].main!.temp_min
                list.main!.temp_max = currentTemperatures.list[i].main!.temp_max
                list.main!.pressure = currentTemperatures.list[i].main!.pressure
                list.main!.humidity = currentTemperatures.list[i].main!.humidity
                list.main!.feels_like = currentTemperatures.list[i].main!.feels_like
                
                list.wind!.speed = currentTemperatures.list[i].wind!.speed
                list.wind!.deg = currentTemperatures.list[i].wind!.deg
                //list.weather[0].icon = currentTemperatures.list[i].weather[0].icon
                list.weather = currentTemperatures.list[i].weather

                


            }
            let list = Lists()

            if self.list.count == 0 {
                for (i, _) in self.lists.enumerated() {
                  //  let list = Lists()

                    upWetherList(i: i, list: list)
                    
//                    for ex in self.lists[i].weather.enumerated() {
//
//                        list.weather = currentTemperatures.list[i].weather
//                        try! self.realm.write {
//                            self.realm.add(list)
//                           // city.name = currentTemperatures.city.name
//                        }
//                        print(list.weather)
//                       // print(self.weather[0].icon)
//
//                    }
                    
                    try! self.realm.write {
                        self.realm.add(list)
                       // city.name = currentTemperatures.city.name
                    }

                }
                print("условие 1")

                
            }else{
                for (i, _) in self.list.enumerated() {
                   // let list = Lists()

                    try! self.realm.write {
                        //self.realm.add(list)
                        upWetherList(i: i, list: self.list[i])
//                        list.dt = self.lists[i].dt
//                        list.visibility = currentTemperatures.list[i].visibility
//                        list.pop = currentTemperatures.list[i].pop
//
//                       // list.weather[0].icon = currentTemperatures.list[i].weather[0].icon
//                       // list.weather[0].main = currentTemperatures.list[i].weather[0].main
//
//
//                        list.main!.temp = currentTemperatures.list[i].main!.temp
//                        list.main!.temp_min = currentTemperatures.list[i].main!.temp_min
//                        list.main!.temp_max = currentTemperatures.list[i].main!.temp_max
//                        list.main!.pressure = currentTemperatures.list[i].main!.pressure
//                        list.main!.humidity = currentTemperatures.list[i].main!.humidity
//                        list.main!.feels_like = currentTemperatures.list[i].main!.feels_like
//
//                        list.wind!.speed = currentTemperatures.list[i].wind!.speed
//                        list.wind!.deg = currentTemperatures.list[i].wind!.deg
//                        //list.weather[0].icon = currentTemperatures.list[i].weather[0].icon
//                        list.weather = currentTemperatures.list[i].weather
                    }


                }
                print("Условие 2")
                
            }
          //  print(self.list)


            

           // self.list = self.realm.objects(Lists.self)
            
           // print(self.list)
            
//            if self.list.count == 0 {
//                try! self.realm.write {
//                    self.realm.add(list)
//                   // city.name = currentTemperatures.city.name
//                }
//            }else{
//                try! self.realm.write {
//                   // self.realm.add(city)
//                    for (i, _) in currentTemperatures.list.enumerated() {
//
//                        list.dt = currentTemperatures.list[i].dt
//                        list.visibility = currentTemperatures.list[i].visibility
//                        list.pop = currentTemperatures.list[i].pop
//
//                      //  list.weather[0].icon = currentTemperatures.list[i].weather[0].icon
//                       // list.weather[0].main = currentTemperatures.list[i].weather[0].main
//
//
//                        list.main!.temp = currentTemperatures.list[i].main!.temp
//                        list.main!.temp_min = currentTemperatures.list[i].main!.temp_min
//                        list.main!.temp_max = currentTemperatures.list[i].main!.temp_max
//                        list.main!.pressure = currentTemperatures.list[i].main!.pressure
//                        list.main!.humidity = currentTemperatures.list[i].main!.humidity
//                        list.main!.feels_like = currentTemperatures.list[i].main!.feels_like
//
//                        list.wind!.speed = currentTemperatures.list[i].wind!.speed
//                        list.wind!.deg = currentTemperatures.list[i].wind!.deg
//                    }
//                }
//            }
            
            
          //  list.dt = currentTemperatures.list.
            //main.d
//            if self.city.count == 0 {
//                try! self.realm.write {
//                    self.realm.add(city)
//                   // city.name = currentTemperatures.city.name
//                }
//            }else{
//                try! self.realm.write {
//                   // self.realm.add(city)
//                    self.city[0].name = "moskov" //currentTemperatures.city.name
//                }
//            }
//
//            for el in self.city {
//                 self.nameCurrentLabel.text = el.name
//            }
            
            
          self.currentTemperaturess = currentTemperatures
            self.upDateTemperature(list: self.list)
            self.cityUp(city: self.city)

//
//           // self.nameCurrentLabel.text = self.city.name
//            self.tempCurrentLabel.text = String(Int(self.currentTemperaturess.list[0].main.temp)) + "º"
//            self.cloudyLabel.text = DataSource.weatherIDs[currentTemperatures.list[0].weather[0].id]
//            self.maxAndMinTempLabel.text = "Макс. \(Int(currentTemperatures.list[0].main.temp_max))º, мин. \(Int(currentTemperatures.list[0].main.temp_min))º"
//
//            let weathersTwo = self.currentTemperaturess.list[0]
//            var degs = ""
//
//            switch weathersTwo.wind.deg {
//            case 0,360:
//                degs = "северный"
//            case 1...89:
//                degs = "северо-восточный"
//            case 90:
//                degs = "восточный"
//            case 91...179:
//                degs = "юго-восточный"
//            case 180:
//                degs = "южный"
//            case 181...269:
//                degs = "юго-западный"
//            case 270:
//                degs = "западный"
//            case 271...359:
//                degs = "северо-западный"
//            default: break
//            }
//
//            self.infoLabel.text = "Сегодня: \(DataSource.weatherIDs[weathersTwo.weather[0].id]!), скорость ветра \(Int(weathersTwo.wind.speed)) м/с, ветер \(degs). Максимальная температура воздуха \(Int(weathersTwo.main.temp_max))º, минимальная температура воздуха \(Int(weathersTwo.main.temp_min))º. Влажность \(weathersTwo.main.humidity) %"
//            self.resutLabelArray = ["\(Int(weathersTwo.pop * 100)) %","\(weathersTwo.main.humidity) %","\(Int(weathersTwo.wind.speed)) м/с, \(degs)","\(Int(weathersTwo.main.feels_like))º","\(Int(round(weathersTwo.main.pressure * 0.750063755419211))) мм рт. ст.","\(weathersTwo.visibility / 1000) км."]
//            self.infoLabelArray = ["вероятность дождя","влажность","ветер","ощущается как","даление","видимость"]
//
//
//            self.TableView.reloadData()
        
    }
        //city = self.realm.objects(City.self)
        //nameCurrentLabel.text = city[0].name
       // print(list)
        
        if list.count != 0 {
        
       // self.tempCurrentLabel.text = String(Int(list[0].main!.temp)) + "º"
       // self.cloudyLabel.text = DataSource.weatherIDs[list[0].weather[0].id]
      //  self.maxAndMinTempLabel.text = "Макс. \(Int(list[0].main!.temp_max))º, мин. \(Int(list[0].main!.temp_min))º"
       // print(self.lists.count)
            upDateTemperature(list: list)
            cityUp(city: city)
          //  print(list)
        }
        


    }


override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    }
}

extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
         let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! TableViewCell
          //  let weathersTwo = currentTemperaturess.list[0]
            cell.myTextLabel.text = infoLabel.text
        
        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! TableViewCell
            cell.myTextLabel.text = ""
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sections = 0
        if section == 0{
            sections = list.count
          //  print(currentTemperaturess.list.count)
        }else{
            sections = infoLabelArray.count
        }
        return sections
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as! CurrentTemperatureCell
        let weathers = list[indexPath.row]
        let datas = NSDate(timeIntervalSince1970: TimeInterval(list[indexPath.row].dt))
       // var array: [String] = [String(currentTemperaturess.list[0].wind.deg), String(currentTemperaturess.list[0].wind.speed)]

        let day = Calendar.current.component(.day, from: datas as Date)
        let month = Calendar.current.component(.month, from: datas as Date)
        let weekday = Calendar.current.component(.weekday, from: datas as Date)
        let hour = Calendar.current.component(.hour, from: datas as Date)
            
        let smallConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        
        
        cell.monthLabel.text = "\(day) \(DataSoursMonth.MonthIDs[month]!)"
        cell.iconImage.image = UIImage(systemName: DataSourceIcon.iconIDs[list[indexPath.row].weather[0].icon]!, withConfiguration: smallConfiguration)?.withRenderingMode(.alwaysOriginal)
            cell.TempMaxLabel.text = "\(Int(weathers.main!.temp_max))º"
        cell.weekDayAndHourLabel.text = "\(DataSoursDay.dateIDs[weekday]!) \(hour):00"
            cell.tempMinLabel.text = "\(Int(weathers.main!.temp_min))º"

        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewCellTwo", for: indexPath) as! NewTwoTableViewCell

            cell.infoNewLabel.text = infoLabelArray[indexPath.row]
            cell.resultNewLabel.text = resutLabelArray[indexPath.row]
            
            return cell

        }
    }
    
   
}


