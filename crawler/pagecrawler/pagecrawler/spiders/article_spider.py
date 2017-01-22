import scrapy
from pagecrawler.items import ArticlecrawlerItem
from pagecrawler.model_article import Articles

class ArticleSpider(scrapy.Spider):
    name = "articlespider"
    filename = "delicious_article_dataset.dat"
    # load url in bookmarks from dataset
    start_urls = []
    url_count = 10

    with open(filename, 'r') as f:
        for row in f:
            # url_count -= 1
            #if url_count <= 0:
            #    break

            fields = row.split("\t")
            if not fields[3].startswith("http"):
                continue

            start_urls.append(fields[3])
            print "field:" + fields[3]

    print start_urls

    def parse(self, response):
        items = []
        return self.parse_article(response)

    def parse_article(self, response):

        self.log("==========Scraping:========= " + response.url)
        item = ArticlecrawlerItem()

        item['link'] = response.url
        item['title'] = response.xpath('//title/text()').extract()
        item['summary'] = response.xpath('//meta[@name="description"]/@content').extract()
        item['keywords'] = response.xpath('//meta[@name="news_keywords"]/@content').extract()
        item['text'] = response.xpath('//body//p//text()').extract()
        self.log("=========filled in item for:========" + response.url)

        # e.g. "indexing function", link = item.[]('link')
        title = item['title']
        link = item['link']
        summary = item['summary']
        keywords = item['keywords']
        text = item['text']

        # TODO check if this article already saved
        article = Articles.create(title=title, link=link, summary=summary, keywords=keywords, text=text)

        yield item
