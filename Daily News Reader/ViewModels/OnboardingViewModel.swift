//
//  OnboardingViewModel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

final class OnboardingViewModel {
    
    let sliderData: [OnboardingItemModel] = [
        OnboardingItemModel(
            color: .purple2,
            title: "Step into the World of News",
            text: "Open the doors to the world of news. Discover the latest headlines and stories that pique your interest.",
            animationName: "a1"),
        
        OnboardingItemModel(
            color: .purple2,
            title: "Personalize and Explore",
            text: "Choose the topics that matter to you and create a personalized news feed. Exploring interesting content has never been easier.",
            animationName: "a2"),
        
        OnboardingItemModel(
            color: .purple2,
            title: "Stay Informed",
            text: "Don't miss the latest updates. Stay informed about breaking news with instant notifications and always stay up-to-date.",
            animationName: "a3"),
    ]
}
