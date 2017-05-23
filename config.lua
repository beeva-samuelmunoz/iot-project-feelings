--[[
AUTHOR: Samuel M.H. <samuel.munoz@beeva.com>
DESCRIPTION: Lua script for NodeMCU.
 - Connect the ESP8266 chip to an access point.
 - Create a MQTT client.
 - Subscribe to /DIAL topic to operate the dial.
]]

-- Thing
THING_ID = node.chipid()

-- Actuators
SERVO_PIN = 1
LED_PIN = 2


-- WiFi
AP = "IOT-GW-01" --Name of the access point to connect
PASSWORD =  "IOT-PASS-01" --Password for the access point

-- MQTT
MQTT_BROKER_IP = ""  -- Will be taken from the gateway IP
MQTT_BROKER_PORT = 1883
MQTT_TOPIC = THING_ID
MQTT_CLIENT = THING_ID
