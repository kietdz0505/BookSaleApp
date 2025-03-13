import json, os
from flask_login import current_user
from BookApp import app, db
from BookApp.models import Category, Product, Comment, User, Receipt, ReceiptDetail, UserRole
import hashlib
from sqlalchemy import func
from sqlalchemy.sql import extract

def read_json(path):
    with open(path, "r") as f:
        return json.load(f)


def load_categories():
    return Category.query.all()


def read_product(cate_id=None, kw=None, from_price=None, to_price=None, page=1):
    products = Product.query.filter(Product.active.__eq__(True))

    if cate_id:
        products = products.filter(Product.category_id.__eq__(cate_id))

    if kw:
        products = products.filter(Product.name.ilike(f"%{kw}%"))

    if from_price:
        products = products.filter(Product.price.__ge__(from_price))

    if to_price:
        products = products.filter(Product.price.__le__(to_price))

    products = products.order_by(Product.name.asc())

    page_size = app.config['PAGE_SIZE']
    start = (page - 1) * page_size
    end = start + page_size

    return products.slice(start, end).all()


def count_products():
    return Product.query.filter(Product.active.__eq__(True)).count()


def add_user(name, username, password, **kwargs):
    # Kiểm tra xem username đã tồn tại chưa
    existing_user = User.query.filter_by(username=username.strip()).first()
    if existing_user:
        return {"success": False, "error": "Tên người dùng đã tồn tại."}
    password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())
    user = User(name=name.strip(),
                username=username.strip(),
                password=password,
                email=kwargs.get('email'),
                avatar=kwargs.get('avatar'))

    db.session.add(user)
    db.session.commit()


def check_login(username, password, role=None):
    # Mã hóa mật khẩu người dùng với MD5
    hashed_password = hashlib.md5(password.strip().encode('utf-8')).hexdigest()

    # Truy vấn người dùng theo username và role nếu có
    user_query = User.query.filter_by(username=username.strip())

    if role:  # Nếu vai trò được cung cấp, thêm điều kiện lọc
        user_query = user_query.filter_by(user_role=role)

    user = user_query.first()  # Lấy người dùng đầu tiên từ kết quả truy vấn

    # Kiểm tra tài khoản có tồn tại không
    if not user:
        return {"success": False, "error": "Tài khoản không tồn tại! Vui lòng đăng ký trước khi đăng nhập!"}

    # Kiểm tra mật khẩu đã mã hóa
    if user.password != hashed_password:
        return {"success": False, "error": "Mật khẩu không đúng."}

    # Nếu thông tin chính xác
    return {"success": True, "user": user}


def get_user_by_id(user_id):
    return User.query.get(user_id)


def get_product_by_id(product_id):
    return Product.query.get(product_id)
    # products = read_json("data/products.json")
    # for p in products:
    #     if p['id'] == product_id:
    #         return p


def add_receipt(cart):
    if cart:
        receipt = Receipt(user=current_user)
        db.session.add(receipt)

        for c in cart.values():
            # Tạo chi tiết hóa đơn
            d = ReceiptDetail(
                receipt=receipt,
                product_id=c['id'],
                quantity=c['quantity'],
                unit_price=c['price']
            )
            db.session.add(d)

            # Giảm số lượng sản phẩm trong database
            product = Product.query.get(c['id'])
            if product:
                product.quantity -= c['quantity']

        db.session.commit()


def count_cart(cart):
    total_quantity, total_amount = 0, 0

    if cart:
        for c in cart.values():
            total_quantity += c['quantity']
            total_amount += c['quantity'] * c['price']

    return {
        'total_quantity': total_quantity,
        'total_amount': total_amount
    }


def category_stats():
    #
    # SELECT c.id, c.name, count(p.id)
    # FROM category c left outer join product p on c.id = p.category_id
    # group by c.id, c.name
    #

    # return Category.query.join(Product, Product.category_id.__eq__(Category.id)
    #                            .add_columns(func.count(Product.id))
    #                            .group_by(Category.id, Category.name).all())

    return (db.session.query(Category.id, Category.name,
                            func.count(Product.id))
            .join(Product, Category.id.__eq__(Product.category_id), isouter=True)
            .group_by(Category.id, Category.name).all())


def product_stats(kw=None, from_date=None, to_date=None):
    p = (db.session.query(
        Product.id,
        Product.name,
        func.sum(ReceiptDetail.quantity).label('total_quantity'),
        func.sum(ReceiptDetail.quantity * ReceiptDetail.unit_price).label('total_revenue'))
         .join(ReceiptDetail, ReceiptDetail.product_id == Product.id, isouter=True)
         .join(Receipt, Receipt.id == ReceiptDetail.receipt_id)
         .group_by(Product.id, Product.name))

    if kw:
        p = p.filter(Product.name.ilike(f"%{kw}%"))

    if from_date:
        p = p.filter(Receipt.created_date >= from_date)

    if to_date:
        p = p.filter(Receipt.created_date <= to_date)

    return p.all()


def product_month_stats(year):
    q = (db.session.query(extract('month',Receipt.created_date),
                            func.sum(ReceiptDetail.quantity*ReceiptDetail.unit_price))
         .join(ReceiptDetail, ReceiptDetail.receipt_id.__eq__(Receipt.id))
         .filter(extract('year', Receipt.created_date).__eq__(year)))

    return q.group_by(extract('month', Receipt.created_date)).all()

def add_comment(content, product_id):
    c = Comment(content=content, product_id = product_id, user=current_user)
    db.session.add(c)
    db.session.commit()

    return c

def get_comment(product_id, page=1):
    page_size = app.config['COMMENT_SIZE']
    start = (page - 1) * page_size
    return Comment.query.filter(Comment.product_id.__eq__(product_id)).order_by(-Comment.id).slice(start,start + page_size).all()


def count_comment(product_id):
    return Comment.query.filter(Comment.product_id.__eq__(product_id)).count()