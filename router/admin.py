from flask import render_template, Blueprint, request, session, url_for, redirect, flash, current_app
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
import os

vista_admin = Blueprint('route_admin', __name__, template_folder='../templates')

# Las configuraciones deben estar en app.py, no aquí
mysql = MySQL()

#----------INICIO DE SESION-------------
@vista_admin.route('/login')
def login_page():
    return render_template("login.html")

@vista_admin.route('/accion-login', methods=['GET', 'POST'])
def validar_inicio_sesion():
    if request.method == 'POST' and 'userName' in request.form and 'contra' in request.form:
        usuario = request.form['userName']
        contraseña = request.form['contra']

        cur = mysql.connection.cursor()
        cur.execute('SELECT * FROM usuario WHERE nameUser = %s', (usuario,))
        user = cur.fetchone()

        if user and check_password_hash(user['contraseña'], contraseña):
            session['logueado'] = True
            session['userName'] = user['nameUser']
            session['id_rol'] = user['permisos']

            if session['id_rol']==1:
                return render_template("index.html", mensaje = "Inicio de session correctamente")
            elif session['id_rol']==2:
                return redirect(url_for('route_admin.admin_page'))
        else:
            return render_template("login.html", mensaje = "Huvo un problema con el inicio de session, por favor verifica si la informacion ingresada es correcta")
        cur.close()

#---------------CREAR USUARIO------------------------------
@vista_admin.route('/crear_usuario')
def crear_usuario():
    return render_template('create_user.html')

@vista_admin.route('/sign-up', methods=["GET", "POST"])
def sign_up():
    nombre_user = request.form['txtNombres']
    apellido_user = request.form['txtApellidos']
    userName = request.form['txtUserName']
    correo_user = request.form['txtCorreo']
    direccion_user = request.form['txtDireccion']
    telefono_user = request.form['numTelefono']
    contraseña_user = request.form['txtPassword']

    contraseña_hash = generate_password_hash(contraseña_user)

    cur = mysql.connection.cursor()

    cur.execute("SELECT * FROM usuario WHERE correo = %s", [correo_user])
    correo_existe = cur.fetchone()
    cur.execute("SELECT * FROM usuario WHERE nameUser = %s", [userName])
    usuario_existe = cur.fetchone()

    if correo_existe:
        flash('El correo ya está registrado. Por favor, use otro correo.')
    elif usuario_existe:
        flash('El nombre de usuario ya está en uso. Por favor, elija otro nombre de usuario.')
    else:
        cur.execute("INSERT INTO usuario (nombres, apellidos, nameUser, correo, permisos, direccion, numero_tel, contraseña) VALUES (%s, %s, %s, %s, '1', %s, %s, %s)",
            (nombre_user, apellido_user, userName, correo_user, direccion_user, telefono_user, contraseña_hash))
        mysql.connection.commit()
        flash('Usuario registrado con éxito')
        return redirect(url_for('route_admin.main_page'))
        cur.close()

    cur.close()
    return render_template('create_user.html')


#-------------RENDERIZAR PLANTILLAS NOMAS DE USUARIOS----------------------------
@vista_admin.route('/')
def main_page():
    return render_template("index.html")

@vista_admin.route('/acerca_de')
def acerca_de():
    return render_template("about.html")

@vista_admin.route('/reservaciones' , methods = ['GET'])
def reservaciones_page():
    if 'logueado' in session:
        return render_template("reservaciones.html")
    else:
        return render_template('login.html', mensaje2 = "Primero inicia session para acceder a esa pagina")

@vista_admin.route('/menu', methods = ['GET'])
def menu_page():
    if 'logueado' in session:
        cur = mysql.connection.cursor()
        cur.execute("SELECT nombre, descripcion, imagen, precio FROM menu")
        productos = cur.fetchall()
        cur.close()
        return render_template("menu.html", productos=productos)
    else:
        return render_template('login.html', mensaje2 = "Primero inicia session para acceder a esa pagina")

#-------------RENDERIZAR PLANTILLAS NOMAS DE ADMINISTRADOR----------------------------
@vista_admin.route('/admin_area', methods = ["GET", "POST"])
def admin_page():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM pedido")
    pedido = cur.fetchall()
    cur.close() 
    return render_template("administracion/administrador_empleado.html", pedido=pedido)

@vista_admin.route('/add_products')
def add_product():
    return render_template("administracion/add_product.html")

@vista_admin.route('/agregar', methods = ['POST', 'GET'])
def agregar():
    nombreProducto = request.form['txtName']
    descripcion = request.form['txtDescription']
    precio_producto = request.form['precioProducto']

    if 'foto' not in request.files:
            flash('No se ha seleccionado un archivo')
            return redirect(request.url)
        
    file = request.files['foto']
        
    if file.filename == '':
        flash('No se ha seleccionado un archivo')
        return redirect(request.url)
        
    if file:
        filename = secure_filename(file.filename)
        file_path = os.path.join(current_app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)

        relative_path = file_path.replace("static\\", "")
        relative_path = relative_path.replace("\\", "/")

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO menu (nombre, descripcion, imagen, precio) VALUES (%s, %s, %s, %s)",
                        (nombreProducto, descripcion, relative_path, precio_producto))
        mysql.connection.commit()
        cur.close()
        flash('Producto agregado con éxito')
        return redirect(url_for('route_admin.add_product'))
        
    else:
        flash('No tienes permiso para realizar esta acción')
        return redirect(url_for('route_admin.login_page'))