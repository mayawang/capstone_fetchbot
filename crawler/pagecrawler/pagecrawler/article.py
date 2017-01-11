from peewee import *

db = SqliteDatabase('summary.db')

class Article(Model):
    title = CharField()
    link = CharField()
    summary = CharField()
    keywords = CharField()
    text = CharField()

    class Meta:
        database = db
