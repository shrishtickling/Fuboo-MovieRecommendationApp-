## Content-Based-Movie-Recommender-System-with-sentiment-analysis-using-AJAX

<p>
 <img src="https://img.shields.io/badge/-Flutter-23A9F2?style=flat-square&logo=Flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/-Figma-D22128?style=flat-square&logo=Figma&logoColor=white"/>
    <img src="https://img.shields.io/badge/-Node.js-42B883?style=flat-square&logo=Node.js&logoColor=white"/>
    <img src="https://img.shields.io/badge/-Flask-181717?style=flat-square&logo=Flask&logoColor=white"/>
    <img src="https://img.shields.io/badge/-MongoDB-123F6D?style=flat-square&logo=MongoDB&logoColor=white"/>
    <img src="https://img.shields.io/badge/-Python-FA6400?style=flat-square&logo=Python&logoColor=white"/>
   </p>
Content Based Recommender System recommends movies similar to the movie user likes and analyses the sentiments on the reviews given by the user for that movie.

The details of the movies(title, genre, runtime, rating, poster, etc) are fetched using an API by TMDB, https://www.themoviedb.org/documentation/api, and using the IMDB id of the movie in the API, I did web scraping to get the reviews given by the user in the IMDB site using `beautifulsoup4` and performed sentiment analysis on those reviews.

## Fuboo_MovieRecommendationApp

I've developed a similar application called "Fuboo" which supports all language movies. But the only thing that differs from this application is that I've used the TMDB's recommendation engine in "The Movie Cinema".

## Architecture

![Recommendation App](https://raw.githubusercontent.com/shrishtickling/Fuboo-MovieRecommendationApp-/main/Architecture.jpeg)


## Similarity Score : 

   How does it decide which item is most similar to the item user likes? Here come the similarity scores.
   
   It is a numerical value ranges between zero to one which helps to determine how much two items are similar to each other on a scale of zero to one. This similarity score is obtained measuring the similarity between the text details of both of the items. So, similarity score is the measure of similarity between given text details of two items. This can be done by cosine-similarity.
   
## How Cosine Similarity works?

  Cosine similarity is a metric used to measure how similar the documents are irrespective of their size. Mathematically, it measures the cosine of the angle between two vectors projected in a multi-dimensional space. The cosine similarity is advantageous because even if the two similar documents are far apart by the Euclidean distance (due to the size of the document), chances are they may still be oriented closer together. The smaller the angle, higher the cosine similarity.
  
  ![image](https://user-images.githubusercontent.com/36665975/70401457-a7530680-1a55-11ea-9158-97d4e8515ca4.png)

  
More about Cosine Similarity : [Understanding the Math behind Cosine Similarity](https://www.machinelearningplus.com/nlp/cosine-similarity/)

## Sentiment Analysis using Naive Bayes Algorithm


