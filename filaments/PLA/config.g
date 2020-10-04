M350 E16 I1		;Back to 16 microstepping to set it. 
;NonLinear Extrusion 
M92 E433.5 ;Adjusted for optimal curve fitting
M592 D0 A-0.00051 B0.00061 ;Nonlinear Extrusion parameters
M221 S101		;Flow(Diameter Compensation)
;Restore Microstepping to its value
M98 P0:/Macros/MotorControl/SetExtruderMicrostepping.g
 
;Set Temperatures
M140 S60			; Set Bed Temperature
G10 P0 R140 S205		; Set Nozzle Active and Standby Temperature
