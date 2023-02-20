from time import sleep_ms
import ubluetooth
import time
from machine import Pin, I2C, ADC, Timer
from micropython import const
from BLE import ESP32_BLE

#Intiaiate BLE conneciton
        
ble = ESP32_BLE("ESP32BLE")


# Set themistor analog pins

temp = ADC(Pin(14))
temp.atten(ADC.ATTN_11DB)

timeCount = 0

data = {
        "Time": "",
        "Identifier": -1,
        "Data": [],
    }
    
#Log data to a csv, named based on current_time
current_time = f"{time.localtime()[1]}-{time.localtime()[2]}-{time.localtime()[3]}-{time.localtime()[4]}"
logf = open(f"data{current_time}.csv","a")

#Reads and sends data to central device

while True:
    data_value = temp.read()
    print(data_value)
    
    # Converts arbitary data point to temperature value using calibration curve equation
    temp_value = 36.676(data_value) + 1075
    
    
    data["Time"] = timeCount
    data["Identifier"] = 0
    data["Data"] = [temp_value]
    
    
    if is_ble_connected:
        ble.send(str(temp_value))
        
        
    try:
        logf.write(str(temp.read()), str(temp_value))
        logf.write("\r\n")
    except OSError:
        print("Disk full?")   
        
    sleep_ms(1000)
    timeCount = timeCount + 1
    logf.close()
