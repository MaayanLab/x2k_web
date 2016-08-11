package edu.mssm.pharm.maayanlab.X2K;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import edu.mssm.pharm.maayanlab.X2K.enrichment.GeneticAlgorithm;
import edu.mssm.pharm.maayanlab.common.core.FileUtils;

public class CMAPGA {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		run();
	}
	
	private static void run() {
		CMAPScorer scorer = new CMAPScorer();
		
		for (String drug : FileUtils.readResource("cmap.txt")) {
			ArrayList<String> geneList = FileUtils.readResource("top500" + File.separator + drug + ".txt");
			geneList.addAll(FileUtils.readResource("bottom500" + File.separator + drug + ".txt"));
			
			try {
				PrintWriter bestScoreWriter = new PrintWriter(new FileWriter(new File(drug + "_best_scores.txt")), true);
				PrintWriter averageScoreWriter = new PrintWriter(new FileWriter(new File(drug + "_average_scores.txt")), true);
						
				GeneticAlgorithm ga = new GeneticAlgorithm(scorer, drug, geneList, bestScoreWriter, averageScoreWriter);
				int[] scoreCounts = ga.run();
				for (int i = 0; i < scoreCounts.length; i++) {
					System.out.println("Total: " + ga.POPULATION_SIZE);
					System.out.println(i + "\t" + scoreCounts[i]);
				}

				bestScoreWriter.close();
				averageScoreWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			break;
		}
	}

}
