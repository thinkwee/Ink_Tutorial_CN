// // 二、使用weave来组织游戏，包括gather和nested flow
// // 使用-代表gather，将各个分支收束到一个点
// "What's that?" my master asked.
// 	*	"I am somewhat tired[."]," I repeated.
// 		"Really," he responded. "How deleterious."
// 	*	"Nothing, Monsieur!"[] I replied.
// 		"Very good, then."
// 	*  "I said, this journey is appalling[."] and I want no more of it."
// 	"Ah," he replied, not unkindly. "I see you are feeling frustrated. Tomorrow, things will improve."

// -	With that Monsieur Fogg left the room.

// // 因此我们可以用gather加选项来往前推进故事
// -> escape
// === escape === 
// I ran through the forest, the dogs snapping at my heels.

// 	* 	I checked the jewels[] were still in my pocket, and the feel of them brought a spring to my step. <>
	
// 	*  I did not pause for breath[] but kept on running. <>

// 	*	I cheered with joy. <>

// - 	The road could not be much further! Mackie would have the engine running, and then I'd be safe.
  
// 	*	I reached the road and looked about[]. And would you believe it?
// 	* 	I should interrupt to say Mackie is normally very reliable[]. He's never once let me down. Or rather, never once, previously to that night.

// -	The road was empty. Mackie was nowhere to be seen.

// // 使用缩进来嵌套选项
// - 	"Well, Poirot? Murder or suicide?"
// 	*	"Murder!"
// 	 	"And who did it?"
// 		* * 	"Detective-Inspector Japp!"
// 		* * 	"Captain Hastings!"
// 		* * 	"Myself!"
// 	* 	"Suicide!"
// 		"Really, Poirot? Are you quite sure?"
// 		* * 	"Quite sure."
// 		* *		"It is perfectly obvious."
// 	-	Mrs. Christie lowered her manuscript a moment. The rest of the writing group sat, open-mouthed.

// // gather也可以嵌套
// - 	"Well, Poirot? Murder or suicide?"
// 		*	"Murder!"
// 		 	"And who did it?"
// 			* * 	"Detective-Inspector Japp!"
// 			* * 	"Captain Hastings!"
// 			* * 	"Myself!"
// 			- - 	"You must be joking!"
// 			* * 	"Mon ami, I am deadly serious."
// 			* *		"If only..."
// 		* 	"Suicide!"
// 			"Really, Poirot? Are you quite sure?"
// 			* * 	"Quite sure."
// 			* *		"It is perfectly obvious."
// 		-	Mrs. Christie lowered her manuscript a moment. The rest of the writing group sat, open-mouthed.

// // 一个使用嵌套weave的完整例子
// - I looked at Monsieur Fogg 
// *	... and I could contain myself no longer.
// 	'What is the purpose of our journey, Monsieur?'
// 	'A wager,' he replied.
// 	* * 	'A wager!'[] I returned.
// 			He nodded. 
// 			* * * 	'But surely that is foolishness!'
// 			* * *  'A most serious matter then!'
// 			- - - 	He nodded again.
// 			* * *	'But can we win?'
// 					'That is what we will endeavour to find out,' he answered.
// 			* * *	'A modest wager, I trust?'
// 					'Twenty thousand pounds,' he replied, quite flatly.
// 			* * * 	I asked nothing further of him then[.], and after a final, polite cough, he offered nothing more to me. <>
// 	* * 	'Ah[.'],' I replied, uncertain what I thought.
// 	- - 	After that, <>
// *	... but I said nothing[] and <> 
// - we passed the day in silence.
// - -> END

// // gather可以使用括号来标记，这样就可以跳转或者做条件测试
// ->meet_guard
// === meet_guard ===
// The guard frowns at you.

// * 	(greet) [Greet him]
// 	'Greetings.'
// *	(get_out) 'Get out of my way[.'],' you tell the guard.

// - 	'Hmm,' replies the guard.

// *	{greet} 	'Having a nice day?' // only if you greeted him

// * 	'Hmm?'[] you reply.

// *	{get_out} [Shove him aside] 	 // only if you threatened him
// 	You shove him sharply. He stares in reply, and draws his sword!
// 	-> DONE		// this route diverts out of the weave

// -	'Mff,' the guard replies, and then offers you a paper bag. 'Toffee?'

// -> END

// // knot内的跳转
// === knot ===
// = stitch_one 
// 	- (gatherpoint) Some content.
// = stitch_two 
// 	*	{stitch_one.gatherpoint} Option
	
// // knot间的跳转
// === knot_one ===
// -	(gather_one)
// 	* {knot_two.stitch_two.gather_two} Option
// === knot_two ===
// = stitch_two 
// 	- (gather_two) 
// 		*	{knot_one.gather_one} Option
		
// // 所有的选项都可以加标注
// === fight_guard ===
// ...
// = throw_something 
// *	(rock) [Throw rock at guard] -> throw
// * 	(sand) [Throw sand at guard] -> throw

// = throw
// You hurl {throw_something.rock:a rock|a handful of sand} at the guard.

// // 使用标注，就可以在weave内进行循环
// - (opts)
// 	*	'Can I get a uniform from somewhere?'[] you ask the cheerful guard.
// 		'Sure. In the locker.' He grins. 'Don't think it'll fit you, though.'
// 	*	'Tell me about the security system.'
// 		'It's ancient,' the guard assures you. 'Old as coal.'
// 	*	'Are there dogs?'
// 		'Hundreds,' the guard answers, with a toothy grin. 'Hungry devils, too.'
// 	// We require the player to ask at least one question
// 	*	{loop} [Enough talking] 
// 		-> done
// - (loop) 
// 	// loop a few times before the guard gets bored
// 	{ -> opts | -> opts | }
// 	He scratches his head.
// 	'Well, can't stand around talking all day,' he declares. 
// - (done)
// 	You thank the guard, and move away.

// // 跳转到选项
// - (opts)
// *	[Pull a face]
// 	You pull a face, and the soldier comes at you! -> shove

// *	(shove) [Shove the guard aside] You shove the guard to one side, but he comes back swinging.

// *	{shove} [Grapple and fight] -> fight_the_guard

// - 	-> opts

// // 在选项之后直接gather
// *	"Are you quite well, Monsieur?"[] I asked.
// 	- - (quitewell) "Quite well," he replied. 
// *	"How did you do at the crossword, Monsieur?"[] I asked.
// 	-> quitewell 
// *	I said nothing[] and neither did my Master.
// -	We feel into companionable silence once more.