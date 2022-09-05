//
//  CarouselViewControllerData.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

struct CarouselViewControllerData: CarouselViewControllerDataRepresentable {
    
    static let data: [CarouselViewControllerData] = [
        .init(image: UIImage(named: "boostProductivity"), title: "Boost Productivity", description: "Take your productivity to the next level"),
        .init(image: UIImage(named: "workSeamlessly"), title: "Work Seamlessly", description: "Get your work done seamlessly without interruption"),
        .init(image: UIImage(named: "achieveYourGoals"), title: "Achieve Your Goals", description: "Boosted productivity will help you achieve the desired goals")
    ]
    
    var image: UIImage?
    var title: String
    var description: String
}
