package parser;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public class Parser {
	
	private String filename;
	private LuaClass lc;
	
	public Parser(String baseFolder, String filename, ArrayList<String> codeClasses) {
		super();
		this.filename = filename;
		
		// have we found the basefolder in the hierarchy?
		boolean found = false;
		String name = "";
		
		// split the full path
		String[] parts = filename.split("/");
		for (String string : parts) {
			// .... if so, let's start writing the "name" (full path, package)
			if(found){
				name += string+".";
			}
			// is it the base folder? ....
			if(string.equals(baseFolder)){
				found = true;
			}
			
		}
		
		// Create the luaclass abstraction
		this.lc = new LuaClass(name.substring(0, name.length() - 5), codeClasses);
	}


	static Pattern membersPattern = Pattern.compile("(.*)-- @member (.*)");
	static Pattern dependencyPattern = Pattern.compile("local(\\s*)(\\S+)(\\s*)=(\\s*)require\\(['\"](.*)['\"]\\)");
	static Pattern extendsPattern = Pattern.compile("local(\\s*)(\\S+)(\\s*)=(\\s*)extends\\((.*)\\)");
	static Pattern functionsPattern = Pattern.compile("function(\\s*)(\\S+):(\\w+)\\(((.*\\,?)*)\\)");
	
	
	public void read() {
        Path path = Paths.get(this.filename);
        try (Stream<String> lines = Files.lines(path)) {
            lines.forEach(s -> this.analyse(s));
        } catch (IOException ex) {
        }
    }
	
	public void analyse(String s){
		
		//-- @member name:Class
		Matcher membersMatcher = membersPattern.matcher(s);
		if (membersMatcher.find()) {
			//System.out.println("\t\t[mem]\t" + membersMatcher.group(2) );
			lc.mem.add(membersMatcher.group(2));
	    }
		
		//local Position = require('games.Progg.Position')
		Matcher dependencyMatcher = dependencyPattern.matcher(s);
		if (dependencyMatcher.find()) {
			//System.out.println("[dep]\t" + dependencyMatcher.group(5)+"\t(name of object: '"+dependencyMatcher.group(2)+"')" );
			lc.dep.add(dependencyMatcher.group(5));
	    }
		
		//local Character = extends(Object.class())
		Matcher extendsMatcher = extendsPattern.matcher(s);
		if (extendsMatcher.find()) {
			//System.out.println("[ext]\t" + extendsMatcher.group(5));
			lc.ext.add(extendsMatcher.group(5));
	    }
		
		//function Queue:push(action, queueType)
		Matcher functionsMatcher = functionsPattern.matcher(s);
		if (functionsMatcher.find()) {
			//TODO check if first part is the class
			//System.out.println("[fun]\t" + functionsMatcher.group(3)+"("+functionsMatcher.group(4)+")");
			lc.fun.add(functionsMatcher.group(3)+"("+functionsMatcher.group(4)+")");
	    }
	}
	
	
	public LuaClass getLuaClass(){
		return this.lc;
	}
	
}
