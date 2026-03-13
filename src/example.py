"""Exemplo simples de uso do driver Neo4j em Python."""
from neo4j import GraphDatabase

uri = "bolt://localhost:7687"
user = "neo4j"
password = "test"  # ajuste conforme sua instalação

def print_followers(tx):
    for record in tx.run("MATCH (u:User)<-[:FOLLOWS]-() RETURN u.name, count(*) AS followers ORDER BY followers DESC"):
        print(record["u.name"], record["followers"])


def main():
    driver = GraphDatabase.driver(uri, auth=(user, password))
    with driver.session() as session:
        print("Usuários mais populares:")
        session.read_transaction(print_followers)
    driver.close()


if __name__ == "__main__":
    main()
