package parser;

import java.util.ArrayList;

public class LuaClass {
	private String path;
	
	//extends
	public ArrayList<String> ext;
	//dependency
	public ArrayList<String> dep;
	//composition
	public ArrayList<String> mem;
	//functions
	public ArrayList<String> fun;	
	
	private static ArrayList<String> classes;

	public LuaClass(String path, ArrayList<String> codeClasses) {
		super();
		this.classes = codeClasses;

		this.path = path;
		this.ext = new ArrayList<String>();
		this.dep = new ArrayList<String>();
		this.mem = new ArrayList<String>();
		this.fun = new ArrayList<String>();
	}

/*
	@Override
	public String toString() {
		return "LuaClass [path=" + path + ", ext=" + ext + ", dep=" + dep
				+ ", mem=" + mem + "]";
	}
	*/
	
	public String getPath(){
		return this.path;
	}
	
	@Override
	public String toString() {
		String s = "";
		
		// - - - - - - - - - - - - - -
		// display class info (option 1 with members inside)
		// and also functions
		
		s += "class "+path+"{\n";
		for (String m: mem){
			s+=m+"\n";
		}
		// functions
		for (String f: fun){
			s+=f+"\n";
		}
		s += "}\n";
		// - - - - - - - - - - - - - -

		// - - - - - - - - - - - - - -
		// Parents
		// check with dependencies to get full path
		
		for (String p: ext){
			for(String d: dep){
				if (d.contains(p)){
					p = d;
				}
			}
			s += p + " <|-- "+ path+"\n";
		}
		// - - - - - - - - - - - - - -

		// - - - - - - - - - - - - - -
		// Composition
		
		for (String m: mem){
			try {
				// Look through members, split with :
				String parts[] = m.split(":");
				// Part 1 is classname
				m = parts[1];
				
				// Is this in the dependencies?
				boolean isInDep = false;
				
				// Let's check
				for(String d: dep){
					// if it is
					if (d.contains(m)){
						isInDep = true;
						// add a link with full name (found w/ dependencies)
						s += d + " *-- \""+parts[0]+"\" "+ path+"\n";
					}
				}
				// if there's no dep or it's not in the dep,
				// check in the classes we know
				if(dep.size()<1 || !isInDep){
					
					// for every class we know
					for(String knownClass: LuaClass.classes){
						
						// if it looks like it
						if (knownClass.contains(m)){
							
							// split with .
							String knownClass_parts[] = knownClass.split("\\.");
							
							// we have split for real
							if (knownClass_parts != null && knownClass_parts.length > 0){
								
								// add to the list (with full path)
								//DEBUG- System.out.println(knownClass_parts[knownClass_parts.length-1]+" contains "+m);
								if (knownClass_parts[knownClass_parts.length-1].equals(m))
									s += knownClass + " *-- \""+parts[0]+"\" "+ path+"\n";
							}
						}
					}
				}
			} catch (ArrayIndexOutOfBoundsException e){System.out.println("Ignored comment in "+this.path+":\t"+m);}
			
		} // end of for loop composition
		
		
		// Dependencies - quite heavy on UML diagram
		for (String d: dep){
			//s += d + " <|.. "+ path+"\n";
		}
		
		return s;
	}
	
	public String toString(boolean showDep) {
		String s = "";
		
		// - - - - - - - - - - - - - -
		// display class info (option 1 with members inside)
		// and also functions
		
		s += "class "+path+"{\n";
		for (String m: mem){
			s+=m+"\n";
		}
		for (String f: fun){
			s+=f+"\n";
		}
		s += "}\n";
		// - - - - - - - - - - - - - -

		// - - - - - - - - - - - - - -
		// Parents
		// check with dependencies to get full path
		
		for (String p: ext){
			for(String d: dep){
				if (d.contains(p)){
					p = d;
				}
			}
			s += p + " <|-- "+ path+"\n";
		}
		// - - - - - - - - - - - - - -

		// - - - - - - - - - - - - - -
		// Composition
		
		for (String m: mem){
			// Look through members, split with :
			String parts[] = m.split(":");
			// Part 1 is classname
			m = parts[1];
			
			// Is this in the dependencies?
			boolean isInDep = false;
			
			// Let's check
			for(String d: dep){
				// if it is
				if (d.contains(m)){
					isInDep = true;
					// add a link with full name (found w/ dependencies)
					s += d + " *-- \""+parts[0]+"\" "+ path+"\n";
				}
			}
			// if there's no dep or it's not in the dep,
			// then the developers have written the full path themselves
			if(dep.size()<1 || !isInDep)
				s += m + " *-- \""+parts[0]+"\" "+ path+"\n";
			
		}
		
		// Dependencies - quite heavy on UML diagram
		if (showDep){
			for (String d: dep){
				s += d + " <|.. "+ path+"\n";
			}
		}
		
		return s;
	}
	
	
	
	
	
}
