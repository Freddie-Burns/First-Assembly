;
; 13_01.asm
;
; Created: 13/01/2017 09:44:53
; Author : kfb14
;
;  **  ATmega128(L) Assembly Language File - IAR Assembler Syntax **
;  **  Author  : Jordan Nash
;  **  Company : Imperial College London
;  **  Comment : Simple program to get started
;
		.ORG	0
		;
		;
		; The first instruction jumps to our initialization routine
		;
         rjmp Init


Init:                
   		;
		;  Setup the Stack Pointer to point at the end of SRAM
		;  Put $0FFF in the 1 word SPH:SPL register pair
		; 
		ldi r16, $0F		; Stack Pointer Setup 
		out SPH,r16			; Stack Pointer High Byte 
		ldi r16, $FF		; Stack Pointer Setup 
		out SPL,r16			; Stack Pointer Low Byte 
   		;
		; RAMPZ Setup Code
		; Setup the RAMPZ so we are accessing the lower 64K words of program memory
		;
		ldi  r16, $00		; 1 = EPLM acts on upper 64K
		out RAMPZ, r16		; 0 = EPLM acts on lower 64K
   		;
		; Comparator Setup Code
		; set the Comparator Setup Registor to Disable Input capture and the comparator
		; 
		ldi r16,$80			; Comparator Disabled, Input Capture Disabled 
		out ACSR, r16		; 
   		;
		; Port B Setup Code
		; Set up PORTB (the LEDs on STK300) as outputs by setting the direction register
		; bits to $FF. Set the initial value to $00 (which turns on all the LEDs) 
		; 
		ldi r16, $FF		; 
		out DDRB , r16		; Port B Direction Register
		ldi r16, $00		; Init value 
		out PORTB, r16		; Port B value
		ldi r16, $FF		; 
		out DDRA , r16		; Port B Direction Register
		ldi r16, $00		; Init value 
		out PORTA, r16		; Port B value
   		;
		; Port D Setup Code
		; Setup PORTD (the switches on the STK300) as inputs by setting the direction register
		; bits to $00.  Set the initial value to $FF
		;  
		ldi r16, $00		; I/O: 
		out DDRD, r16		; Port D Direction Register
		ldi r16, $FF		; Init value 
		out PORTD, r16		; Port D value
		;
		; The main part of our program
		;
Main:	ldi r24, $00		; i = 0
		ldi r25, $00		; j = 0
loop:	add r25, r24		; j = j + i
		subi r24, $FF		; i = i + 1
		in r26, PIND
		cp r24, r26
		brne loop
		out PORTB, r25		; print j


;		ldi r24,$00			; clear i
;loop:  com r24
;		out PORTA,r24
;		jmp loop

;		mov r25,r24			; j = i
;		com r25				; NOT(j)
;		out PORTB,r25		; output j on LEDs
;		subi r24,$FF        ; i = i + 1
;		jmp loop			; continue to loop
		

;loop:	add	r25,r24			; j = j + i
;		subi r24,$FF		; i = i + 1
;		cpi r24,$0A			; is i < 10?
;		brne loop			; no then continue to loop
;		mov r26,r25			; copy j to k
;		com r26				; NOT of r26
;		rjmp Main			; do this again

