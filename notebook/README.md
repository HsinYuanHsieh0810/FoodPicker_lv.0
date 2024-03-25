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

### 調整圖片大小、亂數

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

## 2024.03.09

### State、間距調整(spacing)、Button style 調整

但另外寫這樣在我們每次更新```selectedFood```時，需要通知 View 更改畫面，這樣會非常麻煩。<br>
因此 SwiftUI 提供一個 Property Wrapper：```@state```來偵測。<br>
只要該變數數值有變化，就會通知畫面更新。<br>
那通常也會搭配 ```private```，因為這應該只屬於這畫面資訊，不應該在其它地方被啟動。<br>
程式碼片段如下：

```Swift
  let food = ["漢堡", "沙拉", "披薩", "義大利麵", "雞腿便當", "刀削麵", "火鍋", "牛肉麵", "關東煮"]// 食物陣列
    @State private var selectedFood: String?// 選好的食物變數  一開始為空

    var body: some View {
        VStack {
            Image("dinner")
                .resizable()// 讓圖片可以先resize
                .aspectRatio(contentMode: .fit)

            Text("今天吃什麼")
                .font(.largeTitle)
                .bold()

            Text(selectedFood ?? "還沒設定")// 如果沒有值，我們就顯示"還沒設定"

            Button("告訴我") {
                selectedFood = food.shuffled().first {$0 != selectedFood}// 亂數隨機
            }
        }
        .padding()
    }
```

接著我們可以調整間距來避免每個 View 太擠。
可以加上```padding```但如果每個 View 都要加，這樣 code 不簡潔。
故我們可以在 ```Vstack```裡面添加 ```spacing```

```Swift
    VStack(spacing: 30) {
        // code
        }
```

另外，因為不顯示時，會有空白，這邊我們加入一個判斷式。
另外```.none```跟```nil```都代表為空，

- ```.none```：在Swift中，Optional 是一種枚舉，```.none```其實就是 Optional 的一個狀態，表示沒有值。當你給一個 Optional 變量賦值 nil 時，實際上就是將其狀態設置為```.none```。
- ```nil```：一種更加直觀的方式來表示一個Optional變量沒有值，當你見到 nil，它指的就是 Optional的 ```.none```狀態

By ChatGPT 解答～<br>
在這樣的解析中，我認為兩種是都可以互通的。

```Swift
    // 如果 selectedFood 不是空的話，就顯示
    if selectedFood != .none {
        Text(selectedFood ?? "")// 如果有值，我們就顯示空
            .font(.largeTitle)
            .bold()
            .foregroundStyle(.green)
    }
```

## 2024.03.10

### animation、背景色、frame

這邊我們可以加入動畫讓文字改變的時，更加流暢。
這邊使用到```animation```，另外```value```就是會產生動畫的資料，必且資料形態需要是 equatabel 的，才能知道是否有變化。

```Swift
    .animation(.easeInOut, value: selectedFood)
```

另外需要注意的是，```animation```擺放的位置，我們需要在他改變發生之前就開始觀察了，所以在這個例子中，我們就將它擺放在 ```Vstack```上， ```Vstack```出現時，就會開始觀察 selectedFood 了，假如今天擺放在食物選擇時，反而要點選第一次後才會有動畫，因點選後才會開始觀察！

目前所使用的 Button 雖然很方便，但無法進行細部的調整。<br>
所以我們改成用這種方法

```Swift
    Button(role: .none) {
        selectedFood = .none
    } label: {
        Text("重置").frame(width: 200)
    }
    .font(.title)
    .buttonStyle(.borderedProminent)
```

上方程式碼中， 可以看到最大的差異就是原本的 Button 無法對 Text 的進行更改，因為字包在整個 Button 的 View；現在則使可以用 frame 來調整，撐出整個 Button 的大小。

另外，針對 Button 的風格中，也可以使用到```.buttonStyle```、```.buttonBorderShape```、```.controlSize```.....等等。

但是此時發現到這樣有些東西重複寫、太多重複程式碼了。
這時可以將這些重複的寫在最外層，如果有些需要特別更改的程式不會強行覆蓋。
例如：

```Swift
    VStack(spacing: 30) {
            // code...
            if selectedFood != .none {
                Text(selectedFood ?? "")// 如果沒有值，我們就顯示空
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.green)
            }
            // code...
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .animation(.easeInOut, value: selectedFood)
```

這邊的 font 全部設置為```.title```，但例面的 selectedFood 設置為 ```.largeTitle```，它並不會覆蓋成```.title```。

另外可以發現到按鈕的顏色都是藍色。
因為它會自己抓預設的顏色，所以如果要更動的化，可以到 Asset 檔案進行更改！

另外，我們在設定背景顏色時，因為調整器是放在```Vstack```底下，```Vstack```大小以裡面的內容大小來決定，如果要讓整個空間全滿，我們就需要透過```frame```來設定，但我們不知道高度多少，可以透過設定```maxHeight: .infinity```方法，直接用無限方法填滿。

```Swift
    VStack(spacing: 30) {
            // code...
           }
           .frame(maxHeight: .infinity)
```

接著下部影片要來調整按鈕中動畫相關的問題！

## 2024.03.12＆03.15

### 動畫相關概念

決定動畫的流程如下圖所示：

![2024-03-12 14.50.50](https://raw.githubusercontent.com/HsinYuanHsieh0810/FoodPicker_lv.0/main/notebook/img/2024-03-12%2014.50.50.png)

偵測到變化主要是用 Equtable 來做比較，只要跟原先有一點點差異，E.g 大小、位置、長短...等等，就會執行動畫，呈現出不一樣的地方。

接著決定要用變形還是轉場的關鍵就是 View 的身分。

#### View 介紹

- View 是一個 Struct，所以需要判斷 View 之間的關聯性
- 兩個步驟確認身分：(1)先判斷結構位置(Hierarchy)，(2)再判斷 ID

#### 結構位置-Hirerarchy

以目前範例來說，其 Hierarchy 主要事由 ContentView、Vstack、Image、Text和兩個 Button 組成。

主要結構圖如下：

![2024-03-12 15.27.16](https://raw.githubusercontent.com/HsinYuanHsieh0810/FoodPicker_lv.0/main/notebook/img/2024-03-12%2015.27.16.png)

但其實我們還有一個藏在中間的 View，就是用來顯示食物用的，但它並不會一直出現，所以其實當中的 Text 可以拆成兩個 View，如下方圖片：<br>
注意！這邊的 EitherView 並非真有此 View，實際上會包裝成另一個類型，這邊只是為了方便講解。

![2024-03-12 15.31.05](https://raw.githubusercontent.com/HsinYuanHsieh0810/FoodPicker_lv.0/main/notebook/img/2024-03-12%2015.31.05.png)

我們也可以繼續往下拆解，結果如下：

![2024-03-12 15.40.24](https://raw.githubusercontent.com/HsinYuanHsieh0810/FoodPicker_lv.0/main/notebook/img/2024-03-12%2015.40.24.png)

回到前面問題 - 變化前後是同一個 View 嗎？<br>
Answer：不一樣！可以看到沒有字時是 EmptyView；有文字時，就是 Text View 因此轉換時就會啟動轉場動畫。

而預設轉場動畫就是淡入淡出，當文字出現時，其他 View 需讓出位置，而這些 View 因為都是同一個 View，故產生變形動畫。

#### 文字動畫問題

在目前程式中，"告訴我" 跟 "換一個" 按鈕中的文字變化時，發現到 SwiftUI 在做似乎是轉場的淡入淡出效果。這是因為它不知道如何做中文字的變形造成的，忽略不能掌握的變化，所以預設就會在開始的地方做淡出，結束的地方做淡入，而在此案例中，又剛好是在不同的起始位置，導致有兩個 View 轉場的錯覺。

因此，解決方法就是加入```.transformEffect```，這個調整器可以替 View 做一些變形效果，這邊我們可以先加入```.transformEffect(.init(translationX: 50, y: 0))```試試看，可以發現到正常了！<br>

這是因為加入這個調整器後，強制不讓他去忽略這個變形，因此在前面的示範中，目前是使用```translationX: 50, y: 0)```，但這樣會改變位置，調成X: 0, y:0，又感覺太麻煩，我們可以使用``` .transformEffect(.identity)```<br>

接著，在顯示 selectedFood 時因為在 iOS16 預設為淡入淡出，如果是iOS15就是不是了，故我們其實也需要進行更改，解決方法就是加入```.id(selectedFood)```，表達出每個食物的獨立性，達成轉場效果。

## 2024.03.25

### 動畫相關概念-2

我們也可以針對轉場調整添加```.transition()```效果，如果想要額外效果
，甚至可以添加```.transition(.scale.combined(with: .slide))```的轉場效果，以滑行方式變大縮小。

甚至還可以設定進場、離場動畫：

```Swift
.transition(.asymmetric(
            insertion: .opacity// 進入-使用 easeInOut
                .animation(.easeInOut(duration:0.5).delay(0.2)),

            removal: .opacity// 消失-使用 easeInOut
                .animation(.easeInOut(duration:0.4))))

```

目前我們是在最外層來定義動畫，但在實際實作時，如果需要精確控制每個動畫的出現就需要個別設定，以本例的 Button為例：

```Swift
    Button {
        withAnimation{
            selectedFood = .none
        }
    } label: {
        Text("重置").frame(width: 200)
    }

```

#### if 使用時機

除此之外，我們一定需要注意 if 使用的時機！

```Swift
    if selectedFood != .none {
        Color.pink
    } else {
        Color.blue
    }
```

上方程式碼會看到大小不同的色塊淡入淡出，主要是在執行轉場過程，這邊有些人會認為是兩個不同樣東西，但 SwiftUI 會認為它們兩個是不同的東西，因為 if 會被包裝成 EitherView ，在結構上會佔據不同的位置。

但如果我們改成條件運算子的寫法：

```Swift
    selectedFood != .none ? Color.pink : Color.blue
```

這樣就會成變形動畫，因為條件運算子會運算來選擇一個 View。

if else 的本質就是在做流程控制，並沒有什麼限制。
我們現在做使用的 if else ，背後其實如下

```Swift
    if selectedFood != .none {
        // code
    } else {
        EmptyView()
    }
```

我們之可以使用，是因為它有被包裝過，包裝後會讓每個 Block，變成獨立的分支(Or 結構位置)，以此例子來說，我們包裝成兩個 generic 的 EitherView(ViewBuilder 概念)，如果不想要轉場，想要用不同概念呈現，我們就不能用 if else 來處理！

