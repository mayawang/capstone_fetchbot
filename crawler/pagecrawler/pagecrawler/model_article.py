from peewee import *
import datetime

# db = SqliteDatabase('articles.db')
db = SqliteDatabase('/Users/mengyao/capstone_fetchbot/content_stream/db/development.sqlite3')

class Articles(Model):
    title = CharField()
    link = CharField()
    summary = CharField()
    keywords = CharField()
    text = CharField()
    created_at = DateTimeField(default=datetime.datetime.now)
    updated_at = DateTimeField(default=datetime.datetime.now)

    class Meta:
        database = db

if __name__ == "__main__":
    try:
        Articles.create_table()
    except OperationalError:
        print "Article table already exists!"
