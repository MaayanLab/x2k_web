package edu.mssm.pharm.maayanlab.X2K.standalone;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.io.File;
import java.net.URL;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.JTree;
import javax.swing.ProgressMonitor;
import javax.swing.SwingUtilities;
import javax.swing.SwingWorker;
import javax.swing.UIManager;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreeSelectionModel;

import edu.mssm.pharm.maayanlab.ChEA.ChEAPanel;
import edu.mssm.pharm.maayanlab.Genes2Networks.G2NPanel;
import edu.mssm.pharm.maayanlab.KEA.KEAPanel;
import edu.mssm.pharm.maayanlab.List2Networks.L2NPanel;
import edu.mssm.pharm.maayanlab.X2K.enrichment.X2K;
import edu.mssm.pharm.maayanlab.common.core.FileUtils;
import edu.mssm.pharm.maayanlab.common.core.SettingsChanger;
import edu.mssm.pharm.maayanlab.common.swing.FileDrop;
import edu.mssm.pharm.maayanlab.common.swing.UIUtils;

public class X2Kgui extends JPanel {

	private static final long serialVersionUID = 3203621823035497572L;
	
	static Logger log = Logger.getLogger(X2Kgui.class.getSimpleName());
	
	// X2K process holder to call from nested class
	private X2K app;
	
	// JPanels
	private JPanel panel;
	private JPanel quickPanel = new JPanel();
	private ChEAPanel tfPanel = new ChEAPanel();
	private G2NPanel networkPanel = new G2NPanel();
	private KEAPanel kinasePanel = new KEAPanel();
	private DrugDiscoveryPanel ddPanel = new DrugDiscoveryPanel();
	private L2NPanel enrichmentPanel = new L2NPanel();
	
	// UI elements
	private JFileChooser openChooser, saveChooser;
	private JTextField openPath, savePath;
	private JTextArea inputTextArea;
	private JTree tree;
	private JButton runButton;
	private JComboBox tfNodeColorCombo, kinaseNodeColorCombo, substrateNodeColorCombo;
	private JCheckBox yedOutput, cytoscapeOutput, pajekOutput;
	private JTextField minNetworkSizeField;
	private ProgressMonitor progressMonitor;	// Progress bar 
	
	// Output
	private String output;	
	
	public static void main(String[] args) {
		if (args.length == 0) {
			// Schedule a job for the EDT
			SwingUtilities.invokeLater(new Runnable() {
				@Override
				public void run() {
					createAndShowGUI();
				}
			});
		}
		else{
			X2K.main(args);
		}
		
	}
	
	private static void createAndShowGUI() {
		if (!Boolean.getBoolean("verbose"))
            log.setLevel(Level.WARNING);
		
		// Try to use Nimbus look and feel
		try {            
            UIManager.setLookAndFeel("com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel");
        } catch (Exception e) {
           log.warning("Nimbus: " + e);
        }
        
        // Create and set up the window
        JFrame appFrame = new JFrame("X2K - Inferring transcription factors and kinases from gene expression");
        appFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        appFrame.setSize(new Dimension(600, 600));
        
        // Set icon
        URL imageURL = X2Kgui.class.getResource("/res/icon.png");
        if (imageURL != null) {
        	Image im = Toolkit.getDefaultToolkit().getImage(imageURL);
        	appFrame.setIconImage(im);
        }
        
        // Add content to the window
        X2Kgui appPanel = new X2Kgui();
        appFrame.setContentPane(appPanel);
        
        // Display the window
        appFrame.setResizable(false);
        appFrame.setVisible(true);
	}
	
	public X2Kgui() {
		super(new GridLayout(1, 1));
		
		// Attach instance to variable so nested classes can reference it
		panel = this;
				
		log.info("Workspace path: " + System.getProperty("user.dir"));
		
		// Create tabs
		JTabbedPane tabbedPane = new JTabbedPane();
		tabbedPane.setTabLayoutPolicy(JTabbedPane.SCROLL_TAB_LAYOUT);
		
		// First tab is the quick panel
		createQuickPanel();
		
		// Add other tabs
		tabbedPane.addTab("X2K Analysis", null, quickPanel, "Quickly find upstream kinases given genes.");
		tabbedPane.setMnemonicAt(0, KeyEvent.VK_1);
		tabbedPane.addTab("Transcription Factors", null, tfPanel, "Find transcription factors given genes. Based on ChEA.");
		tabbedPane.setMnemonicAt(1, KeyEvent.VK_2);
		tabbedPane.addTab("Protein Network", null, networkPanel, "Find intermediate protein network given transcription factors. Based on Genes2Networks.");
		tabbedPane.setMnemonicAt(2, KeyEvent.VK_3);
		tabbedPane.addTab("Kinases", null, kinasePanel, "Find kinases given protein network. Based on KEA.");
		tabbedPane.setMnemonicAt(3, KeyEvent.VK_4);
		tabbedPane.addTab("Drugs", null, ddPanel, "Find drugs that reverse/aggravate a condition. Based on DPS.");
		tabbedPane.setMnemonicAt(4, KeyEvent.VK_5);
		tabbedPane.addTab("Enrichment", null, enrichmentPanel, "Find enrichment for the gene list in various backgrounds. Based on List2Networks.");
		tabbedPane.setMnemonicAt(5, KeyEvent.VK_6);
		
		// Add tab pane	to main panel	
		this.add(tabbedPane);
	}
	
	public void createQuickPanel() {
		quickPanel.setLayout(new BoxLayout(quickPanel, BoxLayout.PAGE_AXIS));
		
		// File choosers
		openChooser = new JFileChooser(System.getProperty("user.dir"));
		openChooser.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				File file = openChooser.getSelectedFile();
				if(file.canRead() && e.getActionCommand().equals(JFileChooser.APPROVE_SELECTION))
					setupIO(file);
			}
		});
		saveChooser = new JFileChooser(System.getProperty("user.dir"));
		saveChooser.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				File file = saveChooser.getSelectedFile();
				if(file != null && e.getActionCommand().equals(JFileChooser.APPROVE_SELECTION)) {
					if (!file.getName().endsWith(".xml")) {
						file = new File(file.getAbsolutePath() + ".xml");
						saveChooser.setSelectedFile(file);
					}
						
					savePath.setText(file.getAbsolutePath());
				}
			}
		});
		
		// Gene list
		JButton openFile = new JButton("Input Gene List");
		openFile.setPreferredSize(new Dimension(160, 30));
		openFile.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				openChooser.showOpenDialog(quickPanel);
			}
		});
		openPath = new JTextField();
		openPath.setPreferredSize(new Dimension(420,30));
		
		// File Drop
		new FileDrop(openPath, new FileDrop.Listener() {
			@Override
			public void filesDropped(File[] files) {
				if (files[0].canRead()) {
					setupIO(files[0]);
					openChooser.setSelectedFile(files[0]);
				}
			}
		});
		
		// Output file
		JButton saveFile = new JButton("Output Summary");
		saveFile.setPreferredSize(new Dimension(160, 30));
		saveFile.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				saveChooser.showSaveDialog(quickPanel);
			}
		});
		savePath = new JTextField();
		savePath.setPreferredSize(new Dimension(420,30));
		
		// Tree
		tree = new JTree(new DefaultMutableTreeNode("Ready to run X2K!"));
		tree.getSelectionModel().setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
		tree.setShowsRootHandles(true);
		
		// Scroll panes
		inputTextArea = new JTextArea(20, 20);
		JScrollPane inputTextPane = new JScrollPane(inputTextArea, JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		inputTextPane.setPreferredSize(new Dimension(300, 300));
		inputTextArea.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent e) {
				log.info("Added text from input text area.");
				runButton.setEnabled(!inputTextArea.getText().isEmpty());
			}
			
			@Override
			public void removeUpdate(DocumentEvent e) {
				log.info("Removed text from input text area.");
				runButton.setEnabled(!inputTextArea.getText().isEmpty());
			}
			
			@Override
			public void changedUpdate(DocumentEvent e) {
				// This is never fired
			}
		});
		JScrollPane outputTextPane = new JScrollPane(tree, JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		outputTextPane.setPreferredSize(new Dimension(300, 300));
		
		// File Drop
		new FileDrop(inputTextArea, new FileDrop.Listener() {
			@Override
			public void filesDropped(File[] files) {
				if (files[0].canRead()) {
					setupIO(files[0]);
					openChooser.setSelectedFile(files[0]);
				}
			}
		});
		
		// Start button
		runButton = new JButton("Start Analysis");
		runButton.setEnabled(false);
		runButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				output = savePath.getText();

				try {
					if (FileUtils.validateList(UIUtils.getTextAreaText(inputTextArea))) {
						app = new X2K();
						
						setSettings(app);
						tfPanel.setSettings(app);
						networkPanel.setSettings(app);
						kinasePanel.setSettings(app);
						
						DefaultMutableTreeNode rootNode = new DefaultMutableTreeNode("Please wait while X2K runs.");
						DefaultTreeModel treeModel = new DefaultTreeModel(rootNode);
						tree.setModel(treeModel);
						tree.setRootVisible(true);
						
						progressMonitor = new ProgressMonitor(panel, "Running X2K", "", 0, 100);
						progressMonitor.setMillisToDecideToPopup(0);
						progressMonitor.setProgress(0);
						
						final Task task = new Task();
						app.setTask(task);
						task.addPropertyChangeListener(new PropertyChangeListener() {
							@Override
							public void propertyChange(PropertyChangeEvent evt) {
								if ("progress" == evt.getPropertyName()) {
									int progress = (Integer) evt.getNewValue();
									progressMonitor.setProgress(progress);
								}
								else if ("note" == evt.getPropertyName()) {
									String message = (String) evt.getNewValue();
									progressMonitor.setNote(message);
								}
								
								if (progressMonitor.isCanceled()) {
									task.cancel(true);
									app.cancel();
								}
							}
						});
						task.execute();
						runButton.setEnabled(false);
					}
				} catch (ParseException e1) {
					if (e1.getErrorOffset() == -1)
						JOptionPane.showMessageDialog(panel, "Input list is empty.", "Invalid Input", JOptionPane.WARNING_MESSAGE);
					else
						JOptionPane.showMessageDialog(panel, e1.getMessage() + " at line " + (e1.getErrorOffset() + 1) +" is not a valid Entrez Gene Symbol.", "Invalid Input", JOptionPane.WARNING_MESSAGE);
				}
			}
		});		
		
		// Input and output box
		JPanel ioBox = new JPanel();
		ioBox.setLayout(new GridLayout(2,2));
		ioBox.add(openFile);
		ioBox.add(saveFile);
		ioBox.add(openPath);	
		ioBox.add(savePath);
		
		// Panes
		JPanel textPanesBox = new JPanel();
		textPanesBox.setLayout(new BoxLayout(textPanesBox, BoxLayout.LINE_AXIS));
		textPanesBox.add(inputTextPane);
		textPanesBox.add(outputTextPane);
		
		// Button box
		JPanel buttonBox = new JPanel();
		buttonBox.add(runButton);
		
		// Advanced settings box
		JPanel advancedSettingsBox = new JPanel();
		advancedSettingsBox.setLayout(new BoxLayout(advancedSettingsBox, BoxLayout.PAGE_AXIS));
		advancedSettingsBox.setBorder(BorderFactory.createTitledBorder("Advanced Settings"));
		
		String[] colors = {"pink", "red", "orange", "yellow", "green", "cyan", "blue", "magenta", "black", "dark gray", "gray", "light gray", "white"};
		
		JLabel tfNodeColorLabel = new JLabel("Color transcription factor nodes");
		tfNodeColorCombo = new JComboBox(colors);
		tfNodeColorCombo.setSelectedIndex(1);
		JPanel tfNodeColorBox = new JPanel();
		tfNodeColorBox.add(tfNodeColorLabel);
		tfNodeColorBox.add(tfNodeColorCombo);
		
		JLabel substrateNodeColorLabel = new JLabel("Color intermediate protein nodes");
		substrateNodeColorCombo = new JComboBox(colors);
		substrateNodeColorCombo.setSelectedIndex(3);
		JPanel substrateNodeColorBox = new JPanel();
		substrateNodeColorBox.add(substrateNodeColorLabel);
		substrateNodeColorBox.add(substrateNodeColorCombo);
		
		JLabel kinaseNodeColorLabel = new JLabel("Color kinase nodes");
		kinaseNodeColorCombo = new JComboBox(colors);
		kinaseNodeColorCombo.setSelectedIndex(4);
		JPanel kinaseNodeColorBox = new JPanel();
		kinaseNodeColorBox.add(kinaseNodeColorLabel);
		kinaseNodeColorBox.add(kinaseNodeColorCombo);
		
		JLabel minNetworkSizeLabel1 = new JLabel("Network should have a minimum of");
		minNetworkSizeField = new JTextField("50");
		JLabel minNetworkSizeLabel2 = new JLabel("proteins");
		JPanel minNetworkSizeBox = new JPanel();
		minNetworkSizeBox.add(minNetworkSizeLabel1);
		minNetworkSizeBox.add(minNetworkSizeField);
		minNetworkSizeBox.add(minNetworkSizeLabel2);
		
		JLabel outputLabel = new JLabel("Select desired outputs: ");
		yedOutput = new JCheckBox("yEd Network", true);
		cytoscapeOutput = new JCheckBox("Cytoscape Network", false);
		pajekOutput = new JCheckBox("Pajek Network", false);
		JPanel outputBox = new JPanel();
		outputBox.add(outputLabel);
		outputBox.add(yedOutput);
		outputBox.add(cytoscapeOutput);
		outputBox.add(pajekOutput);
		
		advancedSettingsBox.add(tfNodeColorBox);
		advancedSettingsBox.add(substrateNodeColorBox);
		advancedSettingsBox.add(kinaseNodeColorBox);
		advancedSettingsBox.add(minNetworkSizeBox);
		advancedSettingsBox.add(outputBox);
		
		// Add content
		quickPanel.add(ioBox);
		quickPanel.add(textPanesBox);
		quickPanel.add(buttonBox);
		quickPanel.add(advancedSettingsBox);
	}
	
	public void setSettings(SettingsChanger changer) {
		changer.setSetting(X2K.TF_NODE_COLOR, getColor(tfNodeColorCombo.getSelectedIndex()));
		changer.setSetting(X2K.SUBSTRATE_NODE_COLOR, getColor(substrateNodeColorCombo.getSelectedIndex()));
		changer.setSetting(X2K.KINASE_NODE_COLOR, getColor(kinaseNodeColorCombo.getSelectedIndex()));
		changer.setSetting(X2K.MINIMUM_NETWORK_SIZE, minNetworkSizeField.getText());
		changer.setSetting(X2K.ENABLE_YED_OUTPUT, Boolean.toString(yedOutput.isSelected()));
		changer.setSetting(X2K.ENABLE_CYTOSCAPE_OUTPUT, Boolean.toString(cytoscapeOutput.isSelected()));
		changer.setSetting(X2K.ENABLE_PAJEK_OUTPUT, Boolean.toString(pajekOutput.isSelected()));
	}
	
	private String getColor(int index) {
		Color color = Color.BLACK;
		
		switch (index) {
		case 0: color = Color.PINK; break;
		case 1: color = Color.RED; break;
		case 2: color = Color.ORANGE; break;
		case 3: color = Color.YELLOW; break;
		case 4: color = Color.GREEN; break;
		case 5: color = Color.CYAN; break;
		case 6: color = Color.BLUE; break;
		case 7: color = Color.MAGENTA; break;
		case 8: color = Color.BLACK; break;
		case 9: color = Color.DARK_GRAY; break;
		case 10: color = Color.GRAY; break;
		case 11: color = Color.LIGHT_GRAY; break;
		case 12: color = Color.WHITE; break;
		}
		
		return "#" + String.format("%06x", color.getRGB() & 0x00ffffff);
	}
	
	// public accessor to set the input text area
	public void setInputTextArea(Collection<String> list) {
		UIUtils.setTextAreaText(inputTextArea, list);
	}
	
	private void setupIO(File inputFile) {
		openPath.setText(inputFile.getAbsolutePath());
		
		ArrayList<String> list = FileUtils.readFile(inputFile.getAbsolutePath());
		setInputTextArea(list);
		tfPanel.setInputTextArea(list);
		ddPanel.setInputTextArea(list);
		enrichmentPanel.setInputTextArea(list);
		enrichmentPanel.setupIO(inputFile);
		
		File outputFile = new File(System.getProperty("user.dir"), FileUtils.stripFileExtension(inputFile.getName()) + ".results.xml");
		saveChooser.setSelectedFile(outputFile);
		savePath.setText(outputFile.getAbsolutePath());
	}
	
	public void updateTree() {
		DefaultTreeModel treeModel = (DefaultTreeModel) tree.getModel();
		DefaultMutableTreeNode rootNode = (DefaultMutableTreeNode) treeModel.getRoot();
		
		// Insert TF nodes		
		DefaultMutableTreeNode categoryNode = new DefaultMutableTreeNode("Transcription Factors");
		treeModel.insertNodeInto(categoryNode, rootNode, rootNode.getChildCount());
		rootNode.add(categoryNode);
		
		for (String tf : app.getTopRankedTFs()) {
			DefaultMutableTreeNode tfNode = new DefaultMutableTreeNode(tf);
			treeModel.insertNodeInto(tfNode, categoryNode, categoryNode.getChildCount());
			categoryNode.add(tfNode);
		}
		
		// Insert network nodes
		categoryNode = new DefaultMutableTreeNode("Protein Network");
		treeModel.insertNodeInto(categoryNode, rootNode, rootNode.getChildCount());
		rootNode.add(categoryNode);
		
		// Filter out TFs and kinases from protein network
		HashSet<String> filteredNetwork = new HashSet<String>(app.getProteinNetwork().size());
		filteredNetwork.addAll(app.getProteinNetwork());
		filteredNetwork.removeAll(app.getTopRankedTFs());
		filteredNetwork.removeAll(app.getTopRankedKinases());
		
		for (String protein : filteredNetwork) {
			DefaultMutableTreeNode proteinNode = new DefaultMutableTreeNode(protein);
			treeModel.insertNodeInto(proteinNode, categoryNode, categoryNode.getChildCount());
			categoryNode.add(proteinNode);
		}
		
		// Insert kinase nodes
		categoryNode = new DefaultMutableTreeNode("Kinases");
		treeModel.insertNodeInto(categoryNode, rootNode, rootNode.getChildCount());
		rootNode.add(categoryNode);
		
		for (String kinase : app.getTopRankedKinases()) {
			DefaultMutableTreeNode kinaseNode = new DefaultMutableTreeNode(kinase);
			treeModel.insertNodeInto(kinaseNode, categoryNode, categoryNode.getChildCount());
			categoryNode.add(kinaseNode);
		}
	}
	
	class Task extends SwingWorker<Void, Void> {
		@Override
		protected Void doInBackground() {
			app.run(UIUtils.getTextAreaText(inputTextArea));
			if (!output.equals(""))
				app.writeFile(output);
			
			try {
				Thread.sleep(500);
				setProgress(100);
			} catch(InterruptedException e) { }
			
			return null;
		}
		
		@Override
		public void done() {
			if (isCancelled()) {
				cancelled();
			}
			else {	
				HashSet<String> network = app.getProteinNetwork();
				
				tfPanel.setOutputTextArea(app.getTopRankedTFs());
				networkPanel.setInputTextArea(app.getTopRankedTFs());
				networkPanel.setOutputTextArea(app.getProteinNetwork());
				networkPanel.setNetworkSet(app.getProteinNetworkSet());
				kinasePanel.setInputTextArea(app.getProteinNetwork());
				kinasePanel.setOutputTextArea(app.getTopRankedKinases());
				updateTree();
				tree.expandRow(0);
				tree.setRootVisible(false);
				
				network.addAll(app.getTopRankedTFs());
				network.addAll(app.getTopRankedKinases());
				
				ddPanel.setInputTextArea(network);
				
				if (!output.equals("")) {
					tfPanel.enableOutput(app.getChEAOutputName());
					networkPanel.enableOutput(app.getG2NOutputName());
					kinasePanel.enableOutput(app.getKEAOutputName());
				}
				
				runButton.setEnabled(true);
			}		
		}
		
		private void cancelled() {
			DefaultMutableTreeNode rootNode = new DefaultMutableTreeNode("Last run was cancelled.");
			DefaultTreeModel treeModel = new DefaultTreeModel(rootNode);
			tree.setModel(treeModel);
			tree.setRootVisible(true);
			
			runButton.setEnabled(true);
		}
	}
}