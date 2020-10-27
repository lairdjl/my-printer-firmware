; Select mechanical plunger switch

; P4 C2:    connected to Z endstop SIG and GND
; T18000:   Move to probe points at 300mm/s
; F120:     Probing Speed: 2mm/s
; H5:       Dive height: 5mm
; A5 S0.01: Perform up to 5 touches until change is below 0.01mm
; B1:       Turn off heaters while probing

M400

; TriangleLabs Spring Steel Flexplate

; Energetic Spring Steel Flexplate
M558 P8 C"zstop" T18000 F120 H5 A5 S0.01 B1 ;
G31 T4 P500 X0 Y0 Z-.035 ; Set parameters for z switch (if positive, greater value = lower nozzle. if negative, more negative = higher nozzle)

G4 P200