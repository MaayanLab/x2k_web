package edu.mssm.pharm.maayanlab.X2K;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;

import edu.mssm.pharm.maayanlab.common.core.FileUtils;
import edu.mssm.pharm.maayanlab.common.geneticalgorithm.Scorer;
import edu.mssm.pharm.maayanlab.common.math.SetOps;

public class GeneralScorer implements Scorer {
	
	private HashMap<String, HashSet<String>> targets = new HashMap<String, HashSet<String>>();

	public GeneralScorer() {
		ArrayList<String> targetsFile = FileUtils.readResource("targets.csv");
		
		for (String line : targetsFile) {
			String[] splitLine = line.split(",");
			HashSet<String> targetSet = new HashSet<String>();
			for (int i = 1; i < splitLine.length; i++)
				targetSet.add(splitLine[i].toUpperCase());
			targets.put(splitLine[0], targetSet);
		}
	}
	
	@Override
	public double score(String identifier, Collection<String> outputList) {
		// Add small number to both numerator and denominator so that score isn't 0
		return ((double) SetOps.intersection(targets.get(identifier), outputList).size()+0.01) / (outputList.size()+0.01);
	}
	
}
