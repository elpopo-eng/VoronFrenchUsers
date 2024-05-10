Quick guide for installing/updating Klipper on the Spider:

Compiling:
- connect to the RPi via SSH
- cd ~/klipper
- make menuconfig
  - select "Enable extra low-level configuration options"
  - select STM32 micro-controller architecture
  - select STM32F446 processor model
  - select 64KiB bootloader
  - select 12MHz crystal clock reference
  - only if connected via UART: select "Serial (on USART1 PA10/PA9)" communication interface
- make clean
- make

Installing:
If your Spider is connected via USB or UART (requires an SD card):
- copy compiled Klipper binary (/home/pi/klipper/out/klipper.bin) from the Pi onto a FAT-formatted SD card
- rename Klipper binary from klipper.bin to firmware.bin
- insert SD card into Spider
- power up the board and wait for a minute for the Flash LED (near SD card slot) to stop blinking
- a successful flash can be verified afterwards by checking the SD card for a file named OLD.BIN

Alternatively, if your Spider is connected via USB (SD card not required):
- put a jumper between the 3.3V and BT0 pin (located centrally on the board)
- power up the board
- determine USB ID using the lsusb command (ID example: 1234:5678)
- cd ~/klipper
- make flash FLASH_DEVICE=1234:5678 (substituting the USB ID)
- remove jumper from BT0 pin

Updating:
If an SD card is inserted into the Spider and the board is connected via USB or UART:
- compile Klipper (see above)
- sudo service klipper stop
- ./scripts/flash-sdcard.sh /dev/<serial-device> fysetc-spider-v1 (where /dev/<serial-device> is either something like /dev/serial/by-id/<spider-serial-port> when connected via USB, or like /dev/ttyAMA0 when connected via UART)
- sudo service klipper start

Alternatively, if your Spider is connected via USB (no SD card required):
- compile Klipper (see above)
- sudo service klipper stop
- make flash FLASH_DEVICE=/dev/serial/by-id/<spider-serial-port>
- sudo service klipper start
