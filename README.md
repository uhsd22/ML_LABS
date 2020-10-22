# <center><b>Метрические алгоритмы</b></center>

**Гипотеза компактности** - в задачах классификации предположение о том, что схожие объекты гораздо чаще лежат в одном классе,
чем в разных; или, другими словами, что классы образуют компактно локализованные подмножества в пространстве объектов.

Основываясь на данной гипотезе, реализуем алгоритм **k-ближайших соседей** на "Ирисах Фишера".

В реализованных методах выбрана евклидова метрика. 


```
 Distance <- function(u, v) {
  sqrt(sum((u - v)^2))
}
```
### **1. Метод классификации k-ближайших соседей("kNN"):**

**KNN** сохраняет размеченные тренировочные данные.
- Когда появляются новые неразмеченные данные, kNN проходит по 2 базовым шагам:
	+ Сначала он ищет k ближайших размеченных точек данных – другими словами, k ближайших соседей.
	+ Затем, используя классы соседей, kNN решает, как лучше классифицировать новые данные.


Оптимальное значение параметра k определяют по критерию скользящего контроля с исключением объектов по одному (leave-one-out, LOO). Для каждого объекта проверяется, правильно ли он классифицируется по своим k ближайшим соседям.   
![LOO](https://github.com/uhsd22/Lab1/blob/master/LabIMG/LOO(k).png)

По представленному графику можем заметить, что минимальная оценка **LOO = 0.(3)** при **k = 6**.
Карта классификации выглядит следующим образом:
![KNN](https://github.com/uhsd22/Lab1/blob/master/LabIMG/map_KNN.png)

### **2. Метод классификации k-взвешенных соседей("kwNN"):**  
Альтернативный вариант метода kNN: в каждом классе выбирается k ближайших к объектов, и объект относится к тому классу, для
которого среднее расстояние до k ближайших соседей минимально.

Для составления карты классификации параметр k равен 6, а параметр веса q равен 0.5:
![LOOKWNN](https://github.com/uhsd22/Lab1/blob/master/LabIMG/LOO(k%2Cq).png)
![KWNN](https://github.com/uhsd22/Lab1/blob/master/LabIMG/map_KWNN.png)

На следующем графике наглядно продемонстрированно превосходство алгоритма классификации kwNN над алгоритмом kNN:
![KNN_KWNN](https://github.com/uhsd22/Lab1/blob/master/LabIMG/ExKNN.png)
![KWNN_KNN](https://github.com/uhsd22/Lab1/blob/master/LabIMG/ExKWNN.png)
