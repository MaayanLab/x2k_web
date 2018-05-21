# eXpression2Kinases (X2K) Web: Linking Expression Signatures to Upstream Cell Signaling Networks
While gene expression data at the mRNA level can be globally and accurately measured, profiling the activity of cell signaling pathways is currently much more difficult. eXpression2Kinases (X2K) computationally predicts involvement of upstream cell signaling pathways, given a signature of differentially expressed genes. X2K first computes enrichment for transcription factors likely to regulate the expression of the differentially expressed genes. The next step of X2K connects these enriched transcription factors through known protein-protein interactions to construct a subnetwork. The final step performs kinase enrichment analysis on the members of the subnetwork. X2K Web is a new implementation of the original Expression2Kinases algorithm with important enhancements. X2K Web includes many new transcription factor and kinase libraries, and protein-protein interaction networks. For demonstration, thousands of gene expression signatures induced by kinase inhibitors, applied to six breast cancer cell lines, are provided for fetching directly into X2K Web. The results are displayed as interactive downloadable vector graphic network images and bar graphs. Benchmarking various settings via random permutations enabled the identification of an optimal set of parameters to be used as the default settings in X2K Web. X2K Web is freely available from http://X2K.cloud.

## Build instructions
Gradle is used to fetch dependencies, build and debug the project. The two commands below in different terminals can be used to automatically rebuild/deploy the project to an embedded tomcat server for a continuous development experience.
```
# Continuous build (rebuilds on file change)
gradle build -t

# Tomcat development server (reflects file changes)
gradle tomcatRun
```

### Docker
Gradle is used to assemble a war file to be deployed with a tomcat8-base docker image.
```
# Build and assemble war file
gradle install

# Construct docker image
docker build -t maayanlab/x2k:latest .
```
