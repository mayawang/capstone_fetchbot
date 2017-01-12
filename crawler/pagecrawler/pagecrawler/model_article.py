from peewee import *

db = SqliteDatabase('articles.db')

class Article(Model):
    title = CharField()
    link = CharField()
    summary = CharField()
    keywords = CharField()
    text = CharField()

    class Meta:
        database = db

if __name__ == "__main__":
    try:
        Article.create_table()
    except OperationalError:
        print "Article table already exists!"
