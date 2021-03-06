; Configuration file for Duet WiFi (firmware version 2.03 or newer)
; executed by the firmware on start-up

; General preferences
M111 S0                 ; Debugging off
G21                     ; Work in millimetres
G90                     ; Send absolute coordinates...
M83                     ; ...but relative extruder moves
M555 P2                 ; Set firmware compatibility to look like Marlin
M575 P1 B57600 S1       ; Comms parameters for PanelDue
M564 S1 H1              ; Forbid axis movements when not homed

; General setup
M669 K1                 ; Select CoreXY mode (2.03 and up)

; Network
M550 P"Voron"           ; Set machine name
M552 S1                 ; Enable network
M586 P0 S1              ; Enable HTTP (for DWC)
M586 P1 S1              ; Enable FTP (for remote backups)
M586 P2 S0              ; Disable Telnet

; --- drive map ---
;    _______
;   | 6 | 7 |
;   | ----- |
;   | 5 | 8 |
;    -------
;     front

; Drive directions
M569 P0 S1 ; A
M569 P1 S1 ; B
M569 P3 S1 ; Extruder #1
;M569 P4 S0 ; Extruder #2
M569 P5 S1 ; Z1
M569 P6 S0 ; Z2
M569 P7 S1 ; Z3
M569 P8 S0 ; Z4

; Motor mapping and steps per mm
M584 X0 Y1 Z5:6:7:8 E3:4
M350 X16 Y16 Z16 I1      ; Use 1/16 microstepping with interpolation everywhere
M350 E16:16 I1;         ;   no microstepping on the extruder
M92 X80 Y80 Z400                ; Set XYZ steps per mm (1.8deg motors)
;M92 X160 Y160 Z800              ; Set XYZ steps per mm (0.9deg motors)
M92 E404:404                    ;417 was original - after tuning 405 was slightly over 100mm. Therefore, 404
;M350 Z16 I0 ; disable Z interpolation

; Drive currents
M906 X1200 Y1200 Z1200 E1000    ; XYZ and E current
M906 I30                        ; Idle current percentage
M84 S120                        ; Idle timeout

; Endstops
M574 X2 S1 P"xstop"   ; X max active low endstop switch
M574 Y2 S1 P"ystop"   ; Y max active low endstop switch
M574 Z0 P"nil"        ; zstop is free

M208 X0 Y0 Z0 S1               ; Set axis minima
M208 X250 Y255 Z230 S0          ; Set axis maxima

; Bed leveling
;M671 X-65:-65:265:265 Y-20:280:280:-20 S20      ; Define Z belts locations (Front_Left, Back_Left, Back_Right, Front_Right)
M671 X-65:-65:320:320 Y-20:350:350:-20 S20      ; Define Z belts locations (Front_Left, Back_Left, Back_Right, Front_Right)

M557 X50:200 Y50:200 S25                        ; Define bed mesh grid (inductive probe, positions include the Z offset!)

; Accelerations and speed
M98 P"/macros/print_scripts/speed_printing.g"

; Heated bed #0
;Create Heater Thermistor
;A: Name
;P: pin
;Y: type
 
M308 A"Heater Temp" P"bedtemp" Y"thermistor" S0 T100000 B3950
M950 H0 C"bedheat" Q10 T0                       ; create heater T0 10Hz SSR
M140 H0                                         ; set temp to 0C
M143 H0 S115                                    ; set the maximum bed temperature to 115C


; Hotend #1 heater
M308 S1 P"e0temp" Y"thermistor" T100000 B4092   ; define thermistor
M950 H1 C"e0heat" Q100 T1;                      ; define heater, connect to thermistor
M143 H1 295                                     ; Max hot end temp 295C
M950 F1 C"fan1" Q100                            ; fan for hot end
M106 P1 T45 H1                                  ; Set fan 1 to on when hot end goes > 45C

M950 F0 C"fan0" Q100                          
M106 P0 C"Part Cooling" 

;Side Fans
M950 F5 C"duex.fan5" Q100;
M950 F6 C"duex.fan6" Q100;
M106 C"Electronics Bay"P5 T45:65 F50 H100:101:102     ; Electronics bay fan, turn on gradually if MCU is over 45C or any TMC driver is over temp
M106 C"Electronics Bay"P6 T45:65 F50 H100:101:102     ; Electronics bay fan, turn on gradually if MCU is over 45C or any TMC driver is over temp


; Chamber temperature sensor via temperature daughterboard pins on Duex
;M305 S"Ambient" P104 X405 T21                   ; Set DHT21 for chamber temp
;M305 S"Humidity [%]" P105 X455 T21              ; Set DHT21 for chamber humidity

; Disable unused heaters (so they are hidden on the PanelDue)
M307 H2 A-1 C-1 D-1
M307 H3 A-1 C-1 D-1
M307 H4 A-1 C-1 D-1
M307 H5 A-1 C-1 D-1
M307 H6 A-1 C-1 D-1
M307 H7 A-1 C-1 D-1

; Select inductive Z probe on powerup
M98 P"/macros/print_scripts/activate_z_probe.g"

; Fans

;M106 P3 S1 I0 H1 T50              ; E3D V6 Hotend fan, turns on if temperature sensor 1 reaches 50 degrees
;M106 P3 S0.6 I0 H1 T50              ; Mosquito Hotend fan @ 60%, turns on if temperature sensor 1 reaches 50 degrees
;M106 P4 S0 I0 H-1                   ; Part cooling fan, no thermostatic control
;M106 P5 T45:65 F50 H100:101:102     ; Electronics bay fan, turn on gradually if MCU is over 45C or any TMC driver is over temp
;M106 P8 S1 H0 T50                   ; Chamber filter fan, turn on when bed is hotter than 50C

; Tools
M563 P0 D0 H1 F0                    ; Define tool 0
G10 P0 X0 Y0 Z0                     ; Set tool 0 axis offsets
G10 P0 R0 S0                        ; Set initial tool 0 active and standby temperatures to 0C

; Enable pressure advance
; 0.085 was damn near perfect. Slight blobbing. Upping to 0.087.
M572 D0 S0.087


M501                                ; load config-override.g
T0                                  ; select tool 0