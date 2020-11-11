//
//  ChannelsController.swift
//  Popi WatchKit Extension
//
//  Created by Atakan on 10.11.2020.
//  Copyright © 2020 Atakan. All rights reserved.
//

import Foundation
import WatchKit


class ChannelsController: WKInterfaceController {
    
    
    @IBOutlet weak var channelTable: WKInterfaceTable!
    
    
        override func awake(withContext context: Any?) {
            super.awake(withContext: context)
            
        
            if context == nil {
                print("context is nil")
            }
            
            let channels = context as? [String]
            
            if let ch = channels{
                
                channelTable.setNumberOfRows(channels!.count, withRowType: "Row")
                
                var x = 0
                for element in ch{
                    
                    let row = channelTable.rowController(at: x) as! ChannelRow
                    row.textLabel.setText(element)
                    x += 1
                    
                    
                }
                
            }
            
    
            
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

    


