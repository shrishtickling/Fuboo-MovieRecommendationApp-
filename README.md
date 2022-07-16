## Content-Based-Movie-Recommender-System-with-sentiment-analysis

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

I've developed a similar movie streaming application called "Fuboo" which supports all language movies. But the only thing that differs from this application is that I've used the TMDB's recommendation engine in "The Movie Cinema".

## Architecture

![Recommendation App](https://raw.githubusercontent.com/shrishtickling/Fuboo-MovieRecommendationApp-/main/Architecture.jpeg)

## User Research
![image](https://user-images.githubusercontent.com/83607556/179366934-12f68af1-4da2-44cb-aac6-103a14e9257a.png)
![image](https://user-images.githubusercontent.com/83607556/179366942-02a5540c-b101-4e2b-8fd4-882ed2347ab1.png)
![image](https://user-images.githubusercontent.com/83607556/179366948-5bbe3dfa-a19b-48f4-92e5-618239a93225.png)
![image](https://user-images.githubusercontent.com/83607556/179366952-3376384d-b90f-458b-84e9-8381aa91739f.png)
![image](https://user-images.githubusercontent.com/83607556/179366962-768b0138-1956-4d95-9146-40dde0de0309.png)


# ALGORITHMS USED
## Similarity Score : 

   How does it decide which item is most similar to the item user likes? Here come the similarity scores.
   
   It is a numerical value ranges between zero to one which helps to determine how much two items are similar to each other on a scale of zero to one. This similarity score is obtained measuring the similarity between the text details of both of the items. So, similarity score is the measure of similarity between given text details of two items. This can be done by cosine-similarity.
   
## How Cosine Similarity works?

  Cosine similarity is a metric used to measure how similar the documents are irrespective of their size. Mathematically, it measures the cosine of the angle between two vectors projected in a multi-dimensional space. The cosine similarity is advantageous because even if the two similar documents are far apart by the Euclidean distance (due to the size of the document), chances are they may still be oriented closer together. The smaller the angle, higher the cosine similarity.
  
  ![image](https://goodboychan.github.io/images/cos_sim.png)

  
More about Cosine Similarity : [Understanding the Math behind Cosine Similarity](https://www.machinelearningplus.com/nlp/cosine-similarity/)

## Sentiment Analysis using Naive Bayes Algorithm

Naive Bayes classifiers are a collection of classification algorithms based on Bayes’ Theorem. It is not a single algorithm but a family of algorithms where all of them share a common principle, i.e. every pair of features being classified is independent of each other.

![Sentiment Analysis](https://raw.githubusercontent.com/shrishtickling/Fuboo-MovieRecommendationApp-/main/sentiment.jpeg)

More about Naive Bayes Classifier : [Understanding Naive Bayes Classifier](https://towardsdatascience.com/introduction-to-na%C3%AFve-bayes-classifier-fa59e3e24aaf)


