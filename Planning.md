# PyAlarm Planning

## Basic Display/Interface Functions
* Show time
  * time is set automatically from NTP based on timezone
* Alarm
  * buzzer or MP3
* Display dims in response to light
  * Display temporarily goes to full brightness when touchscreen is activated
* Physical nooze button
* Physical button to play a random MP3 from SD card 

## Enclosure
laser-cut birch box

## Notes
**Input/Output**
* Only 2 inputs natively avialable 
 * I2C connector can be used for multi-plexing multiple other input/output devices
 * See [Grove Multiplexer](https://www.kiwi-electronics.nl/nl/grove-8-channel-i2c-multiplexer-i2c-hub-tca9548a-10023?language=nl-nl&currency=EUR&gclid=Cj0KCQjwv5uKBhD6ARIsAGv9a-xhyaoCvmtyrrJM-ZgV2S13VDWcPluiJPzghdPwEd95_w9yCTiDhtMaAnB8EALw_wcB)

**Connectivity**
* PyPortal can be powered through JST connectors rather than micro USB
 * requires a steady, clean, regulated 5V 
 * see [Adafruit Boost](https://www.kiwi-electronics.nl/nl/lipo-rider-plus-charger-booster-5v-2-4a-usb-type-c-9960?search=boost)

