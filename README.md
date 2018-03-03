# Live OWL Documentation Environment (LODE)
This repository is a Tomcat server application that can be used to create HTML documentation for [Web Ontology Language](https://www.w3.org/OWL/) (OWL) ontologies.


## Example usage:

1. Launch application:

	`mvn clean jetty:run`

2. Test

Try running LODE with the following ontologies:

* **DOLCE ontology**
	* `http://localhost:8080/lode/extract?url=http://www.loa.istc.cnr.it/ontologies/DOLCE-Lite.owl`
* **PROMS ontology**
	* contained here in the file [proms.ttl](proms.ttl)
	* it is a very tiny ontology visualised online using LODE at <http://promsns.org/def/proms/>.
	* You can run try using a local instance of LODE to generate HTML for the local copy of PROMS and compare it with the online version made by the PROMS creator


## Contacts
**Silvio Peroni**  
*Creator*  
<http://www.essepuntato.it>
