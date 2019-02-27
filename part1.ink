// 一、基础
// // 文本段可以标注
// === tag_sample
//     a line of normal game-text

// 带一个选项的默认选择
// choice_sample
// *   choice1
//     result

// // 选择后选项文本消失
// Hello world!
// *	[Hello back!]
// 	Nice to hear from you!

// // 选择后替换文本
// Hello world!
// *	Hello [back!] right back to you!
// 	Nice to hear from you!

// // 选择后替换文本的应用，将简单的选项文本复杂化描述
// "What's that?" my master asked.
// *	"I am somewhat tired[."]," I repeated.
// 	"Really," he responded. "How deleterious."

// // 多选项
// "What's that?" my master asked.
// *	"I am somewhat tired[."]," I repeated.
// 	"Really," he responded. "How deleterious."
// *	"Nothing, Monsieur!"[] I replied.
// 	"Very good, then."
// *  "I said, this journey is appalling[."] and I want no more of it."
// 	"Ah," he replied, not unkindly. "I see you are feeling frustrated. Tomorrow, things will improve."


//指定knot才能运行
// -> back_in_london


// // knot 一段内容 knot外的文本才能自动运行
// === back_in_london ===
// We arrived into London at 9.45pm exactly.
// -> DONE


// //从一个knot跳转到另外一个knot
// === back_in_london_simple ===
// We arrived into London at 9.45pm exactly.
// -> hurry_home 

// === hurry_home === 
// We hurried home to Savile Row as fast as we could.
// -> DONE



// //可以隐式跳转
// === hurry_home ===
// We hurried home to Savile Row -> as_fast_as_we_could

// === as_fast_as_we_could ===
// as fast as we could.
// -> DONE

// // 使用<>来无缝连接
// === hurry_home ===
// We hurried home <> 
// -> to_savile_row 

// === to_savile_row ===
// to Savile Row 
// -> as_fast_as_we_could_simple

// === as_fast_as_we_could_simple ===
// <> as fast as we could.
// ->DONE

// //使用knot、选择、跳转来组合形成分支
// === back_in_london ===

// We arrived into London at 9.45pm exactly.

// *	"There is not a moment to lose!"[] I declared.
// 	-> hurry_outside 
	
// *	"Monsieur, let us savour this moment!"[] I declared.
// 	My master clouted me firmly around the head and dragged me out of the door. 
// 	-> dragged_outside 

// *	[We hurried home] -> hurry_outside

	
// === hurry_outside ===
// We hurried home to Savile Row -> as_fast_as_we_could


// === dragged_outside === 
// He insisted that we hurried home to Savile Row 
// -> as_fast_as_we_could


// === as_fast_as_we_could === 
// <> as fast as we could.


// // knot可以进一步分割为stitches
// === the_orient_express ===
// = in_first_class 
// 	...
// = in_third_class
// 	...
// = in_the_guards_van 
// 	...
// = missed_the_train
// 	...

// // 使用.来指定stitches进行跳转
// *	[Travel in third class]
// 	-> the_orient_express.in_third_class

// *	[Travel in the guard's van]
// 	-> the_orient_express.in_the_guards_van 

// // 不加点则默认跳转到第一个stitch

// // 可以在所有stitches之前写入一些内容，但也需要指定跳转到该knot
// === the_orient_express === 

// We boarded the train, but where?
// *	[First class] -> in_first_class
// *	[Second class] -> in_second_class

// = in_first_class 
// 	...
// = in_second_class
// 	...
	
// // 在一个knot内进行stitch的跳转，不需要完整地址
// -> the_orient_express

// === the_orient_express ===
// = in_first_class 
// 	I settled my master.
// 	*	[Move to third class]
// 		-> in_third_class

// = in_third_class
// 	I put myself in third.

// // 可以include其他脚本来选择knot
// INCLUDE newspaper.ink
// INCLUDE cities/vienna.ink
// INCLUDE journeys/orient_express.ink

// // 选择只能选择一次，之后该选项消失
// // 可以使用不会消失的默认选项，该选项没有文字提示
// -> find_help
// === find_help ===

// 	You search desperately for a friendly face in the crowd. 
// 	*	The woman in the hat[?] pushes you roughly aside. -> find_help
// 	*	The man with the briefcase[?] looks disgusted as you stumble past him. -> find_help 
// 	*	->
// 		But it is too late: you collapse onto the station platform. This is the end.
// 		-> END

// // 也可以使用sticky choice来避免只选一次，用加号表示
// // 默认选项也可以stcky
// ->homers_couch
// === homers_couch ===
// 	+	[Eat another donut]
// 		You eat another donut. -> homers_couch
// 	*	[Get off the couch] 
// 		You struggle up off the couch to go and compose epic poetry.
// 		-> END

// // 条件选项，如果某一个knot中的内容被观察到，则为真
// *	{ not visit_paris } 	[Go to Paris] -> visit_paris
// + 	{ visit_paris 	 } 		[Return to Paris] -> visit_paris 

// *	{ visit_paris.met_estelle } [ Telephone Mme Estelle ] -> phone_estell
// 可以列举多个条件，它们之间以逻辑与组织

// // 实际上条件不是看或者没看，而是一个看过几次的整型，因此条件也可以写为：
// * {seen_clue > 3} [Flat-out arrest Mr Jefferson]

// // 花括号内的文本可以用或符号隔开作为变量，每次遇见该文段时跳转到下一个字段，叫做alternatives
// // 字段内可以用&表示循环
// // 可以用！表示最后进入空白
// // 用~表示随机选择
// // alternatives可以包含空白，可以嵌套，可以跳转，可以在选项中使用
// -> loop_test
// === loop_test ===
// The radio hissed into life. {"Three!"|"Two!"|"One!"|There was the white noise racket of an explosion.|But it was just static.}
// It was {&Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday} today.
// He told me a joke. {!I laughed politely.|I smiled.|I grimaced.|I promised myself to not react again.}
// I tossed the coin. {~Heads|Tails}.
// The Ratbear {&{wastes no time and |}swipes|scratches} {&at you|into your {&leg|arm|cheek}}.

// +   [one more time] -> loop_test

// // 一个巧妙使用alternatives的例子
// -> whack_a_mole
// === whack_a_mole ===
// 	{I heft the hammer.|{~Missed!|Nothing!|No good. Where is he?|Ah-ha! Got him! -> END}}
// 	The {&mole|{&nasty|blasted|foul} {&creature|rodent}} is {in here somewhere|hiding somewhere|still at large|laughing at me|still unwhacked|doomed}. <>
// 	{!I'll show him!|But this time he won't escape!}
// 	* 	[{&Hit|Smash|Try} top-left] 	-> whack_a_mole
// 	*  [{&Whallop|Splat|Whack} top-right] -> whack_a_mole
// 	*  [{&Blast|Hammer} middle] -> whack_a_mole
// 	*  [{&Clobber|Bosh} bottom-left] 	-> whack_a_mole
// 	*  [{&Nail|Thump} bottom-right] 	-> whack_a_mole
// 	*  [] Then you collapse from hunger. The mole has defeated you! 
// 		-> END

// // 另外一个例子
// -> turn_on_television
// === turn_on_television === 
// I turned on the television {for the first time|for the second time|again|once more}, but there was {nothing good on, so I turned it off again|still nothing worth watching|even less to hold my interest than before|nothing but rubbish|a program about sharks and I don't like sharks|nothing on}.
// +	[Try it again]	 		-> turn_on_television
// *	[Go outside instead]	-> go_outside_instead

// alternatives可以结合条件
// {met_blofeld: "I saw him. Only for a moment. His real name was {met_blofeld.learned_his_name: Franz|kept a secret}." | "I missed him. Was he particularly evil?" }

// // 一些保留字，用于查询游戏状态
// // CHOICE_COUNT 返回当前选择中有几个候选项
// // TURNS_SINCE 返回指定文段之后玩家做了几次选择
// *	{TURNS_SINCE(-> sleeping.intro) > 10} You are feeling tired... -> sleeping 
// * 	{TURNS_SINCE(-> laugh) == 0}  You try to stop laughing.