--
-- Create embedded_documents table
--
USE test;
CREATE TABLE embedded_documents (
  id        INT       PRIMARY KEY,
  document  TEXT,
  embedding VECTOR(3)
);

--
-- Insert data into embedded_documents table
--
INSERT INTO embedded_documents VALUES
(1, 'dog', '[1,2,1]'),
(2, 'fish', '[1,2,4]'),
(3, 'tree', '[1,0,0]');

--
-- Check data in embedded_documents table
--
SELECT * FROM embedded_documents;

--
-- VEC_L1_DISTANCE
--
SELECT document, VEC_L1_DISTANCE(embedding, '[1,2,3]') AS VEC_L1_DISTANCE FROM embedded_documents;

--
-- VEC_L2_DISTANCE
--
SELECT document, VEC_L2_DISTANCE(embedding, '[1,2,3]') AS VEC_L2_DISTANCE FROM embedded_documents;

--
-- VEC_COSINE_DISTANCE
--
SELECT document, VEC_COSINE_DISTANCE(embedding, '[1,2,3]') AS VEC_COSINE_DISTANCE FROM embedded_documents;

--
-- VEC_NEGATIVE_INNER_PRODUCT
--
SELECT document, VEC_NEGATIVE_INNER_PRODUCT(embedding, '[1,2,3]') AS VEC_NEGATIVE_INNER_PRODUCT FROM embedded_documents;

