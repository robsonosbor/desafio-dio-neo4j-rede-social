// apagar tudo para reiniciar
MATCH (n) DETACH DELETE n;

// carregar usuários
LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
CREATE (:User {id: toInteger(row.id), name: row.name, email: row.email});

// carregar posts
LOAD CSV WITH HEADERS FROM 'file:///posts.csv' AS row
CREATE (p:Post {id: toInteger(row.id), content: row.content, timestamp: row.timestamp});
MATCH (u:User {id: toInteger(row.author)})
CREATE (u)-[:CREATED]->(p);

// relações de seguimento
LOAD CSV WITH HEADERS FROM 'file:///follows.csv' AS row
MATCH (a:User {id: toInteger(row.follower)}), (b:User {id: toInteger(row.followed)})
CREATE (a)-[:FOLLOWS]->(b);

// curtidas
LOAD CSV WITH HEADERS FROM 'file:///likes.csv' AS row
MATCH (u:User {id: toInteger(row.user)}), (p:Post {id: toInteger(row.post)})
CREATE (u)-[:LIKED]->(p);

// comentários
LOAD CSV WITH HEADERS FROM 'file:///comments.csv' AS row
MATCH (u:User {id: toInteger(row.user)}), (p:Post {id: toInteger(row.post)})
CREATE (u)-[:COMMENTED {text: row.text, timestamp: row.timestamp}]->(p);
