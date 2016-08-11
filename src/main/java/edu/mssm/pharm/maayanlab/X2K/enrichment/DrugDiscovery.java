package edu.mssm.pharm.maayanlab.X2K.enrichment;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Map.Entry;

import edu.mssm.pharm.maayanlab.common.core.FileUtils;
import edu.mssm.pharm.maayanlab.common.core.Settings;
import edu.mssm.pharm.maayanlab.common.core.SettingsChanger;
import edu.mssm.pharm.maayanlab.common.core.SimpleXMLWriter;

public class DrugDiscovery implements SettingsChanger {
	
	private HashSet<String> genes = new HashSet<String>();
	private HashMap<String, ArrayList<String>> drugCoverage;
	private HashMap<String, ArrayList<String>> drugConflicts;
	private HashMap<String, Integer> drugCounts = new HashMap<String, Integer>();
	private LinkedList<String> topNDrugs = new LinkedList<String>();
	private boolean upRegulated, reverseEffect;
	
	// Default settings
	private final Settings settings = new Settings() {
		{
			// Boolean: the input genes are up-regulated. [true/false]
			set(DrugDiscovery.GENES_ARE_UPREGULATED, true);
			// Boolean: the drugs reverse the gene's effects; otherwise, it aggravates/exaggerates the effect. [true/false]
			set(DrugDiscovery.GENES_ARE_UPREGULATED, true);
			// Integer: the number of top drugs to return. May still be less if there aren't enough results. [>0]
			set(DrugDiscovery.NUMBER_OF_TOP_DRUGS, 10);
		}
	};
	
	// Settings variables
	public final static String GENES_ARE_UPREGULATED = "genes are upregulated";
	public final static String DRUGS_REVERSE_EFFECT = "find drugs that reverse effect";
	public final static String NUMBER_OF_TOP_DRUGS = "number of top drugs to display";
	
	@Override
	public void setSetting(String key, String value) {
		settings.set(key, value);		
	}
	
	public void run(ArrayList<String> inputGenes) {
		this.upRegulated = settings.getBoolean(GENES_ARE_UPREGULATED);
		this.reverseEffect = settings.getBoolean(DRUGS_REVERSE_EFFECT);
		
		for (String gene : inputGenes) {
			genes.add(gene.toUpperCase());
		}
		
		if (upRegulated ^ reverseEffect) {
			drugCoverage = readCMAPData(FileUtils.readResource("res/top500.txt"));
			drugConflicts = readCMAPData(FileUtils.readResource("res/bottom500.txt"));
		}
		else {
			drugConflicts = readCMAPData(FileUtils.readResource("res/top500.txt"));
			drugCoverage = readCMAPData(FileUtils.readResource("res/bottom500.txt"));
		}
		
		for (String drug : drugCoverage.keySet()) {
			drugCounts.put(drug, new Integer(drugCoverage.get(drug).size() - drugConflicts.get(drug).size()));
		}
		
		LinkedList<Map.Entry<String, Integer>> topDrugs = new LinkedList<Map.Entry<String, Integer>>(drugCounts.entrySet());
		Collections.sort(topDrugs, new Comparator<Map.Entry<String, Integer>>() {
			@Override
			public int compare(Entry<String, Integer> o1,
					Entry<String, Integer> o2) {
				int size1 = o1.getValue().intValue();
				int size2 = o2.getValue().intValue();
				
				if (size1 < size2)
					return 1;
				else if (size1 == size2)
					return 0;
				else
					return -1;
			}
		});
		
		int i = 1;
		for (Map.Entry<String, Integer> entry : topDrugs) {
			if (i > settings.getInt(NUMBER_OF_TOP_DRUGS))
				break;
			else {
				String drug = entry.getKey();
				topNDrugs.add(drug);
				i++;
			}
		}
	}
	
	private HashMap<String, ArrayList<String>> readCMAPData(ArrayList<String> dataFile) {
		HashMap<String, ArrayList<String>> effectOverlap = new HashMap<String, ArrayList<String>>();
		
		for (String drug : dataFile) {
			String[] effects = drug.split("\t", 2);
			String key = effects[0];
			effects = effects[1].toUpperCase().split("\\s");
			
			ArrayList<String> affectedGenes = new ArrayList<String>();
			
			for (String gene : effects)
				if (genes.contains(gene))
					affectedGenes.add(gene);
			
			effectOverlap.put(key, affectedGenes);
		}
		
		return effectOverlap;
	}
	
	public void writeFile(String outputFile) {
		SimpleXMLWriter sxw = new SimpleXMLWriter(outputFile);
		sxw.startElement("Drugs", "");
		for (String drug : topNDrugs) {
			if (drugCoverage.get(drug).size() > 0) {
				sxw.startElement("Drug", "", "name", drug, "coverage", Integer.toString(drugCoverage.get(drug).size()), "conflicts", Integer.toString(drugConflicts.get(drug).size()));
					sxw.startElement("Coverage", "");
					for (String effect : drugCoverage.get(drug))
						sxw.listElement("Effect", effect, "direction", (upRegulated ^ reverseEffect) ? "+" : "-");
					sxw.endElement();
					sxw.startElement("Conflicts", "");
					for (String effect : drugConflicts.get(drug))
						sxw.listElement("Effect", effect, "direction", (upRegulated ^ reverseEffect) ? "-" : "+");
					sxw.endElement();
				sxw.endElement();
			}
		}
		sxw.close();
	}
	
	public Collection<String>  getTopRankedList() {		
		return topNDrugs;
	}
	
}
