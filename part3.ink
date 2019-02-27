// 三、逻辑与变量

// // 通过VAR定义全局变量，包括整型、浮点型、字符串、故事地址
// VAR knowledge_of_the_cure = false
// VAR players_name = "Emilia"
// VAR number_of_infected_people = 521
// VAR current_epilogue = -> they_all_die_of_the_plague

// // 因此可以使用全局变量来作为选项的测试条件
// === the_train ===
// 	The train jolted and rattled. { mood > 0:I was feeling positive enough, however, and did not mind the odd bump|It was more than I could bear}.
// 	*	{ not knows_about_wager } 'But, Monsieur, why are we travelling?'[] I asked.
// 	* 	{ knows_about_wager} I contemplated our strange adventure[]. Would it be possible?

// // 故事跳转也可以存为变量	
// VAR 	current_epilogue = -> everybody_dies 

// === continue_or_quit ===
// Give up now, or keep trying to save your Kingdom?
// *  [Keep trying!] 	-> more_hopeless_introspection
// *  [Give up] 		-> current_epilogue	

// // 打印变量
// VAR friendly_name_of_player = "Jackie"
// VAR age = 23

// My name is Jean Passepartout, but my friend's call me {friendly_name_of_player}. I'm {age} years old.
	
// // 字符串变量可以被解释为ink脚本，如下，但是当脚本运行之后该变量的值就已经确定，一般不建议这么做
// VAR a_colour = ""

// ~ a_colour = "{~red|blue|green|yellow}" 

// {a_colour} 
	
// // 使用~来代表数值运算
// === set_some_variables ===
// 	~ knows_about_wager = true	
// 	~ x = (x * x) - (y * y) + c
// 	~ y = 2 * x * y
	
// // 字符串操作
// { "Yes, please." == "Yes, please." }
// { "No, thank you." != "Yes, please." }
// { "Yes, please" ? "ease" }

// // 条件逻辑块
// { x > 0:
// 	~ y = x - 1
// - else:
// 	~ y = x + 1
// }
	
// // 完整条件逻辑块
// { 
// 	- x == 0:
// 		~ y = 0
// 	- x > 0:
// 		~ y = x - 1
// 	- else:
// 		~ y = x + 1
// }
	
// // switch逻辑块
// { x:
// - 0: 	zero 
// - 1: 	one 
// - 2: 	two 
// - else: lots
// }
	
// 例子
// === dream ===
// 	{
// 		- visited_snakes && not dream_about_snakes:
// 			~ fear++
// 			-> dream_about_snakes

// 		- visited_poland && not dream_about_polish_beer:
// 			~ fear--
// 			-> dream_about_polish_beer 

// 		- else:
// 			// breakfast-based dreams have no effect
// 			-> dream_about_marmalade
// 	}

// // 条件逻辑块可以和选项结合,但是条件逻辑块中不允许加入gather
// I stared at Monsieur Fogg.
// { know_about_wager:
// 	<> "But surely you are not serious?" I demanded.
// - else:
// 	<> "But there must be a reason for this trip," I observed.
// }
// He said nothing in reply, merely considering his newspaper with as much thoroughness as entomologist considering his latest pinned addition.
	
// { door_open:
// 	* 	I strode out of the compartment[] and I fancied I heard my master quietly tutting to himself. 			-> go_outside 
// - else:
// 	*	I asked permission to leave[] and Monsieur Fogg looked surprised. 	-> open_door 
// 	* 	I stood and went to open the door[]. Monsieur Fogg seemed untroubled by this small rebellion. -> open_door
// }

// 一些保留字扩展了条件块,给出一些基本的组合逻辑:
// Sequence: go through the alternatives, and stick on last 
{ stopping:
	-	I entered the casino.
	-  I entered the casino again.
	-  Once more, I went inside.
}

// Shuffle: show one at random
At the table, I drew a card. <>
{ shuffle:
	- 	Ace of Hearts.
	- 	King of Spades.
	- 	2 of Diamonds.
		'You lose!' crowed the croupier.
}

// Cycle: show each in turn, and then cycle
{ cycle:
	- I held my breath.
	- I waited impatiently.
	- I paused.
}

// Once: show each, once, in turn, until all have been shown
{ once:
	- Would my luck hold?
	- Could I win the hand?
}
	
	
	
	
	
    