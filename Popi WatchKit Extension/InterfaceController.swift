//
//  InterfaceController.swift
//  Popi WatchKit Extension
//
//  Created by Atakan on 9.11.2020.
//  Copyright © 2020 Atakan. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var table : WKInterfaceTable!
    
    var catego = [String]()
    var channels = [String:[String]]()
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        loadData()
        
        
        DispatchQueue.main.async {
            self.reloadTable()
        }
        
        
        
    }
    
    func reloadTable(){
        
        table.setNumberOfRows(catego.count, withRowType: "Row")
        var x = 0
        
        for element in catego{
            
            let row = table.rowController(at: x) as! CategoryRow
            row.categoryLabel.setText(element)
            x += 1
            
            
        }
    }
    
    func loadData(){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let url = URL(string: "http://popilight.com/c/channels.json")!
        
        let task = session.dataTask(with: url){
            data,response,error in
            
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: [])) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            
            
                if let names = json["categories"] as? [String]{
                    self.catego.append(contentsOf: names)
                }
            
            

            
            if let ch = json["channels"] as? [[String: Any]]{
                
                var featur = [String]()
                var event = [String]()
                var sport = [String]()
                var music = [String]()
                var util = [String]()
                
                
                for element in ch{
                    
                    if(element["group"] as? String == "featured"){
                    
                        featur.append(element["title"] as! String)
                        
                    }
                    
                    if(element["group"] as? String == "sports"){
                    
                        sport.append(element["title"] as! String)
                        
                    }
                    
                    if(element["group"] as? String == "music"){
                    
                        music.append(element["title"] as! String)
                        
                    }
                    
                    if(element["group"] as? String == "event"){
                    
                        event.append(element["title"] as! String)
                        
                    }
                    
                    
                    if(element["group"] as? String == "utility"){
                                       
                        util.append(element["title"] as! String)
                                           
                    }
                    
                }
                
                
                self.channels["Featured"] = featur
                self.channels["Event"] = event
                self.channels["Sports"] = sport
                self.channels["Music"] = music
                self.channels["Utility"] = util
                
                
               
            }
          
            
            
            
        }
        
        task.resume()
        reloadTable()
        
        
    }
    
    
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        
        
        if segueIdentifier == "nextSegue"{
            
            if(rowIndex == 0)
            {
                return channels["Featured"]
            }
            else if(rowIndex == 1)
            {
                return channels["Event"]
            }
            else if (rowIndex == 2)
            {
                return channels["Sports"]
            }
            else if (rowIndex == 3)
            {
                return channels["Music"]
            }
            else if (rowIndex == 4)
            {
                return channels["Utility"]
            }
            
        }
        
        return nil
    }
    
   
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
