package edu.mssm.pharm.maayanlab.X2K;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import edu.mssm.pharm.maayanlab.X2K.enrichment.GeneticAlgorithm;
import edu.mssm.pharm.maayanlab.common.core.FileUtils;

public class GeneralGA {
	
	public static void main(String[] args) {
		run();
	}

	private static void run() {
		GeneralScorer scorer = new GeneralScorer();
		
		for (String run : FileUtils.readResource("runs.txt")) {
			ArrayList<String> geneList = FileUtils.readResource("up" + File.separator + run + ".txt");
			geneList.addAll(FileUtils.readResource("down" + File.separator + run + ".txt"));
			
			try {
				PrintWriter bestScoreWriter = new PrintWriter(new FileWriter(new File(run + "_best_scores.txt")), true);
				PrintWriter averageScoreWriter = new PrintWriter(new FileWriter(new File(run + "_average_scores.txt")), true);
				
				GeneticAlgorithm ga = new GeneticAlgorithm(scorer, run, geneList, bestScoreWriter, averageScoreWriter);
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
		}
		
	}

}
