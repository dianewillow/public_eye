void DrawMovie()
{
 // newMovieSearch();
try
{
  //For each video open, stored in the mov list
  for(int i = 0; i < curRender.length; i++) 
  {
    // Shift the video pxPerFrame left
    curXRender[i] -= pxPerFrame;
       
    // If the video has scrolled all the way left off the screen, reset its position to
    // the right of the rightmost video in the list (at mov.size() - 1 * w)
    if(curXRender[i] < (w * -1)) 
    {
      curXRender[i] = (float) (curRender.length - 1) * w;
      curRender[i] = (int) random(mov.size() -1);
      
      //This section checks to see if the number of laps equals the number of times the new video has been played
      
      /*
      This block of code gets and stops the video that has just left the screen. If this block is omitted
      the CPU will max out very quickly as the videos keep playing off screen and never stop.
      
              Movie oldMov;
              oldMov = mov.get(i);
              oldMov.noLoop();
      */
         if(vidCount == laps)
       {
              Movie oldMov;
              oldMov = mov.get(i);
              oldMov.noLoop();
              DeleteFile("newMov.mov");
              vid = new VideoExport(this,"newMov.mov",cam);
              flag = 0;
              newVidCount = 0;
              vidCount = 0;
            
       
       }
       
            //This block adds a newly recorded video.
            //First it stops the old video, then grabs 'newMov.mov' and sets it to the current playing video
          if(flag == 1 && newVidCount <1)
          {
              Movie oldMov;
              oldMov = mov.get(i);
              oldMov.noLoop();
              Movie newMov = new Movie(this, filePath+ "newMov.mov");
              newMov.loop();
              mov.set(i, newMov);
              newMov = mov.get(i); 
              newVidCount++;
              vidCount++;
          }
          //This block grabs a random video from the archive and displays it.
          else {
              Movie oldMov1;
              oldMov1 = mov.get(i);
              oldMov1.noLoop();
              //archiveMovieNames[int(random(6))]); switch back to this for String[]
              Movie newMov1 = new Movie(this, "archive/" + archiveMovieNames.get(int(random(archiveMovieNames.size())))) ;
              newMov1.loop();
              mov.set(i, newMov1);                           
              newMov1 = mov.get(i); 
              newVidCount++;
              if(newVidCount > 6)
              {
              newVidCount=0;
              }
            }
                  
    }
    
    //Get the video and render them. this section correcly blends the masks on top of the videos and scrolls the videos 
    //across the screen.
    if ((mov.get(i) != null) && (mov.get(i).available())) {
      mov.get(i).read();
      //input the movie on screen
      inputImage.get(i).copy(mov.get(i), 0, 0, mov.get(i).width, mov.get(i).height, 0, 0, w, h);
      //input the mask on screen
      inputImage.get(i).blend(mask, 0, 0, w+2, h, 0, 0, w+2, h, ADD);
    }
    image(inputImage.get(i),curXRender[i], 0);
    image(mask,curXRender[i], 0);
  }//end of for loop  
}//end of try
catch(Exception e)
{
    println(e + "Happened in DrawMovie");

}   //<>//
}

//counter for each time a newly recorded video goes across the screen.
int vidCount = 0;

int newVidCount=0;
//Change the laps value to the amount of times you want new videos to scroll around.
int laps = 2;
//flag that gets set when a new video is available
boolean newVideoFlag;
//flag that gets set to allow recording
boolean record = false;
//flag that gets set to allow new video searching.
boolean search = false;


//file path for getting files from the project directory //<>//
String filePath = "/home/publiceye/Documents/MergeAttempt/";
int flag = 0;

//Search for new movies within the project directory
void newMovieSearch()
{
  
  File folder = new File(filePath);
  File[] listOfFiles = folder.listFiles();
  
  if ((listOfFiles != null) && (newVideoFlag = true))
  {
    for (int i = 1; i < listOfFiles.length; i++)
    {
      //println(listOfFiles[i].getName());
      String fileName = listOfFiles[i].getName();
      if (fileName.equals("newMov.mov") )
      {
       
        flag =1;
        newVideoFlag = false;
        search = false;
        
        
      }
    }
  }

}