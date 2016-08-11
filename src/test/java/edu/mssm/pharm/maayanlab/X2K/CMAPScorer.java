package edu.mssm.pharm.maayanlab.X2K;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;

import edu.mssm.pharm.maayanlab.common.core.FileUtils;
import edu.mssm.pharm.maayanlab.common.geneticalgorithm.Scorer;
import edu.mssm.pharm.maayanlab.common.math.SetOps;

public class CMAPScorer implements Scorer {
	
	private HashMap<String, HashSet<String>> drugTargets = new HashMap<String, HashSet<String>>();
	
	public CMAPScorer() {
		ArrayList<String> drugTargetsFile = FileUtils.readResource("cmap2targets.csv");
		
		for (String line : drugTargetsFile) {
			String[] splitLine = line.trim().split(",");
			HashSet<String> targets = new HashSet<String>();
			for (int i = 1; i < splitLine.length; i++)
				targets.add(splitLine[i].toUpperCase());
			drugTargets.put(splitLine[0], targets);
		}
	}
	
	@Override
	public double score(String identifier, Collection<String> outputList) {
		// Add 1 to both numerator and denominator so that score isn't 0
		return ((double) SetOps.intersection(drugTargets.get(identifier), outputList).size()+1) / (outputList.size()+1);
	}
	
}
