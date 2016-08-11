package edu.mssm.pharm.maayanlab.X2K.enrichment;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Random;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import cern.colt.bitvector.BitVector;
import edu.mssm.pharm.maayanlab.common.geneticalgorithm.LifeStream;
import edu.mssm.pharm.maayanlab.common.geneticalgorithm.Scorer;

public class GeneticAlgorithm {
	
	public final int STRING_LENGTH = 44;
	public final int GENERATIONS = 50;
	public final int POPULATION_SIZE = STRING_LENGTH*2;
	// Based on De Jong
	public final double CROSSOVER_PROBABILITY = 0.6;
	public final double MUTATION_PROBABILITY = 0.001;
	
	private Random rng = new Random();
	private PrintWriter bestScoreWriter = null;
	private PrintWriter averageScoreWriter = null;
	
	// Input
	private Scorer scorer;
	private String identifier;
	private Collection<String> input;
	
	public GeneticAlgorithm(Scorer scorer, String identifier, Collection<String> geneList) {
		this.scorer = scorer;
		this.identifier = identifier;
		this.input = geneList;
	}
	
	public GeneticAlgorithm(Scorer scorer, String identifier, Collection<String> geneList, PrintWriter bestScoreWriter, PrintWriter averageScoreWriter) {
		this.scorer = scorer;
		this.identifier = identifier;
		this.input = geneList;
		this.bestScoreWriter = bestScoreWriter;
		this.averageScoreWriter = averageScoreWriter;
	}
	
	public int[] run() {
		return analyze(evolve());
	}
	
	private BitVector[] evolve() {
		// Initial population generation
		BitVector[] population = creation(POPULATION_SIZE);	// Double so that the population size is a multiple of 2
		// Placeholder for next generation
		double[] scores;
		BitVector[] offspring;
		
		// Statistics
		double[] bestScores = new double[GENERATIONS];
		double[] averageScores = new double[GENERATIONS];
		
		for (int generation = 0; generation < GENERATIONS; generation++) {
			// Run through X2K
			scores = evaluate(population);
			// Select and crossover
			offspring = selection(population, scores);
			// Mutation
			for (int i = 0; i < offspring.length; i++)
				offspring[i] = mutate(offspring[i]);
			// Start a new generation
			population = offspring;
			
			// Calculate statistics
			double maxScore = 0;
			double sum = 0;
			for (double score : scores) {
				if (score > maxScore)
					maxScore = score;
				sum += score;
			}
			// Record statistics
			bestScores[generation] = maxScore;
			averageScores[generation] = sum/scores.length;
			System.out.println(generation + ". Best Score: " + bestScores[generation]);
			System.out.println(generation + ". Average Score: " + averageScores[generation]);
			if (bestScoreWriter != null)
				bestScoreWriter.println(generation + "\t" + bestScores[generation]);
			if (averageScoreWriter != null)
				averageScoreWriter.println(generation + "\t" + averageScores[generation]);
		}
		
		return population;
	}
	
	private int[] analyze(BitVector[] population) {
		int[] counts = new int[STRING_LENGTH];
		
		for (BitVector geneticCode : population)
			for (int i = 0; i < geneticCode.size(); i++)
				if (geneticCode.get(i))
					counts[i]++;
		
		return counts;
	}
	
	// Valid rules
	private boolean isValidString(BitVector testString) {
		if (!isOneHot(testString.partFromTo(0, 2)))
			return false;
		if (!isOneHot(testString.partFromTo(3, 5)))
			return false;
		if (testString.get(6))	// temp
			return false;
		if (!isOneHot(testString.partFromTo(7, 9)))
			return false;
		if (!isOneHot(testString.partFromTo(10, 12)))
			return false;
		if (testString.partFromTo(13, 29).cardinality() < 7)
			return false;
		if (testString.get(30))	// temp
			return false;
		if (testString.get(32))	// temp
			return false;
		if (testString.get(33))	// temp
			return false;
		if (!isOneHot(testString.partFromTo(31, 33)))
			return false;
		if (!isOneHot(testString.partFromTo(34, 36)))
			return false;
		if (testString.get(37))	// temp
			return false;
		if (!isOneHot(testString.partFromTo(38, 40)))
			return false;
		if (!isOneHot(testString.partFromTo(41, 43)))
			return false;
		
		return true;
	}
	
	private boolean isOneHot(BitVector testBooleans) {
		return testBooleans.cardinality() == 1;
	}
	
	// Generates a random binary string, may not be valid
	private BitVector getRandomString() {
		BitVector newString = new BitVector(STRING_LENGTH);
		
		for (int i = 0; i < newString.size(); i++)
			newString.put(i, rng.nextBoolean());
		
		return newString;
	}
	
	// Generates only valid binary strings
	private BitVector getValidString() {
		BitVector testString;
		
		for (testString = getRandomString(); !isValidString(testString); testString = getRandomString());
		
		return testString;
	}

	// Creates a populationSize-length BitVector array
	private BitVector[] creation(int populationSize) {
		BitVector[] population = new BitVector[populationSize];
		
		for (int i = 0; i < population.length; i++)
			population[i] = getValidString();
		
		return population;
	}
	
	// Run X2K on the population of binary strings
	private double[] evaluate(BitVector[] population) {
		// 10 threads
		ExecutorService nature = Executors.newFixedThreadPool(20);
		ArrayList<Future<Collection<String>>> resultList = new ArrayList<Future<Collection<String>>>();
		
		// Queue threads into scheduler
		for (BitVector geneticCode : population) {
			LifeStream life = new X2KLife(geneticCode, input);
			Future<Collection<String>> submit = nature.submit(life);
			resultList.add(submit);
		}
		
		double[] fitnessScores = new double[population.length];
		
		// Accessing a future will wait until computation is done and then retrieve result 
		for (int i = 0; i < resultList.size(); i++) {
			try {
				fitnessScores[i] = score(resultList.get(i).get());
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
		}
		
		nature.shutdown();
		
		return fitnessScores;
	}
	
	private double score(Collection<String> output) {
		return scorer.score(identifier, output);
	}
	
	private class BitVectorScorePair implements Comparable<BitVectorScorePair> {
		
		private BitVector binaryString;
		private double fitnessScore;

		public BitVectorScorePair(BitVector binaryString, double fitnessScore) {
			this.binaryString = binaryString;
			this.fitnessScore = fitnessScore;
		}
		
		public BitVector getBinaryString() {
			return binaryString;
		}
		
		public double getScore() {
			return fitnessScore;
		}
		
		public void setScore(double newScore) {
			this.fitnessScore = newScore;
		}

		@Override
		public int compareTo(BitVectorScorePair o) {
			if (this.getScore() < o.getScore())				
				return 1;
			else if (this.getScore() > o.getScore())
				return -1;
			else
				return 0;
		}
		
	}
	
	// Selects the top scoring binary strings and then mates them
	private BitVector[] selection(BitVector[] population, double[] scores) {
		// Debug
		assert population.length == scores.length;
		
		ArrayList<BitVectorScorePair> sortedScores = new ArrayList<BitVectorScorePair>(scores.length);
		BitVector[] offspring = new BitVector[population.length];
		
		// Sum of all fitness values
		double sum = 0;
		for (double score : scores)
			sum += score;
		
		// Normalized fitness values
		for (int i = 0; i < scores.length; i++)
			sortedScores.add(new BitVectorScorePair(population[i], scores[i]/sum));
		
		// Sort in descending order
		Collections.sort(sortedScores);
		
		// Debug
		assert sortedScores.get(0).getScore() >= sortedScores.get(1).getScore();
		
		// Accumulated normalized fitness values
		for (int i = 1; i < sortedScores.size(); i++)
			sortedScores.get(i).setScore(sortedScores.get(i).getScore() + sortedScores.get(i-1).getScore());
		
		// Population is a multiple of 2
		for (int i = 0; i < population.length/2 ; i++) {
			// Find first parent
			double criteria1 = rng.nextDouble();
			BitVector parent1 = null;
			for (int j = 0; j < sortedScores.size(); j++) {
				if (sortedScores.get(j).getScore() > criteria1) {	// Find first score that is greater than the random number
					parent1 = sortedScores.get(j).getBinaryString();
					break;
				}
			}
			
			// Find second parent
			double criteria2 = rng.nextDouble();
			BitVector parent2 = null;
			for (int j = 0; j < sortedScores.size(); j++) {
				if (sortedScores.get(j).getScore() > criteria2) {
					parent2 = sortedScores.get(j).getBinaryString();
					break;
				}
			}
			
			BitVector[] children = crossover(parent1, parent2);
			offspring[i*2] = children[0];
			offspring[i*2+1] = children[1];
		}
		
		return offspring;
	}
	
	// Returns a valid crossover pair
	private BitVector[] crossover(BitVector parent1, BitVector parent2) {
		BitVector[] children = new BitVector[2];
		
		if (rng.nextDouble() < CROSSOVER_PROBABILITY) {
			do {
				int position = rng.nextInt(STRING_LENGTH);
				
				BitVector child1 = (BitVector) parent1.clone();
				BitVector child2 = (BitVector) parent2.clone();
				
				for (int i = position; i < STRING_LENGTH; i++) {
					child1.put(i, parent2.get(i));
					child2.put(i, parent1.get(i));
				}					
				
				children[0] = child1;
				children[1] = child2;				
			} while (!isValidString(children[0]) || !isValidString(children[1]));
		}
		else {
			children[0] = parent1;
			children[1] = parent2;
		}
		
		return children;
	}
	
	// Returns a valid mutant
	private BitVector mutate(BitVector original) {
		BitVector mutant;
		
		do {
			mutant = (BitVector) original.clone();
			
			for (int i = 0; i < original.size(); i++)
				if (rng.nextDouble() < MUTATION_PROBABILITY)
					mutant.put(i, !mutant.get(i));
			
		} while (!isValidString(mutant));
		
		return mutant;
	}

}
