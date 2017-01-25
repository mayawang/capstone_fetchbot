#!/bin/env python
# -*- coding: utf-8 -*-

from model_article import Articles, Articles2

filename = "delicious_article_dataset.dat"
# load url in bookmarks from dataset
url_to_id = {}
url_count = 10
total_url_count = 0
duplicated_url_count = 0

with open(filename, 'r') as f:
    for row in f:
        # url_count -= 1
        #if url_count <= 0:
        #    break

        fields = row.split("\t")
        url = fields[3]
        bookmark_id = fields[0]
        if not url.startswith("http"):
            continue

        url = url.lower()

        total_url_count += 1

        if url in url_to_id:
            duplicated_url_count += 1

        url_to_id[url] = bookmark_id

        print "url: " + url + " id: " + bookmark_id

        # start_urls.append(fields[3])
        # print "field:" + fields[3]

#Articles.select().where(Article.link == field[3])

# print url_to_id
print "total url " + str(total_url_count)
print "duplicated_url_count " + str(duplicated_url_count)

correctly_mapped_count = 0

for article in Articles.select():
    if article.link not in url_to_id:
        print "cannot map article " + str(article.id) + " url " + article.link.encode('utf8') + " title " + article.title.encode('utf8')
        continue

    new_id_str = url_to_id[article.link]
    new_id = int(new_id_str)

    if Articles2.select().where(Articles2.id == new_id).count() > 0:
        print "old article " + str(article.id) + " is duplicated"
        continue

    print "url " + article.link + " new_id_str " + new_id_str + " int " + str(new_id)
    Articles2.create(id = new_id, link = article.link, title = article.title, summary = article.summary, keywords = article.keywords, text = article.text)

    correctly_mapped_count += 1

print "correctly mapped " + str(correctly_mapped_count)
