## Target Usage Scenario:
- User Profile:
  - 20-50yrs old.
  - High school above education.
  - English fluency(only related to mvp content).
  - Occupation: students and office professionals.
- User Habits:
  - Read for fun
    - Extreme long term topic: AI, Sci-Fi author etc.
    - Mid term: election updates etc.
    - Short term hot topics: Stars, movies, news around one specific topic.
  - Search for long term personal/career/business growth or needs
    - Job search
    - Background check/due diligence
    - Curing cancer
- Possible Usage Time:
  - Commute (on bus or train)
  - Before bed
  - Coffee time
  - Wait time
  - Bathroom solitude..or any solitude
- Cons: compare to podcast/video channeling, can hardly do it when doing sports. Actually if read is successful, can expand it to audio/video.

## User Stories:

### User Story 1: (User uses Fetchbot for the very first time)
1. User open Fetchbot app
2. User search for a keyword
3. Fetchbot created a channel based on the keyword

### User Story 2: (User is bored and wants to read content for fun)

1. Assume user has free time to read.
2. User open Fetchbot.
3. Fetchbot shows mixed contents from all channels.
4. User can select a particular channel.
5. If User is not interested in the current channel or mixed content, user can switch to another channel.
6. User can create or delete a channel.

### User Story 3: (User is reading a channel)
1. Assume user is already in FetchBot app.
2. Fetchbot shows mixed contents from all channels.
3. Inherit User Story 1 here.
4. User can rate like/dislike for the articles in current channel.
5. User can also skip the content without rating it.
6. The like/dislike data will be used to generate new content in current channel.
7. Skip the content is the only way to get rid of existing content and get new content.
8. Skipped content will never appear again in this channel.
9. The same content can still appear in another channel.
10. When user is in mixed channel mode, rates data should not be attributed to specific channel(should be attributed differently than channel mode) - mock data for now anyway.

### User Story 4: (User Found Interesting Article and Want to Follow It for Long Term)

- Maybe just a "Nice to Have" feature to be added after capstone and before graduation

1. Assume User is on Desktop, looking at article in Chrome
2. User is intersted in article at http://example.org/article1.html
3. User want to ask FetchBot to keep providing background info and long term monitoring on this topic.
4. User click on FetchBot (or its Chrome Extension) button
5. FetchBot Web UI will be opened on a new Chrome Tab
6. User will see FetchBot’s “Add New channel” page
7. “Add New channel” page will be pre-populated with article’s Topic (...), Author (...) and Source (example.org)
8. User will also see example content that will be generated given this “channel” settings
9. User can add channel as-is or make modification to “channel” settings to refine it
10. Once user added this channel, FetchBot will keep monitoring it like other channels
