// 1. usuários com mais seguidores
MATCH (u:User)<-[:FOLLOWS]-()
RETURN u.name, count(*) AS followers
ORDER BY followers DESC;

// 2. posts com mais curtidas
MATCH (p:Post)<-[:LIKED]-(:User)
RETURN p.id, p.content, count(*) AS likes
ORDER BY likes DESC;

// 3. comentários por autor em posts de um usuário específico (Alice)
MATCH (author:User {name:'Alice'})-[:CREATED]->(p:Post)<-[:COMMENTED]-(c:User)
RETURN c.name, count(*) AS comments
ORDER BY comments DESC;

// 4. caminho mais curto entre Bob e David
MATCH path = shortestPath((a:User {name:'Bob'})-[:FOLLOWS*]-(d:User {name:'David'}))
RETURN path;