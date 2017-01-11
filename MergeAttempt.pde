import gab.opencv.*;
import processing.video.*;
import java.util.*;
import java.util.Arrays;
import java.io.*;
import java.awt.*;


File folder = new File("/home/publiceye/Documents/MergeAttempt/data/");
// Archived video files should be placed in the data/archive/ directory

// Alternate mask images should be placed in the data/masks/ directory
String maskFilename = "ovalmaskbig.png";

// Controls the number of pixels the rendering scrolls per frame
float pxPerFrame = 0.75;

// Must be updated with location of eyeDemo program
String eyeDemoPath = "/home/publiceye/Documents/MergeAttempt";

// Movie extension filter
String movieExtensionFilter = ".avi";

// Global lists for handling video attributes
ArrayList<Movie> mov;
ArrayList<PImage> inputImage;

// Image for mask
PImage mask;

// Width and height of the input videos
int w = 128;
int h = 96;

// New video attribute lists
ArrayList<String> running;
ArrayList<String> ran;
ArrayList<Integer> loops;
ArrayList<Integer> indexInMov;

//look in Initialize tab for more information. Critical arrays for rendering and scrolling.
int[] curRender; 
float[] curXRender;


int frameCounter = 0;
FilenameFilter fileNameFilter;

void setup() {
  
  ArduinoSetup();
  cameraSetup();
   InitializeData();
  
  // Initialize canvas size: change the width for appropriate display size
  size(480, 96); 
  // Load mask into PImage
  mask = loadImage("masks/" + maskFilename);
  mask.resize(w+2,h);
  OpenArchiveVideos();
}

int i = 0;
void draw() 
{
  
  try
  {
    if(search) //<>//
    {
      newMovieSearch(); //<>//
    
    }
    if(record)
      {
      cameraRead(); //<>//
      }
//Always draw the movies
    DrawMovie();
  }
  catch(Exception e)
  {
    println(e); //<>//
    println("Actually happened in draw");
  }
  
}