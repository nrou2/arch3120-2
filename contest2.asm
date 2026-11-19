INCLUDE Irvine32.inc
.data
loss BYTE "You Lose",0
vic BYTE "You Win",0
phealth DWORD 100
strength DWORD 10
magic DWORD 10
input DWORD 1
dhealth dword 100
dstrength dword 10
dmagic dword 10
mp DWORD 100 
fullheal DWORD 1
prompt1 BYTE "Enter Number: 1 - Basic Attack 2 - Strengthen Self (costs 10, strength+10) 3 - Heal Self (costs 50, heal up to 50) 4 - Weaken Enemy (costs 15, reduce strength) 5 - Full Heal Item (free, only one) 6 - Icicle Spell (Costs 20)",0
prompt2 BYTE "Your current health: ",0
prompt3 BYTE "Your current mana: ",0
prompt4 BYTE "Enemy current health: ",0
prompt5 BYTE "Move failed, you can't afford it!",0
prompt6 BYTE "Enemy strength can't go any lower than 5!",0
prompt7 BYTE "Enemy current strength: ",0
prompt8 BYTE "You already used that!",0
prompt9 BYTE "Enemy attacked for ",0
prompt10 BYTE "You used a basic attack dealing ",0
prompt11 BYTE "You used a spell dealing ",0
prompt12 BYTE "You healed 50 damage.",0
prompt13 BYTE "You used your full heal up.",0
prompt14 BYTE "You reduced the enemy strength.",0
prompt15 BYTE "You raised your own strength!",0
prompt16 BYTE "Your current strength: ", 0
prompt17 BYTE "Your current magic: ", 0
prompt18 BYTE "Choose your class, Knight, Mage, Dancer (1,2,3)", 0
prompt19 BYTE "Enemy current magic: ", 0
.code
main PROC


mov eax, white + (black * 16)
call SetTextColor

jmp turn


turn:
mov edx,OFFSET prompt1
call WriteString
call Crlf
call Crlf
mov edx,OFFSET prompt2
call WriteString
call Crlf
mov eax, green + (black * 16)
call SetTextColor
mov eax, phealth
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
mov edx,OFFSET prompt3
call WriteString
call Crlf
mov eax, blue + (black * 16)
call SetTextColor
mov eax, mp
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
mov edx,OFFSET prompt4
call WriteString
call Crlf
mov eax, red + (black * 16)
call SetTextColor
mov eax, dhealth
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
mov edx,OFFSET prompt16
call WriteString
call Crlf
mov eax, yellow + (black * 16)
call SetTextColor
mov eax, strength
call WriteInt
mov eax, white + (black * 16)
call SetTextColor
call Crlf
mov edx,OFFSET prompt7
call WriteString
call Crlf
mov eax, yellow + (black * 16)
call SetTextColor
mov eax, dstrength
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
mov edx,OFFSET prompt17
mov eax, white + (black * 16)
call SetTextColor
call WriteString
call Crlf
mov eax, cyan + (black * 16)
call SetTextColor
mov eax, magic
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
mov edx,OFFSET prompt19
mov eax, white + (black * 16)
call SetTextColor
call WriteString
call Crlf
mov eax, cyan + (black * 16)
call SetTextColor
mov eax, dmagic
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
call ReadInt
;I don't remember if we went over ReadInt specifically in class, but I assumed if ReadString works in one of our labs, there'd probably be a ReadInt, and that worked. Same with Writeint, found the register details in the book.
mov input, eax


done:
call ReadInt
INVOKE ExitProcess,0
main ENDP
END main
