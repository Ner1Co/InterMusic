static class MuMusic{
  static int[] major = {0, 2, 4, 5, 7, 9, 11};
  static int[] minor = {0, 2, 3, 5, 7, 8, 10};
  static int[] harmonicMinor = {0, 2, 3, 5, 7, 8, 11};
  static int[] melodicMinor = {0, 2, 3, 5, 7, 8, 9, 10, 11};
  
  static int[] dorian = {0, 2, 3, 5, 7, 9, 10};
  static int[] lydian = {0, 2, 4, 6, 7, 9, 10};
  static int[] mixolydian =  {0, 2, 4, 5, 7, 9, 10};
  static int[] pentatonic = {0, 2, 4, 7, 9};
  static int[] blues = {0, 2, 3, 4, 5, 7, 9, 10, 11};
  static int[] locrian = {0, 1, 3, 5, 6, 8, 10};
  static int[] phrygian= {0, 1, 3, 5, 7, 8, 10};
  static int[] naturalMinor = {0, 2, 3, 5, 7, 8, 10};
  static int[] turkish = {0, 1, 3, 5, 7, 10, 11};
  static int[] indian = {0, 1, 1, 4, 5, 8, 10};
  
  
  
  static int[] currentScale = new int[127];
  
  static void initScale(int[] scale){
    for(int i=0; i < currentScale.length - scale.length; i+=scale.length){
      for(int j=0; j < scale.length; j++)
        currentScale[i+j] = scale[j] + (i/scale.length)*12;
    }
  }
  
  static void initMajor(){
    initScale(major);
  }
  
  static void initPentatonic(){
    initScale(pentatonic);
  }
  
  static void initMinor(){
    initScale(minor);
     println(currentScale.length);
  }
}
