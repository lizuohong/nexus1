from flask import Flask, g, session, redirect, render_template
import sqlite3

DATABASE = 'db/nexus1.db'

app = Flask('dummy')

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    db.row_factory = sqlite3.Row
    return db

def get_schema(table):
    cols = []
    cur = get_db().execute('SELECT * from %s' % table)
    for col in cur.description:
        cols.append(col[0])
    return cols
    
def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv

def write_db(query, args=()):
    con = get_db()
    cur = con.cursor()
    cur.execute(query, args)
    con.commit()
    # 是否也需要cur.close()？

def list_users():
    query = "SELECT * from user"
    users = query_db(query)
    schema = get_schema('user')
    return render_template('admin.html', th=schema, users=users, ncol=len(schema))

def get_name_from_id(uid):
    # get username from uid as a string
    res = query_db("SELECT * from user where user_id = ?", (uid,), True)
    if not res or not res['active']:
        return "该用户不存在或已删除", False
    else:
        return res['username'], True

def login_required(view):
    #@functools.wraps(view)
    def wrapped_view(**kwargs):
        # kw-only args might have problem with, e.g. user(id)?
        if session.get('uid') is None and not session.get('admin'):
            return redirect('/login')

        return view(**kwargs)

    return wrapped_view