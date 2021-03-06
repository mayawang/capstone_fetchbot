# Fetchbot: “The Pandora for readers”

Fetchbot is a personalized content stream that fetches articles you’ll love on the internet and continually evolves with your tastes.
You can train your Fetchbot by marking the article as “like” or “dislike”. The more feedback a user feeds to Fetchbot, the better results Fetchbot can gives back.

- Check out [Demo Video](https://youtu.be/cxbzO0MGIZM)
  - User ID input bar on top is a temporary work around to simulate experience for different users
  - The user ID are from demo dataset
  - This could be replaced by proper authentication

## Problem Statement:
- Content aggregator sites are too busy and noisy
- Not tailored to individual tastes

## Targeted User:
- Casual readers
- Not focused on time-sensitive content
- Need quality and individualized content with a clean interface
(Read [more detailed user stories](https://github.com/mayawang/capstone_fetchbot/blob/master/docs/user_stories.md))

## Technology Stack:
- Frontend:
  - Web UI: [Angular2](https://angular.io/) + [TypeScript](https://www.typescriptlang.org/)
- Backend:
  - User Content Stream Service API: [Ruby on Rails](http://rubyonrails.org/)
  - User Preference Database: [Redis](https://redis.io/)
  - Content Recommendation: [Recommendable](https://github.com/davidcelis/recommendable)
  - Crawler: Python [Scrapy](https://scrapy.org/)
  - Scraped Content Database: [PostgresSQL](https://www.postgresql.org/)

## Architectural Design:
![Image of Architecture Diagram](https://github.com/mayawang/capstone_fetchbot/blob/master/docs/assets/Fetchbot_architecture_diagram.png)

### WebUI:
![Image of WebUI](https://github.com/mayawang/capstone_fetchbot/blob/master/docs/assets/Fetchbot_WebUI.png)
- AngularJS 2 with TypeScript
- Single-page Model-View-ViewModel design
- Talks to Content Stream Service through REST-like API

### Content Stream Service:(Rails API)
#### Search
- Endpoint: HTTP GET /search/?q=<search text>&uid=<user ID>
- Response:
  - Response is encoded in JSON
  - Response includes article that matches search text
  - Example:
```JSON
{
	"items": [{
		"id": 1,
		"title": "article 1 title",
		"link": "http://example.com/article1",
		"summary": "article 1 summary",
		"keywords": "a few keywords"
	}, {
		"id": 2,
		"title": "article 2 title",
		"link": "http://example.com/article2",
		"summary": "article 2 summary",
		"keywords": "some other keywords"
	}]
}
```
#### Like
- Endpoint HTTP POST /like/?cid=<content ID>&uid=<user ID>
- Response:
  - Response is encoded in JSON
  - Response includes article that we recommend to user after considering user liked this content
  - Example:
```JSON
{
	"items": [{
		"id": 1,
		"title": "recommended article 1 title",
		"link": "http://example.com/recommended_article1",
		"summary": "recommended article 1 summary",
		"keywords": "a few keywords"
	}, {
		"id": 2,
		"title": "recommended article 2 title",
		"link": "http://example.com/article2",
		"summary": "recommended article 2 summary",
		"keywords": "some other keywords"
	}]
}
```
#### Dislike
- Endpoint HTTP POST /dislike/?cid=<content ID>&uid=<user ID>
- Response:
  - Response is encoded in JSON
  - Response includes article that we recommend to user after considering user disliked this content
Once an article is disliked, it will never appear in the recommendation again
  - Example:
```JSON
{
	"items": [{
		"id": 1,
		"title": "recommended article 1 title",
		"link": "http://example.com/recommended_article1",
		"summary": "recommended article 1 summary",
		"keywords": "a few keywords"
	}, {
		"id": 2,
		"title": "recommended article 2 title",
		"link": "http://example.com/article2",
		"summary": "recommended article 2 summary",
		"keywords": "some other keywords"
	}]
}
```
#### Content Recommendation
- Content-based Search using PostgreSQL text search
  - “Search” API endpoint is implemented using PostgreSQL text-based search.
  - Current implementation does not have fine-tuned ranking capability.
  - This could be improved with better search engine like ElasticSearch.
- Collaborative filtering using [Recommendable](https://github.com/davidcelis/recommendable)
  - Has user model and article model
  - For each user, record user’s set of liked articles and disliked articles
  - When a user dislike an article, we also hide this article from this user so that it never appears in recommendation for this user.
  - When generating recommendation for a user, use Jaccardian similarity for find users with similar tastes and return these users’ liked articles.
  - Recommendable uses Redis to store users’ liked and disliked articles. It also uses Redis’ set operation to perform Jaccardian similarity operation efficiently.

#### Crawler [Python Scrapy](https://scrapy.org/)
- We only have URLs from the deli.ci.ous data set, therefore we need to crawl the actual content from Internet using a crawler
- We use scrapy to crawl web page content
- Web page is processed through a data processing pipeline that extract:
  - Title, from HTML page heading
  - Summary, from HTML page description meta tag and with heuristics
  - Keywords, if HTML page has such meta tag
  - Extract web page data is saved to PostgreSQL as Articles

## Entity-Relation Diagram
![Image of ERD](https://github.com/mayawang/capstone_fetchbot/blob/master/docs/assets/Fetchbot_ERD.png)

## Business Decisions
- **How to solve the “cold start” problem**
  - Initially we don’t know what users like or dislike.
  - User probably already has articles to they want to read in mind, therefore showing random articles does not seem to be useful.
  - We also considered showing the top N popular articles from all users. But it does not deliver a personalized product experience.
  - We decided to give user a search box and let user browse search results and mark article with like or dislike.
  - We could also add a “select your interests” step when user first come to our site.
- **Whether there should be a “skip/swipe to dismiss” feature**
  - We could have a Skip/Swipe to dismiss feature to allow users who are indifferent(not interested but not to the extend of dislike) to the article to skip the article.
  - Pandora has similar feature to allow users to skip music.
  - We decided not implement this feature and only keep “like” and “dislike”.
  - Our product is different than music recommendation because user rarely want to read an article twice where as a user would very likely to want to listen to a liked music many times. Therefore we do not need to differentiate user’s feedback from skip (not interested for now) and dislike/hate/never-show-again.
  - Instead, we could add a feature to let users to revisit a list of liked articles.
  - Also, in this way, we can encourage user to provide more effective feedbacks(like/dislike) for recommendation algorithms to work with.
- **Whether there should be "channels"**
  - We could have a channel feature that is similar to “Station” in Pandora.
  - Each channel could be focused on a single topic.
  - This could improves intra-channel content cohesion.
  - However channel feature will complicate UX by having multiple article lists for user to choose from.
  - For leisure + discovery reading multiple channels are not really necessary.
  - For now, we decide to drop the channel feature to keep UX simple and focused.

## Demo Data Set:
  - [Deli.ci.ous bookmarks dataset](https://grouplens.org/datasets/hetrec-2011/)(2011)
  - 1800+ users
  - 69,000+ articles (URLs)
  - Initially, I built a crawler to scrape new contents to my recommender system. However, collaborative filtering requires a large user preference dataset to has its best effect. Because I don’t have any user to start with. I need to find a dataset to test run my algorithm. It is hard to find a real dataset that represents user’s reading habits. Fortunately, I found Deli.ci.ous bookmarks dataset (2011) with more than eighteen hundred users (1800+) bookmarking more than sixty-nine thousand (69,000) articles. I considered user’s bookmark as indication that user likes this article. After I imported the dataset into my system, I can see collaborative filtering algorithm [start working]([Demo Video](https://youtu.be/cxbzO0MGIZM).

## Technical Decisions and Considerations:
### Rails Web App vs Rich Client JavaScript App
- Rails Web App can be combined with the Rails API backend to reduce implementation footprint.
- However a Rich Client JavaScript app will have more responsive look and feel for users. Therefore we chose to use AngularJS to implement a rich client for improved UX.

### Recommendation Engine Considerations
- Recommendable: https://github.com/davidcelis/recommendable
  - Algorithms: Jaccardian similarity of users preferences
  - Implementation: Ruby
  - **Can efficiently update recommendation after each new user input**
- Surprise: http://surpriselib.com/
  - Algorithms: Matrix factorization algorithms: e.g. SVD
  - Implementation: Python
  - **Updating recommendation requires rerun whole user preference data set**
- Conclusion:
  - **We would like to update user’s recommendation immediately after user’s preference feedback, therefore recommendable is a better choice here.**

### Crawler Considerations
- Current crawler is a single machine, multi-threaded implementation.
- We can easily achieve ~ 10 pages per second crawling speeding on development laptop.
- This is good enough for our demo data.

### Database Considerations
- Our demo data only have ~ 100 thousand articles and we only store ~ 1 KB actual data for each article.
- Our demo data have ~ 2000 users.
- Given that this is not a production website, expected query per second is very low.
- PostgreSQL is perfectly capable of supporting such data size and query volume.
- User preference data is stored in Redis. Redis is memory-based database. We only store the article ID for articles that user has liked/disliked. Therefore, the memory consumption for a ~ 2000 user preference database is also small for the demo.
- If we need to productionize this design. We have to use more scalable database for the article data and think of a more scalable scheme for storing user preference data.

## Future Improvements:
- Better Content-based recommendation
  - Topic modeling
  - Deep learning for understanding article content
  - User intent prediction through machine learning
    - What user’s current state based on searching terms and behaviors
- Better User preference signal
  - Click events
  - Reading time
- Add proper authentication
- Better API server
  - Add Load balancer
- Better crawler
  - More content to chose from
  - Crawl content that users might like first
  - Use message queue for scalable and reliable distribution of crawling task
- Better storage backend
  - More scalable database solution
