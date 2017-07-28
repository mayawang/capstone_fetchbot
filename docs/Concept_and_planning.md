# Fetchbot: “The Pandora for readers”

## Problem Statement:

Fetchbot is a personalized content stream that fetches articles you'll love on the internet and continually evolves with your tastes.

You can train your Fetchbot by marking the article as “like”, “dislike”(by buttons), or “indifferent”(by an action: skip/swipe). The more feedback an user feeds to Fetchbot, the better results Fetchbot can gives back.

## Critical Path:
1. Useable UI: (1 week)
  -  user preference gathering
  -  login
  -  content display
2. User Content Stream Service API for frontend  (1-2 week)
3. Directable Crawler
4. Data processing pipeline (4-5 week includes step 3)
5. Algorithm and first implementation for content recommendation generation (4 week)

- **Capstone**: Step 1 - 3.
  - Web UI, Database and Crawler MVP implementation - Mock data for now
- **Before Graduation**: Step 4 - 5.
  - Actual implementation of content prediction generation
  - iOS Mobile UI(if time permits)

## Concept Diagrams:
- [Architecture Diagram & ERD Diagram & UI Draft](https://www.dropbox.com/s/l9opt2n00tmrkoy/Fetchbot%20architecture%20diagram.pdf?dl=0)

## Feature Set & Tech Stack:
- Frontend:
  - Web UI: [Angular2](https://angular.io/) + [TypeScript](https://www.typescriptlang.org/)
  - User Authentication: [OAuth](https://oauth.net/)
- Backend:
  - User Content Stream Service API: [Ruby on Rails](http://rubyonrails.org/)
  - User Preference Database: [MySQL](https://www.mysql.com/)
  - Content Recommendation: [Flask](http://flask.pocoo.org/) + [surprise]:(http://surpriselib.com/)
  - Crawler: Python [Scrapy](https://scrapy.org/) as Crawler and [ScrapyRT](https://github.com/scrapinghub/scrapyrt) as Crawler's HTTP API
  - Scrapted Content Database: [MySQL](https://www.mysql.com/)

## MVP structure:

- Web UI
- User Content Stream Service API:
  - Implement Model for:
    - User
      - User Name
      - Password hash
    - Content
        - Title
        - Summary
        - Link (future want to fit in clean template)
        - Topic_id (Should I take user input directly as a topic/or match it to certain topic?)
    - Topic
      - Title
    - channel
      - Topics  
- Provide API for:
  - GetNextContent from channel
  - Fill More Content to channel according to Topic
  - Query / Add / Remove topic in channel
- Next Content Prediction Crawler
  - Database and Crawler MVP implementation (Ruby/API connect)

## Learn More:
- [User Stories/UI Specifications/Content Recommendation Algorithm](https://docs.google.com/document/d/1J1pocwXkKDzZwVS_ZiXdaghuYcgFfSkFei5TbseqJts/edit?usp=sharing)


## script:

- sign in and choose interested topic/rss?
- integrate with google/github/facebook account?
- select the like source? five or four example

- sign-in? query specify user1 in params[:q]
q=1, user=1

- open the main page
- type in search term "asimov laws of robotics"
- return 5 recommendation of articles
- namely:
1.Do We Need Asimov's Laws? https://www.technologyreview.com/s/527336/do-we-need-asimovs-laws/

2. The Three Laws of Robotics - xkcd
https://xkcd.com/1613/


3. The Myth of the Three Laws of Robotics – Why We Can’t Control Intelligence
https://singularityhub.com/2011/05/10/the-myth-of-the-three-laws-of-robotics-why-we-cant-control-intelligence/

4. The dawn of artificial intelligence "http://www.economist.com/news/leaders/21650543-powerful-computers-will-reshape-humanitys-future-how-ensure-promise-outweighs"

5. Paul Allen: The Singularity Isn't Near

https://www.technologyreview.com/s/425733/paul-allen-the-singularity-isnt-near/

- like an article, another similar new article will appear(article in same website or related topic)

- dislike an article, another new article will appear in complete different field:
namely:

1. Oscar Wilde and Walt Whitman Once Spent an Afternoon Together. Here's What Happened

https://newrepublic.com/article/119885/when-walt-whitman-met-oscar-wilde

- when feed in a link, it can return similar links

- copy an URL, link to crawler
