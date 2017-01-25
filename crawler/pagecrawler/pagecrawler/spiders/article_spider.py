import scrapy
from pagecrawler.items import ArticlecrawlerItem
from pagecrawler.model_article import Articles

class ArticleSpider(scrapy.Spider):
    name = "articlespider"

    counter = 0
    written_counter = 0
    crawled_urls = {}

    def start_requests(self):
        filename = "delicious_article_dataset.dat"

        row_number = 0
        with open(filename, 'r') as f:
            for row in f:

                #     url_count -= 1
                #     if url_count <= 0:
                #        break

                fields = row.split("\t")
                url = fields[3]
                id = fields[0]
                if not url.startswith("http"):
                    continue

                row_number += 1

                yield scrapy.Request(url, meta={'id': id}, callback=self.parse)

    def parse(self, response):
        return self.parse_article(response)

    def parse_article(self, response):
        article_original_id = int(response.meta['id'])
        self.log("==========Scraping:========= " + response.url + " original id " + str(article_original_id))

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

        title = item['title'][0].strip()
        if len(title) == 0:
            return

        link = response.url.lower()

        if link in ArticleSpider.crawled_urls:
            return
        else:
            ArticleSpider.crawled_urls[link] = True


        if len(item['summary']) == 0:
            return

        summary = item['summary'][0].rstrip('\r\n').strip()
        if len(summary) == 0:
            return

        keywords = ""
        if len(item['keywords']) > 0:
            keywords = ', '.join(item['keywords'])

        if len(item['text']) == 0:
            return

        text = ' '.join(item['text'])
        text = text.strip()
        if len(text) < 10:
            return

        print "createing article"
        ArticleSpider.written_counter += 1
        article = Articles.create(id = article_original_id, title=title, link=link, summary=summary, keywords=keywords, text=text)
        print "########################### " + str(ArticleSpider.counter) + " written " + str(ArticleSpider.written_counter) +  "  #################################"
        # yield item
