from flask import Flask,render_template,request, session, redirect, flash
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column,Integer,String

from datetime import datetime
import json
import os
from werkzeug.utils import secure_filename
import math


app = Flask(__name__)
app.secret_key='super-secret-key'




with open('config.json', 'r') as c:
    params = json.load(c)["params"]

app.config['UPLOAD_FOLDER'] = params['upload_path']

local_server=True
if (local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Contacts(db.Model):
    # sno,name,phone_num,msg,date,email
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(50), nullable=False)



class Posts(db.Model):

    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    slug = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(50), nullable=False)


@app.route("/")
def home():
    post = Posts.query.filter_by().all()
    last = math.ceil(len(post) / int(params['no_of_post']))
    page = request.args.get('page')
    if( not str(page).isnumeric()):
        page=1

    page = int(page)
    #lets suppose 3 post in 1 page than the range of post should be between 0:3 (page=1 =>> page-1*no_of_post:
    #next page should be 3 to 6
    post = post[(page-1)*int(params['no_of_post']):(page-1)*int(params['no_of_post'])+int(params['no_of_post'])]
    #if page==1 than 0:3, if page==2 than3:6


    if page==1:
        prev='#'
        next='/?page='+ str(page+1)
    elif page==last:
        prev='/?page='+ str(page-1)
        next='#'
    else:
        prev = '/?page=' + str(page - 1)
        next = '/?page=' + str(page + 1)


    return render_template("index.html",params=params, post=post, prev=prev, next=next)




@app.route("/edit/<string:sno>",methods=['GET','POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method=='POST':
            title=request.form.get('title')
            content=request.form.get('content')
            slug=request.form.get('slug')
            img_file=request.form.get('img_file')
            date = datetime.now()
            if sno=='0':
                post=Posts(title=title, content=content,img_file=img_file,slug=slug,date=date)
                db.session.add(post)
                db.session.commit()

            else:
                post=Posts.query.filter_by(sno=sno).first()
                post.title = title
                post.content = content
                post.slug = slug
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/post/'+post.slug)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template("edit.html", params=params,post=post,sno=sno)

@app.route("/delete/<string:sno>", methods=['GET','POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect("/dashboard")

@app.route("/uploader", methods=['GET','POST'])
def uploader():
    if 'user' in session and session['user']==params['admin_user']:
        if request.method=='POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "upload successfully"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect("/dashboard")

@app.route("/dashboard", methods = ['GET','POST'])
def dashboard():
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.all()
        return render_template("dashboard.html",params=params,post=post)
    if request.method == 'POST':
        username = request.form.get('uname')
        password = request.form.get('upass')
        if username == params["admin_user"] and password == params["admin_password"]:
            session['user'] = username
            post=Posts.query.all()
            flash("Welcome to Crazy Programmers admin panel", "success")
            return render_template("dashboard.html",params=params,post=post)

    return render_template("login.html",params=params)


@app.route("/about")
def about():

    return render_template("about.html",params=params)

@app.route("/contact",methods=['GET','POST'])
def contact():
    if (request.method=='POST'):
        name=request.form.get('name')
        phone_num=request.form.get('phone')
        msg=request.form.get('message')
        email=request.form.get('email')
        entry = Contacts(name=name,phone_num=phone_num,msg=msg,date=datetime.now(),email=email)
        db.session.add(entry)
        db.session.commit()
    return render_template("contact.html",params=params)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html",params=params, post=post)

app.run(debug=True)