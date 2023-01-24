WITH rated AS (
SELECT p.player_name,
       p.height,
       p.weight,
       ROUND(AVG(pa.overall_rating),2) AS rating,
       DENSE_RANK() OVER(ORDER BY AVG(pa.overall_rating) DESC) AS ranking
FROM Player p
  LEFT JOIN Player_Attributes pa 
    ON p.player_api_id = pa.player_api_id 
 GROUP BY p.player_name 
 ORDER BY rating DESC
 )
 
SELECT player_name,
       height,
       weight,
       rating,
       ranking
  FROM rated
 WHERE ranking <= 10;