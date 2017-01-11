import scrapy
from pagecrawler import documents
from pagecrawler.items import PagecrawlerItem

class PageSpider(scrapy.Spider):
    name = "pagespider"
    # allowed_domains = ["wired.com"]
    start_urls = [
        "https://www.wired.com/2017/01/microsofts-old-school-database-surprise-software-hit-year/",
        "https://www.wired.com/2017/01/deep-within-mountain-physicists-race-unearth-dark-matter/"
    ]

    def parse(self, response):
        items = []
        return self.parse_page(response)

    def parse_page(self, response):

        self.log("==========Scraping:========= " + response.url)

        # present_depth = 0
        # if 'present_depth' in response.meta:
        #     present_depth = response.meta['present_depth']
        #
        # self.log("==========RESPONSE:present_depth=========")
        # self.log(present_depth)

        item = PagecrawlerItem()

        item['link'] = response.url
        item['title'] = response.xpath('//title/text()').extract()
        item['summary'] = response.xpath('//meta[@name="description"]/@content').extract()
        item['keywords'] = response.xpath('//meta[@name="news_keywords"]/@content').extract()
        item['text'] = response.xpath('//body//p//text()').extract()
        self.log("=========filled in item for:========" + response.url)

        counter = 0
        for valid_url in self.find_url(response):
            request = scrapy.Request(valid_url, callback=self.parse_page)
            counter += 1
            # request.meta['present_depth']
            # self.log("=========present_depth:==========")
            # self.log(request.meta['present_depth'])
            # self.log("=========depth_limit:============")
            # self.log(request.meta['depth_limit'])
            # request.meta['present_depth'] += 1
            # if request.meta['present_depth'] <= request.meta['depth_limit']:
            if counter < 3:
                yield request

        yield item

    def find_url(self, response):

        all_urls = []
        all_urls.append(response.xpath('//a/@href').extract())
        # next_page_urls.append(response.xpath('//div[@class="story-more"]/a/@href').extract())
        # next_page_urls.append(response.xpath('//div[@class="related-combined-coverage"]/a/@href').extract())
        all_urls = [item for sublist in all_urls for item in sublist]

        self.log("==========all urls:=========")
        self.log(all_urls)

        valid_urls = []
        # exclude external links
        for url in all_urls:
            if url.startswith('https') and '/2017/' in url:
                valid_urls.append(url)

        self.log("================valid urls:===========")
        self.log(valid_urls)
        return valid_urls
        # self.log("next_page_urls" + '[%s]' % ', '.join(map(str, next_page_urls)))
        #
        # if len(next_page_urls) > 0:
        #     for next_page_url in next_page_urls:
        #         request = scrapy.Request(next_page_url, self.parse_page)
        #         # request.meta['start'] += 1
        #         self.log("next page url " + next_page_url)
        #         yield request
