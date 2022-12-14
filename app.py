from flask import Flask, flash, abort, g, request, redirect, render_template, session
from werkzeug.security import check_password_hash, generate_password_hash
from datetime import datetime
import sqlite3, functools, math
from helpers import *


app = Flask('nexus1')
app.secret_key = 'dev'

@app.route('/')
def index():
    total = int(query_db('select count(*) from post', one=True)[0])
    page_param = request.args.get('page')
    page = int(page_param) if page_param else 1
    page_max = math.ceil(total/10)

    if page < 1:
        return redirect('/?page=1')
    elif page > page_max:
        return redirect('/?page=%d' % page_max)
    else:
        session['total'] = total
        session['page'] = page

    start = 10 * (page - 1)
    if request.args.get('start'):
        start = int(request.args.get('start'))
    
    query = "SELECT * from post p, user u where p.user = u.user_id order by p.date desc limit ?, ?"
    return render_template('index.html', posts=query_db(query, (str(start), str(start+10))))

@app.route('/signup', methods=('GET', 'POST'))
def signup():
    con = get_db()
    cur = con.cursor()

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        error = None

        if not username:
            error = 'Username is required.'
        elif not password:
            error = 'Password is required.'
                    
        if error is None:
            try:
                cur.execute(
                    "INSERT INTO user (username, password, created_on, active) VALUES (?, ?, ?, ?)",
                    (username, generate_password_hash(password), datetime.now(), True)
                )
                con.commit()
            except sqlite3.IntegrityError:
                error = f"用户 {username} 已注册"
            else:
                flash("注册成功！", 'ok')
                return redirect('/login')

        flash(error)

    return render_template('signup.html')

@app.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        # should validate non-empty username and password

        if username == 'admin':
            return redirect('/admin')

        query = "SELECT user_id, password, active from user where username = ?"
        try:
            uid, pwhash, active = query_db(query, (username,), True)
        except TypeError:
            flash('用户名或密码错误')
        else:
            if not active:
                flash('用户%s已删除' % username)
            elif check_password_hash(pwhash, password):
                session.clear()
                session['uid'] = uid
                session['username'] = username
                # return redirect(f'/user/{uid}')
                return redirect('/')
            else:
                flash('用户名或密码错误')   

    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')
    
@app.route('/admin', methods=('GET', 'POST'))
def admin():
    if session.get('admin'):
        return list_users()

    if request.method == 'POST':
        username = 'admin'
        password = request.form['password']

        query = "SELECT user_id, password from user where username = ?"
        try:
            uid, pwhash = query_db(query, (username,), True)
        except TypeError:
            if password == 'admin':
                session.clear()
                session['admin'] = True
            else:
                flash('密码错误')
        else:
            if check_password_hash(pwhash, password):
                session.clear()
                session['admin'] = True
            else:
                flash('密码错误')
        return redirect('/admin')
            
    return render_template('login_admin.html')

@app.route('/user/<uid>')
# @login_required
def user(uid):
    if int(uid) != session.get('uid') and not session.get('admin'):
        abort(403)
    
    res, ok = get_name_from_id(uid)
    if not ok:
        return res
    else:
        username = res

    total = int(query_db('select count(*) from post p, user u where p.user = u.user_id\
                            and p.user = ?', (uid,), one=True)[0])
    page_param = request.args.get('page')
    page = int(page_param) if page_param else 1
    page_max = math.ceil(total/10)
    
    if page < 1:
        return redirect('/user/%s?page=1' % uid)
    elif page > page_max:
        return redirect('/user/%s?page=%d' % (uid, page_max))
    else:
        session['total'] = total
        session['page'] = page

    start = 10 * (page - 1)
    if request.args.get('start'):
        start = int(request.args.get('start'))

    query = "SELECT * from post p, user u where p.user = u.user_id and p.user = ?\
                order by p.date desc limit ?, ?"
    return render_template('user.html', 
                            posts=query_db(query, (uid, str(start), str(start+10))), 
                            uid=uid, 
                            username=username)

@app.route('/user/<uid>/update', methods=('post', 'get'))
def user_update(uid):
    if int(uid) != session.get('uid') and not session.get('admin'):
        abort(403)

    res, ok = get_name_from_id(uid)
    if not ok:
        return res
    else:
        username = res

    if request.method == 'POST':
        password = request.form['password']
        write_db("UPDATE user SET password = ?, updated_on = ? where user.user_id = ?",
                    (generate_password_hash(password), datetime.now(), uid))
        flash('用户%s信息更新成功' % username, 'ok')
        return redirect('/login')

    return render_template('change_password.html', uid=uid, username=username)

@app.route('/user/<uid>/delete', methods=('POST',))
def user_delete(uid):
    if int(uid) != session.get('uid') and not session.get('admin'):
        abort(403)

    res, ok = get_name_from_id(uid)
    if not ok:
        return res
    else:
        username = res

    write_db("UPDATE user SET active = ?, updated_on = ? where user.user_id = ?",
                (False, datetime.now(), uid))
    flash('用户%s删除成功' % username, 'ok')
    return redirect('/login')

@app.route('/post/new', methods=('GET', 'POST'))
def post():
    con = get_db()
    cur = con.cursor()

    if request.method == 'POST':
        title = request.form['title'].strip(' \n\r\t')
        text = request.form['text'].strip(' \n\r\t')
        if not title:
            flash("标题不能为空")
        else:
            cur.execute(
                "INSERT INTO post (user, title, text, date) VALUES (?, ?, ?, ?)",
                (session.get('uid'), title, text, datetime.now())
            )
            con.commit()
            return redirect('/')

    return render_template('post.html')

@app.route('/post/delete', methods=['post'])
def post_delete():
    pid = request.form['pid']
    write_db("DELETE from post where post.post_id = ?", pid)
    return redirect('/')

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()