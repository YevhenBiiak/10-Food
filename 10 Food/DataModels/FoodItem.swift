//
//  FoodItem.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import Foundation

struct FoodItem {
    let id: Int
    let name: String
    let description: String
    let weight: Int
    let price: Int
    let imageURL: String
}
/*
[
    FoodItem(id: 1, name: "MARGHERITA", description: "(tomato sauce, mozarella, basil)", weight: 490, price: 151, imageURL: ""),
    FoodItem(id: 2, name: "PARMA", description: "(tomato sauce, mozarella, prosciutto, arugula, parmesan)", weight: 515, price: 141, imageURL: ""),
    FoodItem(id: 3, name: "ROMANA WITH MUSHROOMS", description: "(tomato sauce, mozarella, ham, mushrooms)", weight: 500, price: 161, imageURL: ""),
    FoodItem(id: 4, name: "QUATTRO FORMAGGI", description: "(tomato sauce, mozarella, rockfor, parmesan, gauda or emmental)", weight: 540, price: 141, imageURL: ""),
    FoodItem(id: 5, name: "CAPRICCIOSA", description: "(tomato sauce, mozarella, ham, mushrooms, olives, artichoke)", weight: 490, price: 137, imageURL: ""),
    FoodItem(id: 6, name: "DIAVOLA", description: "(tomato sauce, mozarella, salami, olives)", weight: 500, price: 141, imageURL: ""),
    FoodItem(id: 7, name: "CAPITANO", description: "(tomato sauce, mozarella, tuna, olives, capers, onion)", weight: 520, price: 141, imageURL: ""),
    FoodItem(id: 8, name: "VIKINGA", description: "(tomato sauce, mozarella, tuna, red/green pepper, artichoke)", weight: 520, price: 161, imageURL: ""),
    FoodItem(id: 9, name: "PARMIGIANA", description: "(tomato sauce, mozarella, prosciutto, eggplant, arugula, parmesan)", weight: 490, price: 129, imageURL: ""),
    FoodItem(id: 10, name: "MONTANARA", description: "(tomato sauce, mozarella, mushrooms, arugula, parmesan)", weight: 520, price: 137, imageURL: ""),
    FoodItem(id: 11, name: "ROMANA WITH SAUSAGES", description: "(tomato sauce, mozarella, ham, sausages)", weight: 480, price: 151, imageURL: ""),
    FoodItem(id: 12, name: "PIZZA WITH SALMON", description: "(tomato sauce, mozarella, salmon, capers)", weight: 550, price: 119, imageURL: ""),
    FoodItem(id: 13, name: "VEGETARIANA", description: "(tomato sauce, mozarella, mushrooms, red/green pepper, artichoke, olives, eggplant)", weight: 520, price: 161, imageURL: ""),
    FoodItem(id: 14, name: "CAMALEONTE", description: "(tomato sauce, prosciutto, mushrooms, red/green pepper, salami, 4 cheeses)", weight: 490, price: 151, imageURL: ""),
    FoodItem(id: 15, name: "FUNGHI", description: "(tomato, mozzarela, ham, mushrooms, oregano)", weight: 490, price: 161, imageURL: ""),
    FoodItem(id: 16, name: "NAPOLITANA", description: "(tomato, anchovies, capers, olives, garlic, olive oil, oregano)", weight: 510, price: 151, imageURL: ""),
    FoodItem(id: 17, name: "BBQ CHICKEN", description: "(bbq sauce, mozzarela, chicken, onion, cilantro, parmesan)", weight: 500, price: 141, imageURL: ""),
    FoodItem(id: 18, name: "DA ITALIA", description: "(mozzarela, pepperoni, onion, reduced balsalmic, basil)", weight: 490, price: 151, imageURL: ""),
]

[
    FoodItem(id: 1, name: "Sunomono", description: "Cucumber, Soy Sauce, Vinegar, Nori", weight: 200, price: 100, imageURL: ""),
    FoodItem(id: 2, name: "Yōkan", description: "Mizu yokan, Neri yokan", weight: 280, price: 90, imageURL: ""),
    FoodItem(id: 3, name: "Tempura udon", description: "Udon, Dashi, Shrimps, Narutomaki, Mirin", weight: 310, price: 104, imageURL: ""),
    FoodItem(id: 4, name: "Kitakata ramen", description: "Ramen Noodles, Stock, Soy Sauce, Sardines, Pork, Scallions", weight: 290, price: 17, imageURL: ""),
    FoodItem(id: 5, name: "Tamago kake gohan", description: "Uruchimai, Rice Vinegar, Eggs", weight: 185, price: 34, imageURL: ""),
    FoodItem(id: 6, name: "Kiritanpo", description: "Rice", weight: 265, price: 75, imageURL: ""),
    FoodItem(id: 7, name: "Anpan", description: "Wheat Flour, Butter, Milk, Eggs, Red Bean Paste, Sesame Seeds", weight: 300, price: 154, imageURL: ""),
    FoodItem(id: 8, name: "Chankonabe", description: "Chicken, Scallions, Mushrooms, Carrot, Shrimps, Tofu", weight: 270, price: 93, imageURL: ""),
    FoodItem(id: 9, name: "Sūpu karē", description: "Chicken, Curry Powder, Potatoes, Bell Pepper, Carrot, Tomato Sauce", weight: 290, price: 59, imageURL: ""),
    FoodItem(id: 10, name: "Chirashizushi", description: "Uruchimai, Rice Vinegar, Sashimi, Eggs, Surimi", weight: 200, price: 96, imageURL: ""),
    FoodItem(id: 11, name: "Hitsumabushi", description: "Unagi, Rice, Dashi, Scallions, Nori", weight: 340, price: 49, imageURL: ""),
    FoodItem(id: 12, name: "Tebasaki yakitori", description: "Chicken, Salt, Black Pepper", weight: 310, price: 87, imageURL: ""),
    FoodItem(id: 13, name: "Yatsuhashi", description: "Rice Flour, Sugar, Cinnamon, Red Bean Paste", weight: 290, price: 113, imageURL: ""),
    FoodItem(id: 14, name: "Hiyashi chūka", description: "Ramen Noodles, Eggs, Shrimps, Persian Cucumber, Lettuce, Tomato", weight: 280, price: 190, imageURL: ""),
    FoodItem(id: 15, name: "Kushiage", description: "Beef, Breadcrumbs, Black Pepper, Worcestershire Sauce, Soy Sauce", weight: 320, price: 89, imageURL: "")
]
*/
