class HelloWorld {
  public native void displayHelloWorld();
  
  static {
    System.loadLibrary("hello");
  }
  
  pubblic static void main(String[] args) {
    new HelloWorld().displayHelloWorld(); 
  }
}s
