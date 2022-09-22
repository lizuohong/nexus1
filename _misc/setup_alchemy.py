from datetime import datetime
from sqlalchemy import create_engine, MetaData,\
        DateTime, Table, Column, Integer, String, Text

engine = create_engine('sqlite:///nexus1.db')
conn = engine.connect()
metadata = MetaData()

def getTable(table):
    return Table(table, metadata, autoload_with=engine)

