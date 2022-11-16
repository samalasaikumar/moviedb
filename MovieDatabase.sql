use moviedb;

#Write a SQL query to find those reviewers who have rated nothing for some movies. Return reviewer name

SELECT distinct rev_name,rev_id
FROM reviewer
WHERE rev_id IN (SELECT rev_id FROM rating
WHERE rev_stars IS NULL);

# output will be showing rev_name and review satrs where null.alter


#Write a SQL query to find the movies, which have been reviewed by any reviewer body except by 'Paul Monks'. Return movie title.

SELECT movie.mov_title
FROM movie 
WHERE movie.mov_id IN(
SELECT mov_id 
FROM rating 
WHERE rev_id NOT IN (
SELECT rev_id 
FROM reviewer 
WHERE rev_name='Paul Monks'));
 
#output: the out will show  which have been reviewed by any reviewer body except by 'Paul Monks

#Write a SQL query to find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies.

SELECT mov_title, MAX(rev_stars)
FROM movie
INNER JOIN rating USING(mov_id)
GROUP BY mov_title 
HAVING MAX(rev_stars)>0
ORDER BY mov_title;

#output:the output will show the lowest rated movies.


#Write a SQL query to find the movies directed by 'James Cameron'. Return movie title.

SELECT mov_title
FROM movie
WHERE mov_id IN (
SELECT mov_id 
FROM movie_direction 
WHERE dir_id IN (
SELECT dir_id 
FROM director 
WHERE dir_fname = 'James' AND dir_lname='Cameron'
));

#output:the output will show the movies directed by 'James Cameron'.

#Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies. 

SELECT mov_title 
FROM movie 
WHERE mov_id IN (
SELECT mov_id 
FROM movie_cast 
WHERE act_id IN (
SELECT act_id 
FROM actors 
WHERE act_id IN (
SELECT act_id 
FROM movie_cast GROUP BY act_id 
HAVING COUNT(act_id)>1)));

#output:the output will show the name of those movies where one or more actors acted in two or more movies.

#Given a relation R( A, B, C, D) and Functional Dependency set FD = { AB → CD, B → C }, determine whether the given R is in 2NF? If not, convert it into 2 NF.


/*

a) FD: AB → CD satisfies the definition of 2NF

b) FD: B → C does not satisfy the definition of 2NF

As FD B → C, the above table R( A, B, C, D) is not in 2NF

Convert the table R(A, B, C, D) in 2NF:

Since FD: B → C, our table was not in 2NF, let's decompose the table

R1(B, C)

Since the key is AB, and from FD AB → CD, 
we can create R2(A, B, C, D) but this will again have a problem of partial dependency B → C, hence R2(A, B, D).

Finally, the decomposed table which is in 2NF

a) R1( B, C)
b) R2(A, B, D)
*/

#Given a relation R( P, Q, R, S, T) and Functional Dependency set FD = { PQ → R, S → T }, determine whether the given R is in 2NF? If not, convert it into 2 NF.

/*
Since R has 5 attributes: - P, Q, R, S, T and Candidate Key is PQS, 

a) FD: PQ → R does not satisfy the definition of 2NF,

b) FD: S → T does not satisfy the definition of 2NF,

Hence, FD PQ → R and S → T, the above table R( P, Q, R, S, T) is not in 2NF

Convert the table R( P, Q, R, S, T) in 2NF:

Since due to FD: PQ → R and S → T, our table was not in 2NF, let's decompose the table

R1(P, Q, R) (Now in table R1 FD: PQ → R is Full F D, hence R1 is in 2NF)

R2( S, T) (Now in table R2 FD: S → T is Full F D, hence R2 is in 2NF)

And create one table for the key, since the key is PQS.

R3(P, Q, S)

Finally, the decomposed tables which is in 2NF are:

a) R1( P, Q, R)

b) R2(S, T)

c) R3(P, Q, S)
*/

#Given a relation R( P, Q, R, S, T, U, V, W, X, Y) and Functional Dependency set FD = { PQ → R, PS → VW, QS → TU, P → X, W → Y },
# determine whether the given R is in 2NF? If not, convert it into 2 NF.

/*
.Since R has 10 attributes: - P, Q, R, S, T, U, V, W, X, Y, and Candidate Key is PQS calculated using FD = { PQ → R, PS → VW, QS → TU, P → X, W → Y }. Therefore, prime attribute(part of candidate key) are P, Q, and S while non-prime attribute are R, T, U, V, W, X and Y

FD: PQ → R does not satisfy the definition of 2NF,
FD: PS → VW does not satisfy the definition of 2NF,
FD: QS → TU does not satisfy the definition of 2NF,
FD: P → X does not satisfy the definition of 2NF,
FD: W → Y does not violate the definition of 2NF, 
Hence because of FD: PQ → R, PS → VW, QS → TU, P → X the above table R( P, Q, R, S, T, U, V, W, X, Y) is not in 2NF
Convert the table R( P, Q, R, S, T, U, V, W, X, Y) in 2NF

Since due to FD: PQ → R, PS → VW, QS → TU, P → X our table was not in 2NF, let's decompose the table
Finally, the decomposed tables which is in 2NF are:
R1(P, Q, R)
R2( P, S, V, W)
R3( Q, S, T, U)
R4( P, X)
R5( W, Y)
R6(P, Q, S)
*/

#Given a relation R( X, Y, Z, W, P) and Functional Dependency set FD = { X → Y, Y → P, and Z → W}, determine whether the given R is in 3NF? If not, convert it into 3 NF.


/*Since R has 5 attributes: - X, Y, Z, W, P

Given FD are X → Y, Y → P, and Z → W and Super Key / Candidate Key is XZ

FD: X → Y does not satisfy the definition of 3NF, 
FD: Y → P does not satisfy the definition of 3NF, 
FD: Z → W satisfies the definition of 3NF,


Since all the FD = { P → ST, Q → U, U → VW, and S → XY } were not in 3NF, let us convert R in 3NF

R1(P, S, T) {Using FD P → ST }
R2(Q, U) {Using FD Q → U }
R3( U, V, W) { Using FD U → VW }
R4( S, X, Y) { Using FD S → XY }
R5( P, Q, R) { Using FD PQ → R, and candidate key PQ }


Hence decomposed tables are:
R1(P, S, T), R2(Q, U), R3(U, V, W), R4( S, X, Y), and R5( P, Q, R)

*/

/*Given a relation R( P, Q, R, S, T, U, V, W, X, Y) and Functional Dependency set FD = { PQ → R, P → ST, Q → U, U → VW, and S → XY},
 determine whether the given R is in 3NF? If not, convert it into 3 NF.*/
 
 /*
 Since R has 10 attributes: - P, Q, R, S, T, U, V, W, X, Y, and Candidate Key is PQS calculated using FD = { PQ → R, PS → VW, QS → TU, P → X, W → Y }.

FD: PQ → R does not satisfy the definition of 3NF, 
FD: PS → VW does not satisfy the definition of 3NF, 
FD: QS → TU does not satisfy the definition of 3NF,
FD: P → X does not satisfy the definition of 3NF,
FD: W → Y does not violate the definition of 3NF,

Finally, the decomposed tables which is in 3NF are:
R1(P, Q, R)
R2( P, S, V, W)
R3( Q, S, T, U)
R4( P, X)
R5( W, Y)
R6(P, Q, S)
 */
 
 
 
 
