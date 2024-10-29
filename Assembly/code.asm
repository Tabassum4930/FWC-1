
.include "/data/data/com.termux/files/home/m328Pdef.inc"
; Define constants
.equ D3_PIN = 3        ; D3 on PD3 (Pin 3)
.equ D2_PIN = 2        ; D2 on PD2 (Pin 2)
.equ D1_PIN = 1        ; D1 on PD1 (Pin 1)
.equ D0_PIN = 0        ; D0 on PD0 (Pin 0)
.equ LED_PIN = 7       ; LED on PD7 (Pin 7)

; Initialize ports and I/O
.cseg
.org 0x0000
    rjmp RESET         ; Reset Vector

RESET:
    ; Set LED_PIN (PD7) as output
    sbi DDRD, LED_PIN

    ; Set D3_PIN (PD3), D2_PIN (PD2), D1_PIN (PD1), and D0_PIN (PD0) as inputs
    ; Enable internal pull-up resistors for these pins
    sbi PORTD, D3_PIN
    sbi PORTD, D2_PIN
    sbi PORTD, D1_PIN
    sbi PORTD, D0_PIN

MAIN_LOOP:
    ; Check D3_PIN (PD3)
    sbis PIND, D3_PIN   ; If D3_PIN is HIGH (D3 = 1), skip logic
    rjmp D3_LOW         ; If D3_PIN is LOW (D3' = 1), continue logic

    rjmp LED_OFF        ; If D3 = 1, B = 0, turn off LED

D3_LOW:
    ; D3' is true, continue checking D2, D1, and D0

    ; Check D2_PIN (PD2)
    sbis PIND, D2_PIN   ; Check if D2_PIN is HIGH (D2 = 1)
    rjmp D3D2_HIGH      ; If D2 = 1, D3' D2 is true, skip further checks and set LED

    ; D3' D2 is false, check D1' D0 logic
    ; Read D1_PIN (PD1)
    sbis PIND, D1_PIN   ; Check if D1_PIN is HIGH (D1 = 1)
    rjmp D1_LOW         ; If D1_PIN is LOW (D1' = 1), continue

    rjmp LED_OFF        ; If D1 = 1, D3' D1' D0 is false, turn off the LED

D1_LOW:
    ; Read D0_PIN (PD0)
    sbis PIND, D0_PIN   ; Check if D0_PIN is HIGH (D0 = 1)
    rjmp LED_ON         ; If D0 = 1, D3' D1' D0 is true, turn on LED

    rjmp LED_OFF        ; If D0 = 0, turn off the LED

D3D2_HIGH:
    ; D3' D2 is true, turn on LED
    rjmp LED_ON

LED_ON:
    sbi PORTD, LED_PIN  ; Set PD7 (turn on LED)
    rjmp MAIN_LOOP

LED_OFF:
    cbi PORTD, LED_PIN  ; Clear PD7 (turn off LED)
    rjmp MAIN_LOOP
