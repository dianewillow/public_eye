//This tab initializes all the movie lists and rendering lists. 



//Initialize Movie list, rendering list, input frame and other lists
void InitializeData(){
  //List of movies that get accessed and played, the basis for display
  mov = new ArrayList<Movie>();
  //Movie Index; 
  //curRender and curXRender set the number of videos that are loaded at a time. The canvas size determines how many
  //loaded videos you can see on a given display.
  //The number within the brackets must be the same. 
  curRender = new int[6];
  //position index
  curXRender = new float[6];
  //The input frame of video that gets accessed for display
  inputImage = new ArrayList<PImage>();
  // Initialize new video attribute lists
  //list of running videos
  running = new ArrayList<String>();
  //list of ran videos
  ran = new ArrayList<String>();
  loops = new ArrayList<Integer>();
  indexInMov = new ArrayList<Integer>();
  
}
  
//Open videos currently in archive.
void OpenArchiveVideos()
{
  try{
  // Open archive videos from archiveMovieNames
  for(String archiveMovieName : archiveMovieNames) {
    Movie newMov = new Movie(this, "archive/" + archiveMovieName);
    PImage newInputImage = createImage(width, height, ARGB);
    inputImage.add(newInputImage);
    newMov.loop();
    mov.add(newMov);
  }
  for (int i=0; i < curRender.length; i++)
  {
    //get a random video
    curRender[i] = (int) random(mov.size() - 1);
    curXRender[i] = w * i;
  }
  
  // Initialize filename filter, which will only look for .avi files
  fileNameFilter = new FilenameFilter() {
    @Override
    public boolean accept(File dir, String name) {
       if(name.lastIndexOf('.')>0)
       {
          // get last index for '.' char
          int lastIndex = name.lastIndexOf('.');
          
          // get extension
          String str = name.substring(lastIndex);
          
          // match path name extension
          if(str.equals(movieExtensionFilter))
          {
             return true;
          }
       }
       return false;
    }
   };
  
}
  catch(Exception e)
  {
    println(e);
  }


}