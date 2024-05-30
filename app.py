from flask import Flask, redirect, url_for, render_template
from flask_mysqldb import MySQL
from werkzeug.utils import secure_filename
import os

app = Flask(__name__)

app.config['SECRET_KEY'] = '12345678'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'cafeteriadb'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
app.config['UPLOAD_FOLDER'] = os.path.join('static', 'img', 'imgProductos')
app.config['MAX_CONTENT_PATH'] = 16 * 1024 * 1024
# app.config['MYSQL_CURSORCLASS'] = 'DictCursor' # Opcional

mysql = MySQL(app)

from router.admin import vista_admin

app.register_blueprint(vista_admin)