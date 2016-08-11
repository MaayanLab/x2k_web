package edu.mssm.pharm.maayanlab.X2K.standalone;

import java.awt.Desktop;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import edu.mssm.pharm.maayanlab.X2K.enrichment.DrugDiscovery;
import edu.mssm.pharm.maayanlab.common.core.FileUtils;
import edu.mssm.pharm.maayanlab.common.core.SettingsChanger;
import edu.mssm.pharm.maayanlab.common.swing.UIUtils;

public class DrugDiscoveryPanel extends JPanel {	
	
	private static final long serialVersionUID = -3515626241959224357L;

	// JPanels
	private JPanel panel;
	
	// UI elements
	private JTextArea inputTextArea, outputTextArea;
	private JButton runButton, openButton;
	private JComboBox regulationCombo, drugDirectionCombo;
	private JTextField selectTopText;
	
	private String output;
	
	public DrugDiscoveryPanel() {
		this.setLayout(new BoxLayout(this, BoxLayout.PAGE_AXIS));
		
		// Configure panel
		panel = this;
		
		// Headers
		JPanel labelBox = new JPanel();
		labelBox.setLayout(new GridLayout(1,2));
		JLabel inputLabel = new JLabel("Input Gene Set", JLabel.CENTER);
		inputLabel.setFont(new Font(inputLabel.getFont().getName(), Font.BOLD, inputLabel.getFont().getSize()));
		JLabel outputLabel = new JLabel("Top Drugs", JLabel.CENTER);
		outputLabel.setFont(new Font(outputLabel.getFont().getName(), Font.BOLD, outputLabel.getFont().getSize()));
		labelBox.add(inputLabel);
		labelBox.add(outputLabel);
		
		// Scroll panes
		inputTextArea = new JTextArea(20, 20);
		JScrollPane inputTextPane = new JScrollPane(inputTextArea, JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		outputTextArea = new JTextArea(20, 20);
		JScrollPane outputTextPane = new JScrollPane(outputTextArea, JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		
		// Advanced Settings:
		// Select if the input is up-regulated or down-regulated
		JLabel regulationLabel = new JLabel("The input genes are ");
		String[] regulationTypes = {"up-regulated", "down-regulated"};
		regulationCombo = new JComboBox(regulationTypes);
		regulationCombo.setSelectedIndex(0);
		JPanel regulationBox = new JPanel();
		regulationBox.add(regulationLabel);
		regulationBox.add(regulationCombo);
		
		// Select if the drugs should reverse or induce an effect
		JLabel drugDirectionLabel1 = new JLabel("Find a drug that ");
		JLabel drugDirectionLabel2 = new JLabel("the effects of the input gene set");
		String[] effectTypes = {"reverses", "induces"};
		drugDirectionCombo = new JComboBox(effectTypes);
		drugDirectionCombo.setSelectedIndex(0);
		JPanel drugDirectionBox = new JPanel();
		drugDirectionBox.add(drugDirectionLabel1);
		drugDirectionBox.add(drugDirectionCombo);
		drugDirectionBox.add(drugDirectionLabel2);
		
		// Select top x number of drugs
		JLabel selectTopLabel1 = new JLabel("Find the top ");
		JLabel selectTopLabel2 = new JLabel(" drugs");
		selectTopText = new JTextField("10");
		JPanel selectTopBox = new JPanel();
		selectTopBox.add(selectTopLabel1);
		selectTopBox.add(selectTopText);
		selectTopBox.add(selectTopLabel2);
		
		// Panes
		JPanel textPanesBox = new JPanel();
		textPanesBox.setLayout(new BoxLayout(textPanesBox, BoxLayout.LINE_AXIS));
		textPanesBox.add(inputTextPane);
		textPanesBox.add(outputTextPane);
		
		// Buttons
		JPanel buttonBox = new JPanel();
		buttonBox.setLayout(new BoxLayout(buttonBox, BoxLayout.LINE_AXIS));
		
		// Run button
		runButton = new JButton("Find Drugs");
		runButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				output = "drug_results.xml";
				ArrayList<String> inputList = UIUtils.getTextAreaText(inputTextArea);
				
				try {
					if (FileUtils.validateList(inputList)) {
						DrugDiscovery dd = new DrugDiscovery();
						setSettings(dd);
						dd.run(inputList);
						UIUtils.setTextAreaText(outputTextArea, dd.getTopRankedList());
						dd.writeFile(output);
						enableOutput(output);
					}
				} catch (ParseException e1) {
					if (e1.getErrorOffset() == -1)
						JOptionPane.showMessageDialog(panel, "Input list is empty.", "Invalid Input", JOptionPane.WARNING_MESSAGE);
					else
						JOptionPane.showMessageDialog(panel, e1.getMessage() + " at line " + (e1.getErrorOffset() + 1) +" is not a valid Entrez Gene Symbol.", "Invalid Input", JOptionPane.WARNING_MESSAGE);
				}
			}
		});
		
		// View results button
		openButton = new JButton("View Results");
		openButton.setEnabled(false);
		openButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				try {
					Desktop.getDesktop().open(new File(output));
				} catch (Exception e1) {
					JOptionPane.showMessageDialog(panel, "Unable to open " + output, "Unable to open file", JOptionPane.ERROR_MESSAGE);
				}
			}
			
		});		
		buttonBox.add(runButton);
		buttonBox.add(openButton);
		
		// Advanced settings box
		JPanel advancedSettingsBox = new JPanel();
		advancedSettingsBox.setLayout(new BoxLayout(advancedSettingsBox, BoxLayout.PAGE_AXIS));
		advancedSettingsBox.setBorder(BorderFactory.createTitledBorder("Advanced Settings"));
		advancedSettingsBox.add(regulationBox);
		advancedSettingsBox.add(drugDirectionBox);
		advancedSettingsBox.add(selectTopBox);
		
		// Add all the panels together
		this.add(labelBox);
		this.add(textPanesBox);
		this.add(Box.createRigidArea(new Dimension(0,10)));
		this.add(buttonBox);
		this.add(advancedSettingsBox);
	}
	
	// Use interface to set settings of applications
	public void setSettings(SettingsChanger changer) {
		switch (regulationCombo.getSelectedIndex()) {
		case 0: changer.setSetting(DrugDiscovery.GENES_ARE_UPREGULATED, DrugDiscovery.TRUE); break;
		case 1: changer.setSetting(DrugDiscovery.GENES_ARE_UPREGULATED, DrugDiscovery.FALSE); break;
		}
		switch (drugDirectionCombo.getSelectedIndex()) {
		case 0: changer.setSetting(DrugDiscovery.DRUGS_REVERSE_EFFECT, DrugDiscovery.TRUE); break;
		case 1: changer.setSetting(DrugDiscovery.DRUGS_REVERSE_EFFECT, DrugDiscovery.FALSE); break;
		}
		changer.setSetting(DrugDiscovery.NUMBER_OF_TOP_DRUGS, selectTopText.getText());
	}
	
	// public accessor to set the input text area
	public void setInputTextArea(Collection<String> list) {
		UIUtils.setTextAreaText(inputTextArea, list);
	}
	
	// public accessor to set the output text area
	public void setOutputTextArea(Collection<String> list) {
		UIUtils.setTextAreaText(outputTextArea, list);
	}
	
	// Check if okay to enable view results button
	public void enableOutput(String output) {
		this.output = output;
		if (Desktop.isDesktopSupported() && Desktop.getDesktop().isSupported(Desktop.Action.OPEN))
			openButton.setEnabled(true);
	}
}
