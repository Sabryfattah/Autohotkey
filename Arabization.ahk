#Persistent
#NoEnv
SetBatchLines -1
;==Switch to Arabic Keyboard ====
F12::Suspend

/*
Free Letter B C F H J K L M N p P R v V X
Unicode	Letter			chr
0621 		hamzah 			2
0627 		alif 		a 
0623     alif hamza 		A
0625     alif kasra       	I (Cap i)
0622     alif madda    	@
0628 		ba' 		b
062A 	ta' 		t
062B 	tha' 		c
062C 	jim 		g
062D 	7a' 		7
062E 		kha' 		j
062F 		dal 		d
0630 		dhal 		z 
0631 		ra' 		r
0632 		zayn		Z
0633 		sin 		s
0634 		shin 		x
0635 		Sad 		S
0636 		Dad 		D
0637 		TAa' 		T
0638 		Zha' 		6
0639 		3ayn 		F
063A 	ghayn 			G
0641 		fa' 		f
0642 		qaf 		q
0643 		kaf 		k
0644 		lam 		l
0645 		mim 		m
0646 		nun 		n
0647 		ha' 		h
0648 		waw 	 			w
064A 	ya' 		i
0622 		alif maddah 	y 
0629 		ta' marbutah 	Q
0649 		alif maqsurah 	V
0626     Hamza on Ya`	Y
064F     Damma       	o
064C     Dammteen    	O
064E     Fatha		u
064B		Fathteen		U
0650		Kasra		e
064D		Kasrteen		E
0651		Shadah			&
0652		Sokon			*
0653		Maddah			~
0655		Hamz Satr		_
0654		Hamz 7rf		^
065C		Noktah			.
066B		Faslah			,
0624		waw hamz		W
061F		?			Alt+?			
066A		%			Alt+%			
0660		0			Alt+0			
0661			1		Alt+1			
0662		2			Alt+2			
0663		3			Alt+3			
0664		4			Alt+4			
0665		5			Alt+5			
0666		6			Alt+6			
0667		7			Alt+7			
0668		8			Alt+8			
0669		9			Alt+9			
)
*/

Alphabet =  
(Q
Unicode		Letter			chr
0621 			hamzah			2
0627			alif		a 
0623			alif hamza		A
0625			alif kasra		I (Cap i)
0622			alif madda		@
0628 			ba' 		b
062A 		ta' 		t
062B 		tha' 		c
062C 		jim 		g
062D 		7a' 		7
062E 			kha' 		j
062F 			dal 		d
0630 			dhal 		z 
0631 			ra' 		r
0632 			zayn		Z
0633 			sin 		s
0634 			shin 		x
0635 			Sad 		S
0636 			Dad 		D
0637 			TAa' 		T
0638 			Zha' 		6
0639 			3ayn 		F
063A 		ghayn 			G
0641 			fa' 		f
0642 			qaf 		q
0643 			kaf 		k
0644 			lam 		l
0645 			mim 		m
0646 			nun 		n
0647 			ha' 		h
0648 			waw 	 			w
0624			waw hamz		W
064A 		ya' nokt			i
0649 			alif maqsurah y
0626      	Hamza on Ya`Y
0629 			ta' marbutah 	Q

)

Diacritics =
(Q
064F       	Damma      	o
064C       	Dammteen    	O
064E       	Fatha		u
064B			Fathteen		U
0650			Kasra		e
064D			Kasrteen		E
0651			Shadah			&
0652			Sokon			*
0653			Maddah			~
0655			Hamz Satr		_
0654			Hamz 7rf		^
065C			Noktah			.
066B			Faslah			,
)

Numbers =
(Q
061F		?			Alt+?			
066A		`%		Alt+`%			
0660		0			Alt+0			
0661		1			Alt+1			
0662		2			Alt+2			
0663		3			Alt+3			
0664		4			Alt+4			
0665		5			Alt+5			
0666		6			Alt+6			
0667		7			Alt+7			
0668		8			Alt+8			
0669		9			Alt+9		

)

;========================== Help Gui =========================
!F1::
MyVariable =
(LTrim % " '
hamzah		#		alif		a 
alif hamza	A		alif kasra		I (Cap i)
alif madda	@		ba'		b
ta'		t		tha' 		c
jim		g		7a' 		H
kha' 		j		dal 		d
dhal 		z 		ra' 		r
zayn		Z		sin 		s
shin 		x		Sad		S
Dad 		D		TAa'		T
Zha' 		p		3ayn		F
ghayn 		G		fa'		f
qaf 		q		kaf		k
lam 		l		mim		m
nun 		n		ha'		h
waw		w		waw hamz	W
ya' nokt		i		alif maqsurah	y
Hamza on Ya	`Y		ta' marbutah	Q
Damma		o		Dammteen	O
Fatha		u		Fathteen		U
Kasra		e		Kasrteen		E
Shadah		&		Sokon		*
Maddah		~		Hamz 3la Sat	_
Hamz 3la 7rf	^		Noktah		.
Faslah		,		?		Alt+?
%		Alt+%		0		Alt+0
1		Alt+1		2		Alt+2
3		Alt+3		4		Alt+4
5		Alt+5		6		Alt+6
7		Alt+7		8		Alt+8
9		Alt+9
)
MsgBox % MyVariable
Return
;===================== Alphabet ===============================

; Hamza
:*c:#::
SendUnicodeChar(0x0621)
Return

;-------------------- bare alif----------------
:*c:a::
SendUnicodeChar(0x0627)
Return
; --------------------------- Hamza on Aliph ------
:*c:A::
SendUnicodeChar(0x0623)
Return
; ------------------------ Hamza under Aliph (Capital i) --------
:*c:I::
SendUnicodeChar(0x0625)
Return
; -------------------- Aliph Maddah ----------------------------
:*c:@::
SendUnicodeChar(0x0622)
Return
;---------------------- Ba` --------------------------------------
:*c:b::
SendUnicodeChar(0x0628)
Return
; ----------------------- Ta` ------------------------------------------------------------------
:*c:t::
SendUnicodeChar(0x062A)
Return
; --------------------------- Tha` ------------------------------------------------------------
:*c:c::
SendUnicodeChar(0x062B)
Return
;---------------------------------- Jeem -----------------------------------------------------
:*c:g::
SendUnicodeChar(0x062C)
Return
; -------------------------- 7a` ---------------------------------------------------------------
:*c:H::
SendUnicodeChar(0x062D)
Return
; ----------------------------- Kha` -----------------------------------------------------------
:*c:j::
SendUnicodeChar(0x062E)
Return
; ------------------------------ Dal -----------------------------------------------------------
:*c:d::
SendUnicodeChar(0x062F)
Return
; -------------------------- Zal --------------------------------------------------------------
:*c:z::
SendUnicodeChar(0x0630)
Return
; ------------------------- Ra` ---------------------------------------------------------------
:*c:r::
SendUnicodeChar(0x0631)
Return
;------------------------------------- Zayn --------------------------------------------------
:*c:Z::
SendUnicodeChar(0x0632)
Return
;-------------------------------------- Seen ------------------------------------------------
:*c:s::
SendUnicodeChar(0x0633)
Return
; -------------------------- Sheen ----------------------------------------------------------
:*c:x::
SendUnicodeChar(0x0634)
Return
; ----------------------------------- Saad --------------------------------------------------
:*c:S::
SendUnicodeChar(0x0635)
Return
; ------------------------------------ Daad ------------------------------------------------
:*c:D::
SendUnicodeChar(0x0636)
Return
; ----------------------------------- Taa` -------------------------------------------------
:*c:T::
SendUnicodeChar(0x0637)
Return
; ----------------------------      Dhaa` --------------------------------------------------
:*c:p::
SendUnicodeChar(0x0638)
Return
; ------------------------------------- Ayeen -------------------------------------------
:*c:F::
SendUnicodeChar(0x0639)
Return
; ----------------------------------- Ghayn ---------------------------------------------
:*c:G::
SendUnicodeChar(0x063A)
Return
;----------------------------------- Fa` ------------------------------------------------
:*c:f::
SendUnicodeChar(0x0641)
Return
; ------------------------------------ Qaf ---------------------------------------------
:*c:q::
SendUnicodeChar(0x0642)
Return
;------------------------------------ Kaf ----------------------------------------------
:*c:k::
SendUnicodeChar(0x0643)
Return
; ------------------------------- Laam ------------------------------------------------
:*c:l::
SendUnicodeChar(0x0644)
Return
;----------------------------------- Meem --------------------------------------------
:*c:m::
SendUnicodeChar(0x0645)
Return
;------------------------------- Noon ------------------------------------------------
:*c:n::
SendUnicodeChar(0x0646)
Return
; -------------------------------- Ha` ------------------------------------------------
:*c:h::
SendUnicodeChar(0x0647)
Return
; -------------------------------- Ta`  Marboutah ------------------------------------------------
:*c:Q::
SendUnicodeChar(0x0629)
Return
; ------------------------------ waw ------------------------------------------------
:*c:w::
SendUnicodeChar(0x0648)
Return
; ------------------------------ waw  mahmouza ------------------------------------------------
:*c:W::
SendUnicodeChar(0x0624)
Return
; ------------------------- Ya`  manqoutah ----------------------------------------
:*c:i::
SendUnicodeChar(0x064A)
Return
;-------------------------------   Ya` Maqsoura  -------------------------------
:*c:y::
SendUnicodeChar(0x0649)
Return
;------------------------------- Ya` Mahmouzah ------------------------------
:*c:Y::
SendUnicodeChar(0x0626)
Return
; -================================== Diacritics =============================
;------------------------ Dammah -----------------------
:*c:o::
SendUnicodeChar(0x064F)
Return
;------------------------------- Dammatan ------------------------------------
:*c:O::
SendUnicodeChar(0x064C)
Return
;---------------------------------- Fatiha ------------------------------------
:*c:u::
SendUnicodeChar(0x064E)
Return
;--------------------------------------- Fatihatan ------------------------------
:*c:U::
SendUnicodeChar(0x064B)
Return
;------------------------------ Kasrah --------------------------------------------
:*c:e::
SendUnicodeChar(0x0650)
Return
;--------------------------------- Kasrattan -----------------------------------
:*c:E::
SendUnicodeChar(0x064D)
Return
;--------------------------------- Shaddah ------------------------------------
:*c:&::
SendUnicodeChar(0x0651)
Return
;----------------------------- Skoon -----------------------------------------
:*c:*::
SendUnicodeChar(0x0652)
Return
;--------------------------- Maddah ----------------------------------------
:*c:~::
SendUnicodeChar(0x0653)
Return
;------------------------- Hamza ala 7rf ----------------------------------
:*c:^::
SendUnicodeChar(0x0654)
Return
;-------------------------- Hamza ala Sattr  (Underscore )------------------------------
:*c:_:: 
SendUnicodeChar(0x0655)
Return
;-===================== Punctuation ===========================
;--------------------------- Noqtah  ----------------------------------------
;:*c:.::
;SendUnicodeChar(0x065C)
;Return
;-------------------------  Istifeham ----------------------------------
:*c:?::
SendUnicodeChar(0x061F)
Return
;--------------------------  Faslah ------------------------------
:*c:,::
SendUnicodeChar(0x066B)
Return
;-------------------------  Faslah Manquotah ; ----------------------------------
:*c:;::
SendUnicodeChar(0x061B)
Return
--------------------------  Dash ------------------------------
:*c:-::
SendUnicodeChar(0x0640)
Return
;-------------------------  Astrix * ; ----------------------------------
:*c:\*::
SendUnicodeChar(0x061B)
Return
;-===================== ARABIC (INDIAN) NUMBERS===========================
;--------------------------- Safr ----------------------------------------
:*c:0::
SendUnicodeChar(0x0660)
Return
;-------------------------  One----------------------------------
:*c:1::
SendUnicodeChar(0x0661)
Return
;--------------------------  Two------------------------------
:*c:2::
SendUnicodeChar(0x0662)
Return
;-------------------------  Three ----------------------------------
:*c:3::
SendUnicodeChar(0x0663)
Return
--------------------------  Four  ------------------------------
:*c:4::
SendUnicodeChar(0x0664)
Return
;-------------------------  Five ----------------------------------
:*c:5::
SendUnicodeChar(0x0665)
Return
;-------------------------  Six---------------------------------
:*c:6::
SendUnicodeChar(0x0666)
Return
;--------------------------  Seven ------------------------------
:*c:7::
SendUnicodeChar(0x0667)
Return
;-------------------------  Eight----------------------------------
:*c:8::
SendUnicodeChar(0x0668)
Return
;--------------------------  Nine ------------------------------
:*c:9::
SendUnicodeChar(0x0669)
Return
;=========================================================================================
SendUnicodeChar(charCode)
{
	VarSetCapacity(ki, 28 * 2, 0)
	EncodeInteger(&ki + 0, 1)
	EncodeInteger(&ki + 6, charCode)
	EncodeInteger(&ki + 8, 4)
	EncodeInteger(&ki +28, 1)
	EncodeInteger(&ki +34, charCode)
	EncodeInteger(&ki +36, 4|2)

	DllCall("SendInput", "UInt", 2, "UInt", &ki, "Int", 28)
}

EncodeInteger(ref, val)
{
	DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}
;========================================
^+x::
ExitApp
Return