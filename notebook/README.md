# SwiftUI 學習


> 參考影片：https://www.youtube.com/playlist?list=PLXM8k1EWy5khONZ9M9ytK8mMrcEOXvGsE
- 希望每天有一點點🤏進度就好，腦袋才不會生鏽
- 記錄每天學到的語法與相關知識

## 2024.03.04
### APP 基本架構

主要由 App、Scene、View 三者所構成
-   App (應用程序)：由 ```@main``` 為整個應用程序的進入點，**整個程序只會有一個 App 實例**。
-   Scene (場景)：可以理解為很多的為一組視圖的集合，系統也會根據運行的平台來調整。在一個應用程序中可以有多個Scene，每個 Scene 都是獨立的。 ```WindowGroup``` 是最長用的 Scene 類型，用於管理一組視圖。
-   View (視圖)：簡單來說就是用來建構頁面的組件，主要用來繪製和佈局頁面元素。

簡單來說<br>
App 就是就是要知道它的視窗視什麼，就可以幫我們處理該做的事情；Scene 則是負責每個視窗一打開的畫面需要是什麼；View 負責呈現畫面。

![2024-03-04 20.44.21](https://raw.githubusercontent.com/HsinYuanHsieh0810/FoodPicker_lv.0/main/notebook/img/2024-03-04%2020.44.21.png)