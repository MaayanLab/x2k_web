package edu.mssm.pharm.maayanlab.X2K.enrichment;

import java.util.Collection;
import java.util.HashSet;

import cern.colt.bitvector.BitVector;
import edu.mssm.pharm.maayanlab.ChEA.ChEA;
import edu.mssm.pharm.maayanlab.Genes2Networks.Genes2Networks;
import edu.mssm.pharm.maayanlab.KEA.KEA;
import edu.mssm.pharm.maayanlab.common.geneticalgorithm.LifeStream;

public class X2KLife extends LifeStream {

	public X2KLife(BitVector geneticCode, Collection<String> input) {
		super(geneticCode, input);
	}

	@Override
	public Collection<String> call() throws Exception {
		X2K app = new X2K();
		
		if (geneticCode.get(0))
			app.setSetting(ChEA.BACKGROUND_DATABASE, ChEA.CHIPX);
		if (geneticCode.get(1))
			app.setSetting(ChEA.BACKGROUND_DATABASE, ChEA.PWM);
		if (geneticCode.get(2))
			app.setSetting(ChEA.BACKGROUND_DATABASE, ChEA.PWM_GB);
		if (geneticCode.get(3))
			app.setSetting(ChEA.INCLUDED_ORGANISMS, ChEA.MOUSE_ONLY);
		if (geneticCode.get(4))
			app.setSetting(ChEA.INCLUDED_ORGANISMS, ChEA.HUMAN_ONLY);
		if (geneticCode.get(5))
			app.setSetting(ChEA.INCLUDED_ORGANISMS, ChEA.BOTH);
		if (geneticCode.get(7))
			app.setSetting(ChEA.SORT_BY, ChEA.PVALUE);
		if (geneticCode.get(8))
			app.setSetting(ChEA.SORT_BY, ChEA.RANK);
		if (geneticCode.get(9))
			app.setSetting(ChEA.SORT_BY, ChEA.COMBINED_SCORE);
		if (geneticCode.get(10))
			app.setSetting(X2K.NUMBER_OF_TOP_TFS, "5");
		if (geneticCode.get(11))
			app.setSetting(X2K.NUMBER_OF_TOP_TFS, "10");
		if (geneticCode.get(12))
			app.setSetting(X2K.NUMBER_OF_TOP_TFS, "20");
		app.setSetting(Genes2Networks.ENABLE_BIOCARTA, geneticCode.get(14) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		app.setSetting(Genes2Networks.ENABLE_BIOGRID, geneticCode.get(15) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		app.setSetting(Genes2Networks.ENABLE_DIP, geneticCode.get(16) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		app.setSetting(Genes2Networks.ENABLE_INNATEDB, geneticCode.get(19) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		app.setSetting(Genes2Networks.ENABLE_INTACT, geneticCode.get(20) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		app.setSetting(Genes2Networks.ENABLE_KEGG, geneticCode.get(21) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		app.setSetting(Genes2Networks.ENABLE_MINT, geneticCode.get(22) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		app.setSetting(Genes2Networks.ENABLE_PPID, geneticCode.get(26) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		app.setSetting(Genes2Networks.ENABLE_SNAVI, geneticCode.get(27) ? Genes2Networks.TRUE : Genes2Networks.FALSE);
		if (geneticCode.get(34))
			app.setSetting(X2K.MINIMUM_NETWORK_SIZE, "50");
		if (geneticCode.get(35))
			app.setSetting(X2K.MINIMUM_NETWORK_SIZE, "100");
		if (geneticCode.get(36))
			app.setSetting(X2K.MINIMUM_NETWORK_SIZE, "200");
		if (geneticCode.get(38))
			app.setSetting(KEA.SORT_BY, KEA.PVALUE);
		if (geneticCode.get(39))
			app.setSetting(KEA.SORT_BY, KEA.RANK);
		if (geneticCode.get(40))
			app.setSetting(KEA.SORT_BY, KEA.COMBINED_SCORE);
		if (geneticCode.get(41))
			app.setSetting(X2K.NUMBER_OF_TOP_KINASES, "5");
		if (geneticCode.get(42))
			app.setSetting(X2K.NUMBER_OF_TOP_KINASES, "10");
		if (geneticCode.get(43))
			app.setSetting(X2K.NUMBER_OF_TOP_KINASES, "20");
		
		app.runAll(input);
		
		HashSet<String> output = new HashSet<String>(app.getTopRankedTFs());
		output.addAll(app.getProteinNetwork());
		output.addAll(app.getTopRankedKinases());
		
		return output;
	}

}
