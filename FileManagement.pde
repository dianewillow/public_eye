
//Delete specified file . 
void DeleteFile(String fileToDelete)
{
  
  try{
    search = false;
    String fileName = "/home/publiceye/Documents/MergeAttempt/" + fileToDelete;
    File file = new File(fileName);
    if(f.exists())
    {
      println("File is being deleted");
     file.delete();  
     newVidCount =0;
    }
  }
  catch(Exception e)
  {
    println("File does not exist");
  
  }
}


//Not used, but could be used for future reasons.
void CreateFile()
{
  try
  {
    PrintWriter output;
    output = createWriter("helloWorld.txt");
    output.println("File was created");
  }
  catch(Exception e)
  {
    println("NOT CREATED");
  } 
}