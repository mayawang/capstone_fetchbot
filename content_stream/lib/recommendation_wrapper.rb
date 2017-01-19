require 'httparty'

class RecommendationApiWrapper
  def self.get_recommendation(query)
    items = []
    if "asimov laws of robotics".include?(query)
      item_1 = {
        id: '1',
        title: "Do We Need Asimov's Laws - MIT Technology Review",
        link: 'https://www.technologyreview.com/s/527336/do-we-need-asimovs-laws/',
        summary: 'As robots become ever more present in daily life, the question of how to control their behaviour naturally arises. Does Asimov have the answer?',
        keywords: 'robotics, AI, Sci-Fi, Asimov',
        text: ''
      }

      item_2 = {
        id: '2',
        title: "xkcd: The Three Laws of Robotics",
        link: 'https://xkcd.com/1613/',
        summary: 'In ordering #5, self-driving cars will happily drive you around, but if you tell them to drive to a car dealership, they just lock the doors and politely ask how long humans take to starve to death.',
        keywords: 'robotics, comics, Asimov, xkcd',
        text: ''
      }

      item_3 = {
        id: '3',
        title: "The Myth of the Three Laws of Robotics - Why We Can't Control Intelligence",
        link: 'https://singularityhub.com/2011/05/10/the-myth-of-the-three-laws-of-robotics-why-we-cant-control-intelligence/',
        summary: 'From 1929 until the mid 90s, the author created many lasting tropes and philosophies that would define scifi for generations, but perhaps his most famous creation was the Three Laws of Robotics.',
        keywords: 'future, Isaac Asimov, machine intelligence, opinion, Singularity, Three Laws of Robotics',
        text: ''
      }

      item_4 = {
        id: '4',
        title: "The dawn of artificial intelligence",
        link: 'http://www.economist.com/news/leaders/21650543-powerful-computers-will-reshape-humanitys-future-how-ensure-promise-outweighs',
        summary: "Powerful computers will reshape humanity's future. How to ensure the promise outweighs the perils",
        keywords: 'future, Clever computers, machine intelligence, opinion',
        text: ''
      }

      item_5 = {
        id: '5',
        title: "Paul Allen: The Singularity Isn't Near",
        link: 'https://www.technologyreview.com/s/425733/paul-allen-the-singularity-isnt-near/',
        summary: 'The Singularity Summit approaches this weekend in New York. But the Microsoft cofounder and a colleague say the singularity itself is a long way off.',
        keywords: 'future, robotics,machine intelligence,opinion',
        text: ''
      }

      items << item_1
      items << item_2
      items << item_3
      items << item_4
      items << item_5

      return items
    end
  end

  # like/dislike and clicked with user saved both in rails database and recommendation database
  # like => 1
  # dislike => 0

  def self.clicked(content_id, user_id)

  end

  def self.like(content_id, user_id)
    item_6 = {
      id: '6',
      title: "What Better Way for the Marines to Prepare for Future Wars Than With Sci-Fi?",
      link: 'https://www.wired.com/2017/01/better-way-marines-prepare-future-wars-sci-fi/',
      summary: 'The Singularity Summit approaches this weekend in New York. But the Microsoft cofounder and a colleague say the singularity itself is a long way off.',
      keywords: 'marines, Military, Sci-fi, Science Fiction',
      text: ''
    }

    return [item_6]

  end

  def self.dislike(content_id, user_id)
      item_7 = {
      id: '7',
      title: "Oscar Wilde and Walt Whitman Once Spent an Afternoon Together. Here's What Happened",
      link: 'https://newrepublic.com/article/119885/when-walt-whitman-met-oscar-wilde',
      summary: 'I come as a poet to call upon a poet, Wilde said, when Whitman opened his door.',
      keywords: 'History,Culture,Books,Oscar Wilde,Walt Whitman',
      text: ''
    }

    return [item_7]
  end


end
