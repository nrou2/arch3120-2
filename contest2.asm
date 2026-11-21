	INCLUDE Irvine32.inc
	.data
	;;Various flags and stats
	phealth DWORD 100
	strength DWORD 10
	magic DWORD 10
	input DWORD 1
	dhealth dword 100
	dstrength dword 10
	dmagic dword 10
	mp DWORD 100 
	fullheal DWORD 0
	class DWORD 1
	defend dword 0
	debuffstacks dword 0
	wave dword 1
	mmp dword 100
	mhp dword 100
	bstrength dword 10
	bmagic dword 10
	choices dword 2
	epoison dword 0
	ppoison dword 0
	jack dword 0
	vampire dword 0
	priest dword 0
	phantom dword 0
	hexblade dword 0
	absorb dword 0
	absorbing dword 0


	;move unlocks
	poison dword 0
	shockspell dword 0
	buff dword 0
	heal dword 0
	ice dword 0
	regen dword 0

	;text strings
	loss BYTE "You Lose",0
	vic BYTE "You Win",0
	prompt1 BYTE "Enter Number of an unlocked attack (not all are, 1 and 2 are free): ",0
	prompt101 Byte "1 - Basic Attack ", 0
	prompt102 Byte "2 - Concentrate (Block half of next attack + class specific bonus)",0
	prompt103 BYTE "3 - Shockspell  (Inconsistent damage averaging on your magic, 20 mana)",0
	prompt104 byte "4 - Strengthen Self (10mp)", 0
	prompt105 BYTE "5 - Full restore (if owned)",0
	prompt106 byte "6 - poison (40mp) ", 0
	prompt107 byte "7 - healing (40mp) ", 0
	prompt108 byte "8 - icicle shot (40mp, twice your magic + 10 damage) ", 0
	prompt109 byte "9 - Absorption (once per fight, mage only)", 0
	prompt2 BYTE "Your current health: ",0
	prompt3 BYTE "Your current mana: ",0
	prompt4 BYTE "Enemy current health: ",0
	prompt5 BYTE "Move failed, you can't afford it!",0
	prompt6 BYTE "Enemy strength can't go any lower!",0
	prompt7 BYTE "Enemy current strength: ",0
	prompt8 BYTE "You already used that!",0
	prompt9 BYTE "Enemy attacked for ",0
	prompt10 BYTE "You used a basic attack dealing ",0
	prompt11 BYTE "You shocked the enemy, dealing ",0
	prompt12 BYTE "You healed using 5x your magic stat.",0
	prompt13 BYTE "You used your full heal up.",0
	prompt14 BYTE "You reduced the enemy strength.",0
	prompt15 BYTE "You raised your own strength!",0
	prompt16 BYTE "Your current strength: ", 0
	prompt17 BYTE "Your current magic: ", 0
	prompt18 BYTE "Choose your class, Knight, Mage, Dancer (1,2,3)", 0
	prompt19 BYTE "Enemy current magic: ", 0
	prompt20 BYTE "Knight: 125 hp, 50 mana, 13 strength, 5 magic.  May parry on defend.", 0
	prompt21 BYTE "Mage: 100 hp, 120 mana, 5 strength, 11 magic. Comes with shockspell, +15 mp on defend. Can absorb 1 attack per fight", 0
	prompt22 BYTE "Dancer: 90 hp, 80 mana, 7 strength, 8 magic. Comes with strength buff,poison, full restore, may debuff on defend.", 0
	prompt23 BYTE "You parried the attack, receiving half damage and reflecting more.", 0
	prompt24 BYTE "You cursed your armor, weakening the enemy on touch.", 0
	prompt25 BYTE "You either lack the mana, or the move itself. Restarting turn.", 0
	prompt26 BYTE "Pick two. You have automatically restored 50% HP and MP along the way.",0
	prompt27 BYTE "1 - Poison: 5% of enemy HP per turn, 40 mana. More effective as dancer.",0
	prompt28 BYTE "2 - Strength Buff: +2 strength, 10 mana.",0
	prompt29 BYTE "3 - Heal: +Magic x 5 HP, 30 mana. Can overheal.",0
	prompt30 BYTE "4 - Icicle Shot: 2 x Magic + 10 damage, 40 mana.",0
	prompt31 BYTE "5 - Full Restore Item.",0
	prompt32 BYTE "6 - +20 max HP, +2 magic, instantly restore HP and MP to full.",0
	prompt33 BYTE "7 - +20 max MP, +2 strength, instantly restore HP and MP to full.",0
	prompt34 BYTE "You poison the enemy.", 0
	prompt35 BYTE "From the poison, the enemy was hurt for ", 0
	prompt36 BYTE "You shot icicles at the enemy, dealing ",0
	prompt37 BYTE "Pick 2 benefits. You were healed fully this time. Subclasses:",0
	prompt38 BYTE "1 - Jack: +20 hp, +15 mp, +1 str, +1 mag",0
	prompt39 BYTE "2 - Vampire: +1 strength, +50% lifesteal on basic attack", 0
	prompt40 Byte "3 - Priest: +10 mp, restore health per turn, with more gained the more mp you are missing.", 0
	prompt41 Byte "4 - Phantom: +3 magic, drain 10 mp on attack.", 0
	prompt42 Byte "5 - Hexblade: Basic attack deals 5% of enemy's current hp. More effective as dancer.", 0
	prompt43 Byte "Spells you may have missed:", 0
	prompt44 Byte "6 - Heal", 0
	prompt45 Byte "7 - Icicle Shot:", 0
	prompt46 Byte "Healed yourself with an additional stolen ", 0
	prompt47 Byte "The curse wrang an additional ", 0
	prompt48 Byte "Your blessings healed you for", 0
	prompt49 Byte "Your MP was restored  a bonus 10", 0

	.code
	main PROC


	mov eax, white + (black * 16)
	call SetTextColor
	;;Initial class description prompt, telling you what each one does so you can pick one
	mov edx,OFFSET prompt18
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt20
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt21
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt22
	call WriteString	
	CALL CRLF
	call ReadInt
	Call Clrscr
	CALL CRLF
	;I don't remember if we went over ReadInt specifically in class, but I assumed if ReadString works in one of our labs, there'd probably be a ReadInt, and that worked. Same with Writeint, found the register details in the book.
	mov input, eax
	dec input
	jz knight
	dec input
	jz mage
	dec input
	jz dancer

	;;Initialize the player with the right parameters for their class, and make sure their class flag is tripped
	knight: 
	mov strength, 13
	mov magic, 5
	mov phealth, 125
	mov mp, 50
	mov class, 1
	mov mmp, 50
	mov mhp, 125
	mov bstrength, 13
	mov bmagic, 5
	jmp turn1
	mage:
	mov strength, 5
	mov magic, 11
	mov phealth, 100
	mov mp, 120
	mov class, 2
	mov shockspell, 1
	mov mmp, 120
	mov mhp, 100
	mov bstrength, 5
	mov bmagic, 11
	mov absorb, 1
	jmp turn1
	dancer:
	mov fullheal,1 
	mov strength, 7
	mov magic, 8
	mov phealth, 90
	mov mp, 80
	mov buff, 1
	mov class, 3
	mov mmp, 80
	mov mhp, 90
	mov bstrength, 7
	mov bmagic, 8
	mov poison, 1
	jmp turn1




	turn1:
	;;Ultimately this portion heals the player by roughly 15 * the percentage of mp they are missing
	mov eax, white + (black * 16)
	call SetTextColor
	cmp priest, 1
	jl afterpriest
	mov eax, mmp
	mov ebx, mp
	sub eax, ebx
	mov eax, mmp
	sub eax, mp        
	mov ebx, 15
	mul ebx            
	mov ebx, mmp
	div ebx            
	add phealth, eax
	mov eax, ebx
	mov eax, yellow + (black * 16)
	mov edx,OFFSET prompt48
	call WriteString	
	mov ebx, eax
	call WriteInt
	CALL CRLF
	CALL CRLF
	mov eax, white + (black * 16)

	afterpriest:
	;;Write out instruction list. Also clear the defending flag
	mov defend, 0
	mov edx,OFFSET prompt1
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt101
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt102
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt103
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt104
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt105
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt106
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt107
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt108
	call WriteString
	CALL CRLF
	mov edx,OFFSET prompt109
	call WriteString
	CALL CRLF
	CALL CRLF
	mov edx,OFFSET prompt2
	call WriteString
	CALL CRLF
	;Write out player and enemy stats
	mov eax, green + (black * 16)
	call SetTextColor
	mov eax, phealth
	call WriteInt
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt3
	call WriteString
	CALL CRLF
	mov eax, blue + (black * 16)
	call SetTextColor
	mov eax, mp
	call WriteInt
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt4
	call WriteString
	CALL CRLF
	mov eax, red + (black * 16)
	call SetTextColor
	mov eax, dhealth
	call WriteInt
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt16
	call WriteString
	CALL CRLF
	mov eax, yellow + (black * 16)
	call SetTextColor
	mov eax, strength
	call WriteInt
	mov eax, white + (black * 16)
	call SetTextColor
	CALL CRLF
	mov edx,OFFSET prompt7
	call WriteString
	CALL CRLF
	mov eax, yellow + (black * 16)
	call SetTextColor
	mov eax, dstrength
	call WriteInt
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt17
	mov eax, white + (black * 16)
	call SetTextColor
	call WriteString
	CALL CRLF
	mov eax, cyan + (black * 16)
	call SetTextColor
	mov eax, magic
	call WriteInt
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt19
	mov eax, white + (black * 16)
	call SetTextColor
	call WriteString
	CALL CRLF
	mov eax, cyan + (black * 16)
	call SetTextColor
	mov eax, dmagic
	call WriteInt
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	call ReadInt
	CALL CRLF
	;I don't remember if we went over ReadInt specifically in class, but I assumed if ReadString works in one of our labs, there'd probably be a ReadInt, and that worked. Same with Writeint, found the register details in the book.
	call Clrscr
	mov input, eax
	;;Decide branch based on what the player enters
	dec input
	jz attack
	dec input
	jz concentrate
	dec input
	jz shock
	dec input
	jz strbuff
	dec input
	jz item
	dec input
	jz poisoning
	dec input
	jz  healing
	dec input
	jz icespell
	dec input
	jz aborp

	attack:
	mov eax, green + (black * 16)
	call SetTextColor
	call Randomize
	;CALL CRLF
	mov edx,OFFSET prompt10
	call WriteString
	;;Figure out the attack value after the random variation
	mov eax, 7
	call RandomRange
	sub eax, 3
	;Random variation of +- 3 in player basic attack, consistency can be gained through using spell attack instead

	mov ebx, dhealth
	sub ebx, strength
	sub ebx, eax
	mov dhealth, ebx



	add eax, strength
	call WriteInt
	CALL CRLF


	;;If the player is vampire, give their lifesteal 
	cmp vampire, 1
	jl attack2
	shr eax, 1
	add phealth, eax
	mov edx,OFFSET prompt46
	call WriteString
	call WriteInt
	CALL CRLF
	jmp attack2

	attack2:
	;;If the player is phantom, then give them their 10mp 
	cmp phantom, 1
	jl attack3
	mov eax, blue + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt49
	call WriteString
	add mp, 10
	jmp attack3

	attack3:
	;;If the player is hexblade,give the bonus that deals 1/8th of the enemy's health. A bonus 16th if dancer.
	;;I originally thought of having the subclasses as upgrades to the existing classes, this was Dancer's
	;; I decided to open them up for more player creativity, but still wanted to give dancer something
	;;Since it lost a piece of its vision more than the others in doing so
	cmp hexblade, 1
	jl attack4
	mov eax, lightmagenta + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt47
	call WriteString
	CALL CRLF
	mov eax, dhealth
	shr eax, 3
	mov ebx, eax

	cmp class, 3
	jne attack35
	shr ebx, 1
	add eax, ebx

	attack35:
	call WriteInt
	sub dhealth,eax


	attack4:
	;;Return text color, see if the fight has been won yet and transition to the next fight / final win screen
	mov eax, white + (black * 16)
	call SetTextColor

	cmp dhealth, 0
	jle win
	jmp enemy

	concentrate:
	;;Cue the defend state, and bring back some mp if you're the mage.
	;;Other defend features are in the enemy's turn, since it attacks then
	mov defend, 1
	cmp class, 2
	jz concentraterestore
	jmp enemy
	concentraterestore:
	add mp, 15
	jmp enemy



	shock:
	;;check if youre allowed to use it
	cmp class, 2
	jne shockfail
	cmp mp, 20
	jb shockfail


	;;deal a random amount of damage, the player's magic + 3, +- 14 at random, for 20 mp, then check if you won the fight with that
	mov edx,OFFSET prompt11
	mov eax, green + (black * 16)
	call SetTextColor
	call WriteString
	jle enemy
	sub mp, 20
	mov eax, 28
	call RandomRange
	sub eax, 14
	add eax, magic
	add eax, 3
	sub dhealth, eax
	call WriteInt
	mov eax, yellow + (black * 16)
	CALL CRLF
	cmp dhealth, 0
	jle win
	jmp enemy

	icespell:
	;;Check if the player can use the ice spell
	cmp ice, 0
	je shockfail
	cmp mp, 40
	jb shockfail
	;;Deal 2xMagic+10 damage, and subtract 40 mana from the player. Win if it cuts hp to 0
	mov edx,OFFSET prompt36
	mov eax, green + (black * 16)
	call SetTextColor
	call WriteString
	call Crlf
	sub mp, 40
	mov eax, magic
	shl eax, 1
	add eax, 10
	call WriteInt
	sub dhealth, eax
	cmp dhealth, 0
	jle win
	jmp enemy

	shockfail:
	;;General purpose spell failure message that lets you choose your turn again.
	;;It's called shock because shock is simply the first one I designed it for, then realized I didn't need to remake it every time
	mov eax, yellow + (black * 16)
	mov edx,OFFSET prompt25
	call WriteString
	jmp turn1

	healing:
	;;Heal the player for 5x their magic, but move to the spell fail branch if they cant
	cmp heal, 0
	je shockfail
	cmp mp, 30
	jb shockfail
	sub mp, 30
	mov eax, green + (black * 16)
	call SetTextColor
	CALL CRLF
	mov edx,OFFSET prompt12
	call WriteString
	CALL CRLF
	mov eax, magic
	mov ebx, 5
	mul ebx
	add phealth, eax
	jmp enemy

	aborp:
	cmp absorb, 1
	jne turn1
	cmp class, 2
	jne turn1

	mov absorb, 0
	mov absorbing, 1

	poisoning:
	;;Poison the enemy, but jump to the spell fail branch if it fails
	cmp poison, 0
	je shockfail
	cmp mp, 40
	jb shockfail
	sub mp, 40
	mov eax, magenta + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt34
	call WriteString
	CALL CRLF
	mov epoison,1

	jmp enemy

	strbuff:
	;;Check if the player is allowed to buff or not
	cmp buff, 0
	je shockfail
	;CALL CRLF
	mov eax, mp
	sub eax, 10
	cmp eax,0

	JGE buffsuccess
	mov eax, red + (black * 16)
	call SetTextColor
	mov edx,OFFSET prompt5

	CALL CRLF
	call WriteString
	CALL CRLF

	mov eax, white + (black * 16)
	call SetTextColor
	jmp enemy

	buffsuccess:
	;;Increase strength if you own the buff and can afford it and use it
	mov eax, mp
	sub eax, 10
	mov mp, eax
	mov eax, green + (black * 16)
	call SetTextColor
	add strength,2
	mov edx,OFFSET prompt15
	call WriteString
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	jmp enemy

	item:
	cmp fullheal, 0
	JNZ itemsuccess
	;;Tell you that you failed if you use the item without owning it
	mov eax, red + (black * 16)
	call SetTextColor

	
	
	mov edx,OFFSET prompt8
	call WriteString

	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor

	jmp turn1


	itemsuccess:
	;;Restore all of your hp and mp to your default max if you use the item
	CALL CRLF
	mov eax, green + (black * 16)
	call SetTextColor
	mov fullheal,0
	mov eax, mhp
	mov phealth, eax
	mov eax,mmp
	mov mp, eax
	mov edx,OFFSET prompt13
	call WriteString
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	jmp enemy



	enemy:
	mov eax, magenta + (black * 16)
	call SetTextColor
	call Randomize

	mov edx,OFFSET prompt35
	cmp epoison, 0
	je enemy11
	call WriteString

	enemypoison1:
	;;Add poison damage up to 5%, adding more for each wave, and a bonus if the player is dancer
	mov eax, 5
	cmp wave, 1
	jle enemypoison4
	enemypoison2:
	add ax, 3
	cmp wave, 2
	jle enemypoison4
	enemypoison3:
	add eax, 7
	jmp enemypoison4

	enemypoison4:
	cmp class, 3
	jne enemypoison
	add eax, 5

	enemypoison: 
	call WriteInt
	CALL CRLF
	sub dhealth, eax
	cmp dhealth, 0
	jle win

	enemy11:
	;;Set up attack values, but hold onto them incase they need to be adjusted due to defend
	mov eax, red + (black * 16)
	call SetTextColor
	call Randomize
	;CALL CRLF
	;CALL CRLF
	mov edx,OFFSET prompt9
	call WriteString

	mov eax, 10
	call RandomRange
	mov ebx, 0
	add ebx, dstrength
	add ebx, eax

	cmp defend, 0
	jz enemy15
	jmp enemy125

	enemy125:
	;;Cut damage in half if you are concentrating/defending
	shr ebx, 1
	shr eax, 1
	sub phealth, ebx
	add eax, ebx
	call WriteInt
	CALL CRLF
	CALL CRLF

	cmp class, 1
	je enemy155

	cmp class, 3
	je enemy165

	jmp enemy175

	enemy15:
	sub phealth, ebx
	add eax, dstrength
	call WriteInt
	;CALL CRLF
	;CALL CRLF
	jmp enemy175

	enemy155:
	;;Reflect damage if you are the knight and successfully roll for parry
	mov eax, 2
	call RandomRange
	cmp eax, 1
	je enemy175
	mov eax, dstrength
	sub dhealth, eax
	mov eax, strength
	sub dhealth, eax
	mov edx,OFFSET prompt23
	mov eax, green + (black * 16)
	call SetTextColor
	call WriteString
	;CALL CRLF
	;CALL CRLF

	cmp dhealth, 0
	jle win
	jmp enemy175
	enemy165:
	;Roll for debuff curse if you are the dancer
	mov eax, 2
	call RandomRange
	cmp eax, 1
	je enemy175
	add debuffstacks, 1
	cmp debuffstacks, 5
	jg enemy170

	mov eax, dstrength
	mov edx, 0        
	mov ebx, 10       
	div ebx     
	sub dstrength, eax
	sub dstrength, 1

	mov edx,OFFSET prompt24
	mov eax, green + (black * 16)
	call SetTextColor
	call WriteString
	;CALL CRLF
	;CALL CRLF
	jmp enemy175

	enemy170:
	;;Alert that youve debuffed the enemy too much, if youve hit the limit
	mov edx,OFFSET prompt6
	mov eax, yellow + (black * 16)
	call SetTextColor
	call WriteString
	;CALL CRLF
	CALL CRLF


	enemy175:
	;;Check if the enemy is dead by now, if its not then go to the next turn
	mov eax, white + (black * 16)
	call SetTextColor

	cmp phealth,0
	jle lose
	CALL CRLF
	CALL CRLF
	jmp turn1


	win:
	;;Move to the correct transition between fights, or to the final victory screen
	mov choices, 2
	add wave, 1
	cmp wave, 2
	je shop1
	cmp wave, 3
	je shop2
	jmp truewin


	lose:
	;Write that you lost, and skip to end of program
	CALL CRLF
	mov eax, red + (black * 16)
	call SetTextColor
	mov edx,OFFSET loss
	call WriteString
	jmp done


	shop1:
	mov eax, yellow + (gray * 16)
	call SetTextColor
	call Clrscr
	;;write out all the shop prompts
	mov edx, OFFSET prompt26
	call WriteString
	call crlf
	mov edx, OFFSET prompt27
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt28
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt29
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt30
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt31
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt32
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt33
	call WriteString
	CALL CRLF
	sub choices, 1
	call ReadInt
	mov input, eax

	cmp input, 1
	je chosepoison
	cmp input, 2
	je chosebuff
	cmp input, 3
	je choseheal
	cmp input, 4
	je choseice
	cmp input, 5
	je choseitem
	cmp input, 6
	je chosehp
	cmp input, 7
	je chosemp

	jmp turn1
	;;flip the flag to unlock whichever option you chose
	chosepoison:
	mov poison,1
	jmp transition12
	chosebuff:
	mov buff, 1
	jmp transition12
	choseheal:
	mov heal, 1
	jmp transition12
	choseice:
	mov ice, 1
	jmp transition12
	choseitem:
	add fullheal,1
	jmp transition12
	chosehp:
	add mhp,20
	add bmagic, 2
	jmp transition12
	chosemp:
	add mmp, 20
	add bstrength, 2
	jmp transition12


	transition12:
	cmp choices, 1
	mov eax, mhp
	shr eax, 1
	add phealth, eax
	mov eax, mmp
	shr eax, 1
	add mp, eax

	mov eax, mmp
	cmp mp, eax
	jg transition122
	jmp transition123
	transition122:

	;;make sure you arent overhealed in hp or mp
	mov eax, mmp
	mov mp, eax


	transition123:
	mov eax, mhp
	cmp phealth, eax
	jg transition124
	jmp transition125

	transition124:
	mov eax, mhp
	mov phealth, eax

	transition125:
	cmp choices,1
	je shop1
	;reset enemy and player health and buffs before throwing you into the 2nd fight
	mov eax, bstrength
	mov strength, eax
	mov eax, bmagic
	mov magic, eax
	mov dhealth, 150
	mov strength, 15
	mov epoison, 0
	mov ppoison, 0
	mov eax, white + (black * 16)
	call SetTextColor
	call Clrscr
	jmp turn1

	shop2:
	mov eax, magenta + (white * 16)
	call SetTextColor
	call Clrscr

	;Write out each line of the shop prompt, there's a lot

	mov eax, magenta + (white * 16)
	call SetTextColor
	mov edx, OFFSET prompt37
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt38
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt39
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt40
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt41
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt42
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt43
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt44
	call WriteString
	CALL CRLF
	mov edx, OFFSET prompt45
	call WriteString
	CALL CRLF
	call ReadInt
	;select the jump based on your input, to which option itll give you, which one you chose
	mov input, eax
	cmp input, 1
	je chosejack
	cmp input, 2
	je chosevampire
	cmp input, 3
	je chosepriest
	cmp input, 4
	je chosephantom
	cmp input, 5
	je chosehexblade
	cmp input, 6
	je choseheal2
	cmp input, 7
	je choseice2
	jmp shop2

	;set the stat boosts and class variable for each option, or give you the spell
	chosejack:
	mov jack, 1
	add mhp, 20
	add mmp, 15
	add bstrength, 1
	add bmagic, 1
	jmp transition23
	chosevampire:
	add bstrength, 1
	mov vampire, 1
	jmp transition23
	chosepriest:
	add mmp, 1
	mov priest, 1
	jmp transition23
	chosephantom:
	add bmagic, 3
	mov phantom, 1
	jmp transition23
	chosehexblade:
	mov hexblade, 1
	jmp transition23
	choseheal2:
	mov heal, 1
	jmp transition23
	choseice2:
	mov ice,1
	jmp transition23


	transition23:
	;return to the shop if you still have a pick left	
	sub choices, 1
	cmp choices, 0
	jne shop2
	;reset player and enemy health parameters before sending you to the last fight
	mov eax, mhp
	mov phealth, eax
	mov eax, mmp
	mov mp, eax
	mov eax, bstrength
	mov strength, eax
	mov eax, bmagic
	mov magic, eax
	mov dhealth, 300
	mov dstrength, 20
	mov epoison, 0
	mov ppoison, 0
	call Clrscr
	mov eax, white + (black * 16)
	call SetTextColor
	jmp turn1


	truewin:
	;finish the program with the victory screen
	CALL CRLF
	mov eax, white + (black * 16)
	call SetTextColor
	mov edx,OFFSET vic
	call WriteString
	;CALL CRLF
	done:
	call ReadInt
	INVOKE ExitProcess,0
	main ENDP
	END main
