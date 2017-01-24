# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
from scrapy.exceptions import DropItem
# from goose import Goose
from pagecrawler.model_article import Articles

class SaveArticle(object):

    def process_item(self, item, spider):

        # e.g. "indexing function", link = item.[]('link')
        title = item['title']
        link = item['link']
        summary = item['summary']
        keywords = item['keywords']
        text = item['text']

        # article = Articles.create(title=title, link=link, summary=summary, keywords=keywords, text=text)

        return item
# class DuplicatesPipeline(object):
#
#     def __init__(self):
#         self.links_seen = set()
#
#     def process_item(self, item, spider):
#         if item['link'] in self.links_seen:
#             raise DropItem("Duplicate item found: %s" % item)
#         else:
#             self.links_seen.add(item['link'])
#             return item
#
# class DropSelfPostsPipeline(object):
#     def process_item(self, item, spider):
#         match = re.match("item\?id=[0-9]+", item['link'])
#         if match:
#             raise DropItem("Excluded self-post: " + item['link'])
#
#         return item
#
# class ExtractArticlePipeline(object):
#     def __init__(self):
#         self.goose = Goose()
#
#     def process_item(self, item, spider):
#         try:
#             article = self.goose.extract(url=item['link'])
#             item["text"] = article.cleaned_text
#
#         except IndexError:
#             raise DropItem("Failed to extract article text from: " + item['link'])
#
#         return item
