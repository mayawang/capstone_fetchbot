import scrapy

from pagecrawler.items import PagecrawlerItem

class PageSpider(scrapy.Spider):
    name = "pagespider"
    # allowed_domains = ["wired.com"]
    start_urls = [
        "https://www.wired.com/2017/01/microsofts-old-school-database-surprise-software-hit-year/",
        "https://www.wired.com/2017/01/deep-within-mountain-physicists-race-unearth-dark-matter/"
    ]

    def parse(self, response):
        item = PagecrawlerItem()
        item['link'] = response.url
        item['title'] = response.xpath('//title/text()').extract()
        item['desc'] = response.xpath('//meta[@name="description"]/@content').extract()
        item['keywords'] = response.xpath('//meta[@name="news_keywords"]/@content').extract()
        item['text'] = response.xpath('//body//p//text()').extract()
        yield item
