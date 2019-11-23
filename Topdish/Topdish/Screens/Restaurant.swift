//
//  Restaurant.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Restaurant {
    var title = ""
    var featuredImage: UIImage
    
    //var ref: DatabaseReference!

 
    init(title: String, featuredImage: UIImage) {
        self.title = title
        self.featuredImage = featuredImage
    }
    /* Queries the database and returns the rating of a resturant */
    static func getRating(resturant: String) -> Double {
        let childString : String = "menu/" + resturant
        var counter: Double = 0
        var totalRating: Double = 0
        
        Database.database().reference().child(childString).observe(.childAdded) { (snapshot) in

            if let dictinoary = snapshot.value as? [String: Any] {
                if let userReviewDictionary = dictinoary["user reviews"] as? [String: Any] {
                    counter += 1
                    totalRating += (userReviewDictionary["rating"] as AnyObject).doubleValue
                    print("counter and totalRating in the if block: ", counter, " ", totalRating)
                }
            }
        }
        print ("counter before return: ", counter)
        print ("totalrating before return: ", totalRating)
        return (totalRating / counter)
    }

    /* Queries the database and returns the top highest rated restaurants */
    static func getTopPlaces() -> [Restaurant] {
        return [
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!),
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!),
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!),
                                  
        ]
    }
    
    /* Queries the database and returns a list of restaurants within a certain km, sorted by nearest */
    static func getNearby() -> [Restaurant] {
        return [
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!),
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!),
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!),
                                  
        ]
    }
    
    /* Queries the database and returns a list of restaurants with ongoing offers
     * Based on offer start and end date */
    static func getExclusiveOffers() -> [Restaurant] {
        return [
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!),
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!),
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!),
                                  
        ]
    }
}
