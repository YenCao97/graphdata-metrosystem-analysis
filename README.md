# Public Transport Analysis Project - HTW Berlin
## Introduction
This study project was conducted as part of the course Special Database Concepts/Techniques at the University of Applied Sciences Berlin (HTW Berlin). The objective is to analyse the public transport system in Berlin, with a focus on subway lines/sublines and Neo4j Graph Data Science (GDS). It aims to answer questions related to subway lines, sublines, station connectivity, graph algorithms like centrality (closeness centrality and betweeness centrality), community detection, and path finding.
## Technologies
* Postgres: We utilise a Postgres database that stores the 'umobility' scheme. This schema includes tables essential for this project: abschnitt (sections), haltestelle (stations), linie (lines), unterlinie (sublines), and segment.
* Neo4j: We employ Neo4j as a graph database to query the subway system data.
* Cypher: We use Cypher, a query language for Neo4j, to perform graph-related operations.
## Learning materials
To understand and work with Neo4j effectively, you can refer to the following resources:
* [Neo4j Documentation](https://neo4j.com/docs/)
* [Neo4j Graph Data Science](https://neo4j.com/docs/graph-data-science/current/)
## Prerequisites
* Neo4j package: You can install it using pip (pip install neo4j).
* Sqlalchemy toolkit: You can install it using pip (pip install sqlalchemy).
* Neo4j database: Import firstly the relevant data from Postgres to Neo4j.
## License
This project is licensed under the [GNU General Public License 3](https://www.gnu.org/licenses/gpl-3.0).
