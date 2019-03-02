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

// // 一些保留字扩展了条件块,给出一些基本的组合逻辑:
// // Sequence: go through the alternatives, and stick on last 
// { stopping:
// 	-  I entered the casino.
// 	-  I entered the casino again.
// 	-  Once more, I went inside.
// }

// // Shuffle: show one at random
// At the table, I drew a card. <>
// { shuffle:
// 	- 	Ace of Hearts.
// 	- 	King of Spades.
// 	- 	2 of Diamonds.
// 		'You lose!' crowed the croupier.
// }

// // Cycle: show each in turn, and then cycle
// { cycle:
// 	- I held my breath.
// 	- I waited impatiently.
// 	- I paused.
// }

// // Once: show each, once, in turn, until all have been shown
// { once:
// 	- Would my luck hold?
// 	- Could I win the hand?
// }
	
	
// // 使用~表示临时变量，临时变量在离开stitch之后就失效
// === near_north_pole ===
// 	~ temp number_of_warm_things = 0
// 	{ blanket:
// 		~ number_of_warm_things++
// 	}
// 	{ ear_muffs:
// 		~ number_of_warm_things++
// 	}
// 	{ gloves:
// 		~ number_of_warm_things++
// 	}
// 	{ number_of_warm_things > 2:
// 		Despite the snow, I felt incorrigibly snug.
// 	- else:
// 		That night I was colder than I have ever been.
// 	}

// // 临时变量的一个用途就是作为stitch的参数
// *	[Accuse Hasting]
// 		-> accuse("Hastings")
// *	[Accuse Mrs Black]
// 		-> accuse("Claudia")
// *	[Accuse myself] 
// 		-> accuse("myself")
		
// === accuse(who) ===
// 	"I accuse {who}!" Poirot declared.
// 	"Really?" Japp replied. "{who == "myself":You did it?|{who}?}"
// 	"And why not?" Poirot shot back.

// // 临时变量可用于递归
// -> add_one_to_one_hundred(0, 1)

// === add_one_to_one_hundred(total, x) ===
// 	~ total = total + x
// 	{ x == 100:
// 		-> finished(total)
// 	- else:
// 		-> add_one_to_one_hundred(total, x + 1)
// 	}	
	
// === finished(total) ===
// 	"The result is {total}!" you announce.
// 	Gauss stares at you in horror.
// 	-> END

// // knot和stitch的地址也可以作为参数传递，它们用->来指示,否则就会成为knot和stitch是否已读的判断
// === sleeping_in_hut ===
// 	You lie down and close your eyes.
// 	-> generic_sleep (-> waking_in_the_hut)

// ===	 generic_sleep (-> waking)
// 	You sleep perchance to dream etc. etc.
// 	-> waking

// === waking_in_the_hut
// 	You get back to your feet, ready to continue your journey.

// 函数
// 函数是一种Knots,但是有诸多限制:
// -   不能包含stitch
// -   不能使用divert或者提供选择
// -   能调用其他函数
// -   能包含显示内容
// -   能返回任意类型的值,通过~return得到
// -   能安全的递归

// 定义并调用一个函数
// VAR x = 0
// the x is {x}
// ~ x = lerp(2, 8, 0.3)
// the x is {x}

// *	{say_yes_to_everything()} 'Yes.' 
// === function say_yes_to_everything ===
// 	~ return true

// === function lerp(a, b, k) ===
// 	~ return ((b - a) * k) + a

// // 函数可以调用其他函数
// === function say_no_to_nothing === 
// 	~ return say_yes_to_everything()

// // 可以只用函数把一系列操作打包,不一定要返回值
// === function harm(x) ===
// 	{ stamina < x:
// 		~ stamina = 0
// 	- else:
// 		~ stamina = stamina - x
// 	}

// // 函数可以内联
// VAR health = 0
// ~ health = 56
// Monsieur Fogg was looking {describe_health(health)}.

// === function describe_health(x) ===
// { 
// - x == 100:
// 	~ return "spritely"
// - x > 75:
// 	~ return "chipper"
// - x > 45:
// 	~ return "somewhat flagging"
// - else:
// 	~ return "despondent"
// }

// // 下面是一个在许多ink游戏中都需要的函数,将数字转为单词
// VAR price = 15

// I pulled out {print_num(price)} coins from my pocket and slowly counted them. 
// "Oh, never mind," the trader replied. "I'll take half." And she took {print_num(price / 2)}, and pushed the rest back over to me.

// === function print_num(x) ===
// { 
//     - x >= 1000:
//         {print_num(x / 1000)} thousand { x mod 1000 > 0:{print_num(x mod 1000)}}
//     - x >= 100:
//         {print_num(x / 100)} hundred { x mod 100 > 0:and {print_num(x mod 100)}}
//     - x == 0:
//         zero
//     - else:
//         { x >= 20:
//             { x / 10:
//                 - 2: twenty
//                 - 3: thirty
//                 - 4: forty
//                 - 5: fifty
//                 - 6: sixty
//                 - 7: seventy
//                 - 8: eighty
//                 - 9: ninety
//             }
//             { x mod 10 > 0:<>-<>}
//         }
//         { x < 10 || x > 20:
//             { x mod 10:
//                 - 1: one
//                 - 2: two
//                 - 3: three
//                 - 4: four        
//                 - 5: five
//                 - 6: six
//                 - 7: seven
//                 - 8: eight
//                 - 9: nine
//             }
//         - else:     
//             { x:
//                 - 10: ten
//                 - 11: eleven       
//                 - 12: twelve
//                 - 13: thirteen
//                 - 14: fourteen
//                 - 15: fifteen
//                 - 16: sixteen      
//                 - 17: seventeen
//                 - 18: eighteen
//                 - 19: nineteen
//             }
//         }
// }  

// // 函数可以传引用,来改变实参的值
// === function alter(ref x, k) ===
// 	~ x = x + k



// // 常量
// // 全局常量
// // 一般用常量来跟踪游戏状态,尤其是字符串常量,可以直接打印来debug
// CONST HASTINGS = "Hastings"
// CONST POIROT = "Poirot"
// CONST JAPP = "Japp"

// VAR current_chief_suspect = HASTINGS

// === review_evidence ===
// 	{ found_japps_bloodied_glove:
// 		~ current_chief_suspect = POIROT
// 	}
// 	Current Suspect: {current_chief_suspect}  

// // 或者定义常用的数值
// CONST PI = 3.14
// CONST VALUE_OF_TEN_POUND_NOTE = 10

// 进阶：外部调用逻辑
  
  
  
  
  
  
  
  
  
  
  
  
  
    