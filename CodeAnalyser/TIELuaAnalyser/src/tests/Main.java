package tests;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import net.sourceforge.plantuml.SourceStringReader;
import parser.*;

public class Main {
	static ArrayList<String> classes = new ArrayList<String>();
	static ArrayList<LuaClass> lcList = new ArrayList<LuaClass>();
	static String baseDir = "src";
	
	public static void drawUML(String s){
		OutputStream png = null;
		try {
			png = new FileOutputStream("uml.png");
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		String source = "@startuml\n";
		source += s;
		source += "@enduml\n";

		SourceStringReader reader = new SourceStringReader(source);
		// Write the first image to "png"
		try {
			String desc = reader.generateImage(png);
			System.out.println(desc);
		} catch (IOException e) {
			e.printStackTrace();
		}
		// Return a null string if no generation
	}
	
	
	
	/**
	 * After executing this function, we know all the classes in the project
	 * They are stored in the classes ArrayList
	 * @param path
	 */
	public static void discoverClasses( String path ) {

        File root = new File( path );
        File[] list = root.listFiles();

        if (list == null) return;

        for ( File f : list ) {
            if ( f.isDirectory() ) {
                discoverClasses( f.getAbsolutePath() );
            }
            else {
                String extension = "";

                int i = f.getAbsolutePath().lastIndexOf(".");
                if (i > 0) {
                    extension = f.getAbsolutePath().substring(i+1);
                }
                if (extension.equals("lua")){
                	//System.out.println(f.getAbsolutePath());
                	
            		// have we found the basefolder in the hierarchy?
            		boolean found = false;
            		String name = "";
            		
            		// split the full path
            		String[] parts = f.getAbsolutePath().split("/");
            		for (String string : parts) {
            			// .... if so, let's start writing the "name" (full path, package)
            			if(found)
            				name += string+".";
            			
            			// is it the base folder? ....
            			if(string.equals(baseDir))
            				found = true;
            		}
            		
            		// Create the luaclass abstraction
            		//System.out.println(name.substring(0, name.length() - 5));
            		classes.add(name.substring(0, name.length() - 5));
                }
            }
        }
    }
	
	   public static void analyseLuaCode( String path ) {

	        File root = new File( path );
	        File[] list = root.listFiles();

	        if (list == null) return;

	        for ( File f : list ) {
	            if ( f.isDirectory() ) {
	            	analyseLuaCode( f.getAbsolutePath() );
	            }
	            else {
	                String extension = "";

	                int i = f.getAbsolutePath().lastIndexOf(".");
	                if (i > 0) {
	                    extension = f.getAbsolutePath().substring(i+1);
	                }
	                if (extension.equals("lua")){
	                	//System.out.println(f.getAbsolutePath());
	                	
		                Parser p = new Parser(baseDir,f.getAbsolutePath(), classes);
		        		p.read();
		        		lcList.add(p.getLuaClass());
	                }
	            }
	        }
	    }
	   
	   public static <T> String toString(ArrayList<T> l){
		   String r="";
		   for(T i: l)
				r += i.toString();
		   return r;
	   }


	    public static void main(String[] args) {
	    	
	    	// Directory in which we'll explore the code
	    	String dir = "/Users/Laurent/Documents/Eclipse/tddc88_tech_it_easy/Project/src/";
	    	
	    	for(String a: args){
	    		if(a.contains("--path=")){
	    			dir = a.substring(7);
	    			System.out.println("path is '"+a.substring(7)+"'");
	    		}
	    		if(a.contains("--src=")){
	    			baseDir = a.substring(6);
	    			System.out.println("src is '"+a.substring(6)+"'");
	    		}
	    	}
	    	discoverClasses(dir);
	
	    	// Go through the code and create LUA classes
	    	analyseLuaCode(dir);

			String uml = toString(lcList);
			
			// Output the string to text file
			PrintWriter writer;
			try {
				writer = new PrintWriter("tie-uml.txt", "UTF-8");
				DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				Date date = new Date();
				writer.println("'Generated on: "+dateFormat.format(date));
				writer.println(uml);
				writer.close();
				System.out.println("Generated tie-uml.txt; Paste the text in:");
				System.out.println("\t>>> http://www.planttext.com/planttext");
			} catch (FileNotFoundException | UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			
			//System.out.println(uml);
			
			// Call plantUML to generate diagram
			// doesn't work without Graphivz
			//drawUML(uml);
	    }

}
