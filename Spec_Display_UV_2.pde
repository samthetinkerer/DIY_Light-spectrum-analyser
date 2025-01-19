import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
float[] reading = new float[12]; // Array to store values (adjust if needed)

float UVA = 0;
float UVB = 0;
float UVC = 0;
float violet = 0;
float blue = 0;
float teal = 0;
float green = 0;
float yellow = 0;
float Yellowgreen = 0;
float orange = 0;
float red = 0;
float farRed = 0;

//colors for display 
color c0 = #7600ed; //UVA
color c1 = #7600ed; //UVB
color c2 = #7600ed; //UVC
color c3 = #7600ed; //violet
color c4 = #0028ff; // blue
color c5 = #00d5ff; // teal
color c6 = #1fff00; // green
color c7 = #b3ff00; // yellow - 
color c8 = #ffcc00; // yellow
color c9 = #ff6600; // orange
color c10 = #ff0000; // red
color c11 = #9b111e; // far red



void setup() {
  size(1200, 400);
//  noStroke();
  background(255);
  // Open the correct serial port
  String portName = Serial.list()[1]; // Change the index to match your port
  myPort = new Serial(this, portName, 115200);
}

void draw() {
  if (myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n'); // Read until newline
    
    if (val != null) {  // Ensure val is not null
      String[] readingStr = split(val, ','); // Split by comma
      
      if (readingStr.length > 1) {
        //convert from string to float
        // Make sure the split data has the expected number of values
        reading[0] = float(readingStr[0]); // UVA
        reading[1] = float(readingStr[1]); // UBV
        reading[2] = float(readingStr[2]); // UVC
        reading[3] = float(readingStr[3]); // 415nm
        reading[4] = float(readingStr[4]); // 445nm
        reading[5] = float(readingStr[5]); // 480nm
        reading[6] = float(readingStr[6]); // 515nm
        reading[7] = float(readingStr[7]); // 555nm
        reading[8] = float(readingStr[8]); // 590nm
        reading[9] = float(readingStr[9]); // 630nm
        reading[10] = float(readingStr[10]); // 680nm
        reading[11] = float(readingStr[11]); // 800nm
      //Remaping for display 
        UVA   = map(reading[0],0.0,65536.0,0.0,-400.0);
        UVB  = map(reading[1],0.0,65536.0,0.0,-400.0);
        UVC   = map(reading[2],0.0,65536.0,0.0,-400.0);
        violet  = map(reading[3],0.0,65536.0,0.0,-400.0);
        blue  = map(reading[4],0.0,65536.0,0.0,-400.0);
        teal  = map(reading[5],0.0,65536.0,0.0,-400.0);
        green = map(reading[6], 0.0, 65536.0, 0.0, -400.0);
        yellow = map(reading[7], 0.0, 65536.0, 0.0, -400.0);
        Yellowgreen = map(reading[8], 0.0, 65536.0, 0.0, -400.0);
        orange = map(reading[9], 0.0, 65536.0, 0.0, -400.0);
        red = map(reading[10], 0.0, 65536.0, 0.0, -400.0);
        farRed = map(reading[11], 0.0, 65536.0, 0.0, -400.0);
        
      }
    }
  }
  // Draw rectangles with mapped values
  background(255);
  //UV
    fill(c0);
  rect(0, 400, 100, UVA); // violet
    fill(c1);
  rect(100, 400, 100, UVB); // violet
    fill(c2);
  rect(200, 400, 100, UVC); // violet
  //Visable
  fill(c3);
  rect(300, 400, 100, violet); // violet
  fill(c4);
  rect(400, 400, 100, blue); // blue
  fill(c5);
  rect(500, 400, 100, teal); // teal
  fill(c6);
  rect(600, 400, 100, green); // green
  fill(c7);
  rect(700, 400, 100, Yellowgreen); // Yellow green
  fill(c8);
  rect(800, 400, 100, yellow); // yellow
  fill(c9);
  rect(900, 400, 100, orange); // orange
  fill(c10);
  rect(1000, 400, 100, red); // red
  fill(c11);
  rect(1100, 400, 100, farRed); // far red

  println("UVA:" + reading[0] + ", UVB: " + reading[1] + ", UVC:" + reading[2] + "415nm:" + reading[3] + ", 445nm: " + reading[4] + ", 480nm:" + reading[5] + ", 515nm: " + reading[6] + ", 555nm:" + reading[7] + ", 590nm: " + reading[8]+ ", 630nm:" + reading[9] + ", 680nm: " + reading[10] + ", 800nm: " + reading[11]); // Print the values
}
