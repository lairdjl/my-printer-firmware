; Select inductive probe, OMRON TL-Q5MC2-Z

; P8:              unfiltered
; C"^zprobe.in":    set pin to zprobe
; T18000:   Move to probe points at 300mm/s
; F1200:    Probing Speed: 20mm/s
; H5:       Dive height: 5mm
; A5 S0.01: Perform up to 5 touches until change is below 0.01mm
; B1:       Turn off heaters while probing

M400
M558 P8 C"^zprobe.in" H10 F1200 T6000 A5 S0.01 B1; set Z probe type to modulated and the dive height + speeds
G31 P500 X0 Y25 Z0.5 ; inductive probe offset, not critical, only used for coarse homing
G4 P200
