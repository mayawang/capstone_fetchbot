# Fetchbot: “The Pandora for readers”

## Problem Statement:

Fetchbot is a personalized content stream that fetches articles you'll love on the internet and continually evolves with your tastes.

You can train your Fetchbot by marking the article as “like”, “dislike”(by buttons), or “indifferent”(by an action: skip/swipe). The more feedback an user feeds to Fetchbot, the better results Fetchbot can gives back.

## Feature Set:
1. Useable UI:
  -  user preference gathering
  -  login
  -  content display
2. User Content Stream Service Backend API for frontend
3. Directable Crawler
4. Data processing pipeline
5. Algorithm and first implementation for content channel generation

## Tech Stack:
- Frontend:
  - Web UI: [Angular2](https://angular.io/) + [TypeScript](https://www.typescriptlang.org/)
  - User Authentication: [OAuth](https://oauth.net/)
- Backend:
  - User Content Stream Service API: [Ruby on Rails](http://rubyonrails.org/)
  - User Preference Content Topic and Knowledge Database: [MySQL](https://www.mysql.com/) or [PostgreSQL](https://www.postgresql.org/)
  - Next Content Prediction Crawler: Python [Scrapy](https://scrapy.org/)
