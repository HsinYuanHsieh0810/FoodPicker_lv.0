//
//  ContentView.swift
//  FoodPicker_lv.0
//
//  Created by HsinYuan on 2024/3/4.
//

import SwiftUI

class SomeClass {
    var selectedFood: String?
}

struct ContentView: View {
    let food = ["漢堡", "沙拉", "披薩", "義大利麵", "雞腿便當", "刀削麵", "火鍋", "牛肉麵", "關東煮"]// 食物陣列
    var selectedFood: String?// 選好的食物變數  一開始為空
    let someClass = SomeClass()
    
    var body: some View {
        VStack {
            Image("dinner")
                .resizable()// 讓圖片可以先resize
                .aspectRatio(contentMode: .fit)

            Text("今天吃什麼")
                .font(.largeTitle)
                .bold()
            
            Button("告訴我") {
                someClass.selectedFood = food.shuffled().first {$0 != selectedFood}
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
