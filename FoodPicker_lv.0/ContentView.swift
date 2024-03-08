//
//  ContentView.swift
//  FoodPicker_lv.0
//
//  Created by HsinYuan on 2024/3/4.
//

import SwiftUI



struct ContentView: View {
    let food = ["漢堡", "沙拉", "披薩", "義大利麵", "雞腿便當", "刀削麵", "火鍋", "牛肉麵", "關東煮"]// 食物陣列
    @State private var selectedFood: String?// 選好的食物變數  一開始為空
    
    var body: some View {
        VStack(spacing: 30) {
            Image("dinner")
                .resizable()// 讓圖片可以先resize
                .aspectRatio(contentMode: .fit)

            Text("今天吃什麼")
                .font(.title)
                .bold()
            
            if selectedFood != .none {
                Text(selectedFood ?? "")// 如果沒有值，我們就顯示空
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.green)
            }
            
            Button("告訴我") {
                selectedFood = food.shuffled().first {$0 != selectedFood}// 亂數隨機
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
            
            Button("重置") {
                selectedFood = .none
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
