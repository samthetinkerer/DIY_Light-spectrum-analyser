/* This example will read all channels from the AS7341 and print out reported values */

//adafruit libary 
#include <Adafruit_AS7341.h> 

//Sparkfun libary
#include <Arduino.h>
#include <Wire.h>
#include <SparkFun_AS7331.h>

Adafruit_AS7341 as7341; //visable light sensor
SfeAS7331ArdI2C myUVSensor; //UV light sensor

void setup() {
  Serial.begin(115200);

  // Wait for communication with the host computer serial monitor
  while (!Serial) {
    delay(1);
  }

    Wire.begin(); //SF

  if (!as7341.begin()){
    Serial.println("Could not find AS7341");
    while (1) { delay(10); }
  }

  // Initialize UV sensor and run default setup.
  //SF
  if(myUVSensor.begin() == false) {
    Serial.println("Sensor failed to begin. Please check your wiring!");
    Serial.println("Halting...");
    while(1);
    //SF
  }
  Serial.println("UV Sensor began.");//SF

    // Set measurement mode and change device operating mode to measure.
  if(myUVSensor.prepareMeasurement(MEAS_MODE_CMD) == false) {
    Serial.println("Sensor did not get set properly.");
    Serial.println("Halting...");
    while(1);
  }

  Serial.println("Set mode to command.");

  as7341.setATIME(100);
  as7341.setASTEP(999);
  as7341.setGain(AS7341_GAIN_64X); //256X max gain or change to 128X, 64x, 8x 
}

void loop() {
  // Read all channels at the same time and store in as7341 object
  if (!as7341.readAllChannels()){
    Serial.println("Error reading all channels!");
    return;
  }
//SF loop
   // Send a start measurement command.
  if(kSTkErrOk != myUVSensor.setStartState(true))
    Serial.println("Error starting reading!");
  
  // Wait for a bit longer than the conversion time.
  delay(2.2+myUVSensor.getConversionTimeMillis());

  // Read UV values.
  if(kSTkErrOk != myUVSensor.readAllUV())
    Serial.println("Error reading UV.");

 // Serial.print("UVA:");
 Serial.print(myUVSensor.getUVA());
   Serial.print(",");
 // Serial.print(" UVB:");
  Serial.print(myUVSensor.getUVB());
    Serial.print(",");
 // Serial.print(" UVC:");
  Serial.print(myUVSensor.getUVC());
  Serial.print(",");
//delay(2000);
  

  // Print out the stored values for each channel
  //Serial.print("415nm,");
  Serial.print(as7341.getChannel(AS7341_CHANNEL_415nm_F1));
  Serial.print(",");
  Serial.print(as7341.getChannel(AS7341_CHANNEL_445nm_F2));
  Serial.print(",");
  Serial.print(as7341.getChannel(AS7341_CHANNEL_480nm_F3));
  Serial.print(",");
  Serial.print(as7341.getChannel(AS7341_CHANNEL_515nm_F4));
  Serial.print(",");
  Serial.print(as7341.getChannel(AS7341_CHANNEL_555nm_F5));
  Serial.print(",");
  Serial.print(as7341.getChannel(AS7341_CHANNEL_590nm_F6));
  Serial.print(",");
  Serial.print(as7341.getChannel(AS7341_CHANNEL_630nm_F7));
  Serial.print(",");
  Serial.print(as7341.getChannel(AS7341_CHANNEL_680nm_F8));

 // Serial.print("Clear    : ");
 // Serial.println(as7341.getChannel(AS7341_CHANNEL_CLEAR));

  Serial.print(",");
  Serial.println(as7341.getChannel(AS7341_CHANNEL_NIR));
  
  
}