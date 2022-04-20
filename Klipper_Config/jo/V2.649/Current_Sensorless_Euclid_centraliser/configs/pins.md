## Voron Design VORON2 250/300/350mm SKR 1.4 TMC2209 UART config

## *** THINGS TO CHANGE/CHECK: ***
## MCU paths							[mcu] section
## Thermistor types						[extruder] and [heater_bed] sections - See 'sensor types' list at end of file
## Z Endstop Switch location			[homing_override] section
## Z Endstop Switch  offset for Z0		[stepper_z] section
## Probe points							[quad_gantry_level] section
## Min & Max gantry corner postions		[quad_gantry_level] section
## PID tune								[extruder] and [heater_bed] sections
## Fine tune E steps					[extruder] section

##========================== Pin Definitions ========================
## X_STEP_PIN         2.2
## X_DIR_PIN          2.6
## X_ENABLE_PIN       2.1
## X_STOP_PIN         1.29
## E0_DET_PIN         1.26
## X_UART_PIN         1.10


## Y_STEP_PIN         0.19
## Y_DIR_PIN          0.20
## Y_ENABLE_PIN       2.8
## Y_STOP_PIN         1.28
## E1_DET_PIN         1.26
## Y_UART_RX          1.9


## Z_STEP_PIN         0.22
## Z_DIR_PIN          2.11
## Z_ENABLE_PIN       0.21
## Z_STOP_PIN         1.27
## PWR_DET_PIN        1.0
## Z_UART             1.8


## E0_STEP_PIN        2.13
## E0_DIR_PIN         0.11
## E0_ENABLE_PIN      2.12
## E0_UART            1.4


## E1_STEP_PIN        1.15
## E1_DIR_PIN         1.14
## E1_ENABLE_PIN      1.16
## E1_UART_RX         1.1


## HE1                2.4    
## HE0                2.7
## BED                2.5
## TH1 (H1 Temp)      0.23
## TH0 (H0 Temp)      0.24
## TB  (Bed Temp)     0.25
## FAN                2.3
## SERVO              2.0
## PROBE			  0.10
##===================================================================





## 	Thermistor Types
##   "EPCOS 100K B57560G104F"
##   "ATC Semitec 104GT-2"
##   "NTC 100K beta 3950"
##   "Honeywell 100K 135-104LAG-J01"
##   "NTC 100K MGB18-104F39050L32" (Keenovo Heater Pad)
##   "AD595"
##   "PT100 INA826"
