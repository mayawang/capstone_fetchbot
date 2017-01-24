import scrapy
from pagecrawler.items import ArticlecrawlerItem
from pagecrawler.model_article import Articles

class ArticleSpider(scrapy.Spider):
    name = "articlespider"
    filename = "delicious_article_dataset.dat"
    # load url in bookmarks from dataset
    start_urls = []
    crawled_urls = {}
    # url_count = 100
    counter = 0

    with open(filename, 'r') as f:
        for row in f:

        #     url_count -= 1
        #     if url_count <= 0:
        #        break

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

        ArticleSpider.counter += 1

        item['link'] = response.url
        item['title'] = response.xpath('//title/text()').extract()
        item['summary'] = response.xpath('//meta[@name="description"]/@content').extract()
        item['keywords'] = response.xpath('//meta[@name="news_keywords"]/@content').extract()
        item['text'] = response.xpath('//body//p//text()').extract()
        self.log("=========filled in item for:========" + response.url)

        # e.g. "indexing function", link = item.[]('link')
        if len(item['title']) == 0:
            return

        title = item['title'][0]
        link = response.url.lower()

        if link.startswith("https://www.youtube.com/"):
            return

        if link in ArticleSpider.crawled_urls:
            return
        else:
            ArticleSpider.crawled_urls[link] = True


        if len(item['summary']) == 0:
            return

        summary = item['summary'][0].rstrip('\r\n')
        if len(summary) == 0:
            return

        keywords = ""
        if len(item['keywords']) > 0:
            keywords = ', '.join(item['keywords'])

        if len(item['text']) == 0:
            return

        text = ' '.join(item['text'])
        if len(text) < 10:
            return

        print "createing article"
        article = Articles.create(title=title, link=link, summary=summary, keywords=keywords, text=text)
        print "#################################" + str(ArticleSpider.counter) + "/" + str(len(ArticleSpider.start_urls)) + "###########################"
        # yield item
