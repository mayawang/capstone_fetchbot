from peewee import *
import datetime

# db = SqliteDatabase('test_fetchbot_articles.db')
db = SqliteDatabase('/Users/mengyao/capstone_fetchbot/content_stream/db/development.sqlite3')

class Articles(Model):
    title = CharField()
    link = CharField()
    summary = CharField()
    keywords = CharField()
    text = TextField()

    created_at = DateTimeField(default=datetime.datetime.now)
    updated_at = DateTimeField(default=datetime.datetime.now)

    class Meta:
        database = db
        db_table = "articles_raw"


class Articles2(Model):
    title = CharField()
    link = CharField()
    summary = CharField()
    keywords = CharField()
    text = CharField()
    created_at = DateTimeField(default=datetime.datetime.now)
    updated_at = DateTimeField(default=datetime.datetime.now)

    class Meta:
        database = db
        db_table = "articles"

if __name__ == "__main__":
    try:
        Articles.create_table()
    except OperationalError:
        print "Article table already exists!"
