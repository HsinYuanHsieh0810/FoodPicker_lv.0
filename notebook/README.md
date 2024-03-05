# SwiftUI 學習

> 參考影片：<https://www.youtube.com/playlist?list=PLXM8k1EWy5khONZ9M9ytK8mMrcEOXvGsE>

- 希望每天有一點點🤏進度就好，腦袋才不會生鏽
- 記錄每天學到的語法與相關知識

## 2024.03.04

### APP 基本架構

主要由 App、Scene、View 三者所構成

- App (應用程序)：由 ```@main``` 為整個應用程序的進入點，**整個程序只會有一個 App 實例**。
- Scene (場景)：可以理解為很多的為一組視圖的集合，系統也會根據運行的平台來調整。在一個應用程序中可以有多個Scene，每個 Scene 都是獨立的。有以下三種常見類型。
    1. ```WindowGroup```：是最長用的 Scene 類型，用於管理一組視圖。
    2. ```DocumentGroup```：常用在會生出一個檔案的 APP ，會有儲存、開新檔案、開啟舊檔、復原上一步、下一步...等等。
    3. ```Setting```：只會在 mac 上出現，類似於 mac 螢幕上最上面跳出的設定視窗。
- View (視圖)：簡單來說就是用來建構頁面的組件，主要用來繪製和佈局頁面元素。

簡單來說  
App 就是就是要知道它的視窗視什麼，就可以幫我們處理該做的事情；Scene 則是負責每個視窗一打開的畫面需要是什麼；View 負責呈現畫面。

![2024-03-04 20.44.21](https://raw.githubusercontent.com/HsinYuanHsieh0810/FoodPicker_lv.0/main/notebook/img/2024-03-04%2020.44.21.png)

## 2024.03.05

### View 和調整器（modifier)

View 通常要(1)在 body 屬性中描述換面樣子；(2) body 的類型必須遵循 View Protocol。
實做 View 時，我們通常會考慮以下三點，這三點也有對應的名詞

1. 有什麼 View 可以用 ➔ View
2. View 可以如何改變 ➔ Modifier
3. 如何組合和排序多個 View ➔ Layout

在專案的預設畫面中，就有用到上面三點了

![2024-03-05 22.02.36](https://raw.githubusercontent.com/HsinYuanHsieh0810/FoodPicker_lv.0/main/notebook/img/2024-03-05%2022.02.36.png)

- View：如圖中 ```VStack```、```Image```、```Text```
- Modifier：每個 View 後面的方法就是調整器，如圖中```.imageScale```、```.foregroundColor```、```.padding()```
- Layout：這邊的 ```VStack``` 除了是 View 以外，也是一個 Layout，因為它負責創建一個垂直排列的空間。
