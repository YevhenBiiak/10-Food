//
//  FoodGroupDataSource.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

class FoodGroupDataSource: DataSource<FoodGroup> {
    
    override func obtainData(_ completion: ([FoodGroup]) -> Void) {
        completion(testSet())
    }
}

extension FoodGroupDataSource {
    
    func testSet() -> [FoodGroup] {
        sleep(2)
        return [FoodGroup(id: 1, name: "Pizza",
              description: "Try pizza cooked in a woodfire oven",
              imageData: UIImage(named: "pizza_icon")!.pngData()!),
                FoodGroup(id: 2, name: "Chinese food",
              description: "One of the oldest and most diverse cuisines in the world.",
              imageData: UIImage(named: "chinese_icon")!.pngData()!)
        ]
    }
}
