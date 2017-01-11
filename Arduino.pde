//Sensor Serial Communication with Arduino
//Arduino turns on LEDs and buzzer when sensor values are below threshold value
//WORK BY JEFF HIRSCH - 5113412

import processing.serial.*; //import the Serial library
Serial myPort;              //the Serial port object
String val;
// since we're doing serial handshaking, 
// we need to check if we've heard from the arduino
boolean firstContact = false;
int sensorvalue = 0;         //tried to reset variable but didn't work this way, kept the variable anyways
int count = 0;
//Setup the arduino
void ArduinoSetup()
{

    //initialize your serial port and set the baud rate to 9600-->match with arduino code
    myPort = new Serial(this, Serial.list()[0], 9600);
    myPort.bufferUntil('\n'); 

}

//THIS RUNS IN PARALLEL WITH EVERYTHING TO CONSTANTLY READ SERIAL LINE

void serialEvent( Serial myPort)       //to receive sensor data it must loop back to this point
  {    
    //put the incoming data into a String - 
    //the '\n' is our end delimiter indicating the end of a complete packet
    val = myPort.readStringUntil('\n'); 
    //make sure our data isn't empty before continuing
    if (val != null) 
      {
        //trim whitespace and formatting characters (like carriage return)
        val = trim(val);
        //println(val);
        //look for our 'A' string to start the handshake
        //if it's there, clear the buffer, and send a request for data
        if (firstContact == false)       //establishes contact here
          {
            if (val.equals("A")) 
              {
                myPort.clear();
                firstContact = true;
                myPort.write("A");
                println("ContactWithArduino");
              }
         }
         
         
        //MAIN CODE 
        else 
        { //if we've already established contact, keep getting and parsing data
        
         //println(val);
              //There is no one in front of the sensor
              if(val.equals("Nothing Detected"))
             {
                        
             }
             //If someone walks away during a record, then delete the partially recorded movie.
           if(val.equals("Delete Clip"))
             {
               
               DeleteFile("newMov.mov");
               vid.dispose();
               cam.stop();
               vid = new VideoExport(this, "newMov.mov",cam);
             
             }
             //Someone has been detected, so we need to start the recording process.
             if(val.equals("Running LED Sequence"))
             {
               
               cam.start();
               record = true;
               println("Recording start");
               //This delay determines the length of the video.
               delay(15000);
               newVideoFlag = true;
               println("Recording finished");
               record = false;
               delay(100);
               //Must call this to properly export a video and record multiple ones.
               //The new video is Re-instantiated in the DrawMovie tab
               vid.dispose();
               
             }
             if(val.equals("Keep Clip"))
             {
                 println("Clip Kept");
                 //When search is true, the system will search for 'newMov.mov' in the project folder.
                 search = true;
                 cam.stop();
             }
              
        }
                
        
          // when you've parsed the data you have, ask for more:
          myPort.write("A");
        }
  }