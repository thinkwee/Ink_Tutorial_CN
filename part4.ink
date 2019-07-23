// 四、高级流程控制
// 1.管道
// ink项目的默认结构是一个扁平的树，其中选择、分支和收束交织其中，也许会有循环，但是故事永远在某一个特定的点。但是这种扁平结构不适于某些需求，例如游戏中散布着多个小情节，这些情节可能都会跳转同一个节点，之间需要一次或者多次参数传递来指出跳转目的地。ink使用一种新的节点，管道，来完成这一系列操作。
// 2.管道运行子故事
// 管道(tunnels)的语法类似跳转(divert)，不过是两个跳转在两侧：
// -> crossing_the_date_line ->
// 这意味着，完成crossing_the_date_line节点，之后回到此处继续
// ->->
// 类似的，两个跳转连在一起表示继续，不发生任何跳转
// ... 
// // this runs the tunnel, then diverts to 'done'
// -> crossing_the_date_line -> done
// ...

// ... 
// //this runs one tunnel, then another, then diverts to 'done'
// -> crossing_the_date_line -> check_foggs_health -> done
// ...
// 以上是两个其他的例子，管道中的节点可以有多个子故事

// 管道还可以嵌套，如下所示
// === plains ===
// = night_time 
// 	The dark grass is soft under your feet.
// 	+	[Sleep]
// 		-> sleep_here -> wake_here -> day_time
// = day_time 
// 	It is time to move on.
	
// === wake_here ===
// 	You wake as the sun rises.
// 	+	[Eat something]
// 		-> eat_something ->
// 	+	[Make a move]
// 	-	->->

// === sleep_here ===
// 	You lie down and try to close your eyes.
// 	-> monster_attacks -> 
// 	Then it is time to sleep.
// 	-> dream ->
// 	->->

// 2. 线程
// 目前为止Ink中所有的东西，除了分支和跳转，都是完全线性的。但实际上一个作者可以fork一个故事，加入到不同的子模块中，来覆盖更多可能的玩家行为。我们称之为线程，尽管它不是计算机科学中实际意义上的线程。它更像来自不同地方的新内容中的子节点。

// 3. 线程将多个子模块串联起来
// 线程允许你组合多个来源的内容到一处，例如：
== thread_example ==
I had a headache; threading is hard to get your head around.
<- conversation
<- walking


== conversation ==
It was a tense moment for Monty and me.
 * "What did you have for lunch today?"[] I asked.
    "Spam and eggs," he replied.
 * "Nice weather, we're having,"[] I said.
    "I've seen better," he replied.
 - -> house

== walking ==
We continued to walk down the dusty road.
 * [Continue walking]
    -> house

== house ==
Before long, we arrived at his house.
-> END























