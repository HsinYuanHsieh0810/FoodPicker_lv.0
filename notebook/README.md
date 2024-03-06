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

## 2024.03.06

### 調整圖片大小

加入圖片中，我們通常會使用 ```Image("檔案名稱")```，這些圖片會放在 Assets 中，而預設畫面中，會有```Image(systemName: "globe")```，則是使用系統預設的 Icon。

在放入圖片後，我們通常要調整圖片大小，沒調整前，預設都是會將圖片塞滿。
這邊則是希望可以在可視範圍內，完整顯示一張圖片。
這邊使用到 ```aspectRatio(_:contentMode:)```
主要有兩種模式：

- ```.fit```：使內容完全適應視圖中，保持其寬高比，同時確保整個內容都在視圖內且不會被裁剪。
- ```.fill```：填充整個視圖，同時保持內容的寬高比，可能會裁剪掉內容(超出螢幕外)的某些部分確保填充整個視圖。

圖片調節程式碼片段：

![2024-03-06 22.14.46](https://raw.githubusercontent.com/HsinYuanHsieh0810/FoodPicker_lv.0/main/notebook/img/2024-03-06%2022.14.46.png)

接著我們要開始來選擇食物 <br>
創建一個食物陣列 <br>
還有一個屬性儲存被選上的食物 <br>

```let food = ["漢堡", "沙拉", "披薩", "義大利麵", "雞腿便當", "刀削麵", "火鍋", "牛肉麵", "關東煮"]```

```var selectedFood: String?```

在 selectedFood 變數中，？代表著可能有值，也有可能沒值，預設為 nil。

接著針對按下按鈕後的反應進行處理 <br>
```selectedFood = food.shuffled().first {$0 != selectedFood}```

主要是對陣列打亂，並且選擇第一個，這邊要注意的是後面的<br>
```selectedFood = food.shuffled().first {$0 != selectedFood}```<br>
代表我們選擇到的第一個元素需要滿足```{$0 != selectedFood}```條件，這條件表示尋找的元素（由 $0 代表）不能等於當前的 selectedFood 值，可以避免選到重一次重複的。

但設定好後會出現 self is immutable，因為目前這邊數是在一個 struct 中，無法直接對 ```selectedFood```進行修改，如果要在內部修改，需使用```mutating```，但目前 body 是一個計算屬性，無法更換成該關鍵字。

➔ 解決方法：將```selectedFood```另外寫，但會有缺點。明天待續～
