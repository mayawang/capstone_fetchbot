# Fetchbot: “The Pandora for readers”

## Problem Statement:

Fetchbot is a personalized content stream that fetches articles you'll love on the internet and continually evolves with your tastes.

You can train your Fetchbot by marking the article as “like” and “dislike”. The more feedback an user feeds to Fetchbot, the better results Fetchbot can gives back.

## Feature Set:
1. Web UI:
  -  User Authentication
  -  content display
  -  user preference gathering
2. User Content Stream Service Backend API
3. Next Content Prediction Directable Crawler
4. Data processing pipeline
5. Algorithm and first implementation for content recommendation generation

## Tech Stack:
- Frontend:
  - Web UI: [Angular2](https://angular.io/) + [TypeScript](https://www.typescriptlang.org/)
- Backend:
  - User Content Stream Service API: [Ruby on Rails](http://rubyonrails.org/)
  - User Preference Database: [Redis](https://redis.io/)
  - Content Recommendation: [Recommendable](https://github.com/davidcelis/recommendable)
  - Crawler: Python [Scrapy](https://scrapy.org/)
  - Scrapted Content Database: [PostgresSQL](https://www.postgresql.org/)
