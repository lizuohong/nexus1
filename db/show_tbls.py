# show table (and other top-level obj.) definitions of a single sqlite db

import sys, sqlite3

#print(sys.argv[0])

def list(db):
    con = sqlite3.connect(db)
    cur = con.cursor()
    for row in cur.execute('select * from sqlite_master'):
        print(row[4])

if __name__ == '__main__':
    list(sys.argv[1])
