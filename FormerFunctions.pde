//void DisplayFrames()
//{
//  PImage img;
//  try{
//    if( i < frameListNames.size()-1 )
//      {
//        delay(31);
//        img = loadImage("frames/" + frameListNames.get(i));
//        image(img,0,0);
         
//        i++;
//      }
//      else{
//      i=0;
//      }
//    }
//  catch(Exception e){
//   println("HEY THIS HAPPENED");
//  }
  
//}

ArrayList<String> frameListNames = new ArrayList<String>();
File f = new File("/home/publiceye/Documents/MergeAttempt/data/frames");
// ArrayList<File> files = new ArrayList<File>(Arrays.asList(f.listFiles()));
// this displayed NullPounterExepction on 1/6/2017
File[] listOfFiles = folder.listFiles();   
//Populate a list with filenames
void GetFileName()
{
  try{

               
          if(listOfFiles != null)
          {
            for (int i = 0; i < listOfFiles.length; i++) 
            {   
              if (listOfFiles[i].isFile()) 
                {
                  //index = i;
                  frameListNames.add(listOfFiles[i].getName());
                  //println(listOfFiles.length);
                 println(listOfFiles[i].getName());
                 
                }    
            }
            //return "hi";
          }
          else
          {  
          //  return "";
          }
        println("Files in List");
        }
      catch(Exception e)
      {
          println(" in get file name" + e);
      }
         
}