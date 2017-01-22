import scrapy
from pagecrawler.items import ArticlecrawlerItem

class ArticleSpider(scrapy.Spider):
    name = "articlespider"
    filename = "delicious_article_dataset.dat"
    # load url in bookmarks from dataset
    # def __init__(self, filename=None):
    start_urls = []
    url_count = 10
    if filename:
        with open(filename, 'r') as f:
            for row in f:
                url_count -= 1
                if url_count <= 0:
                    break

                fields = row.split("\t")
                if fields[3].startswith("http"):
                    start_urls.append(fields[3])
                    print "field:" + fields[3]

        print start_urls


    def parse(self, response):
        items = []
        return self.parse_article(response)

    def parse_page(self, response):

        self.log("==========Scraping:========= " + response.url)
        item = ArticlecrawlerItem()

        item['link'] = response.url
        item['title'] = response.xpath('//title/text()').extract()
        item['summary'] = response.xpath('//meta[@name="description"]/@content').extract()
        item['keywords'] = response.xpath('//meta[@name="news_keywords"]/@content').extract()
        item['text'] = response.xpath('//body//p//text()').extract()
        self.log("=========filled in item for:========" + response.url)

        yield item
