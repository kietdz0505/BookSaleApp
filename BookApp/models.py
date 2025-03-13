
from sqlalchemy import Column, Boolean, Enum, ForeignKey, Integer, String, Float, DateTime, Text
from sqlalchemy.orm import relationship, backref
from BookApp import db, app
from datetime import datetime
from flask_login import UserMixin
from enum import Enum as UserEnum

class BaseModel(db.Model):
    __abstract__ = True
    id = Column(Integer, primary_key=True, autoincrement=True)

class UserRole(UserEnum):
    ADMIN = 1
    USER = 2
    NHAN_VIEN = 3

class User(BaseModel, UserMixin):
    name = Column(String(50), nullable=False)
    username = Column(String(50), nullable=False, unique=True)
    password = Column(String(50), nullable=False)
    avatar = Column(String(100))
    email = Column(String(50))
    active = Column(Boolean, default=True)
    joined_date = Column(DateTime, default=datetime.now())
    user_role = Column(Enum(UserRole), default=UserRole.USER)
    receipts = relationship('Receipt', backref='user', lazy=True)
    comments = relationship('Comment', backref="user", lazy=True)
    def __str__(self):
        return self.name

class Author(BaseModel):

    first_name = Column(String(15), nullable=False)
    last_name = Column(String(50), nullable=False)
    products = relationship('Product', backref='author', lazy=True)

    def __str__(self):
        return self.first_name + ' '+ self.last_name

class Publisher(BaseModel):

    name = Column(String(50), nullable=False, unique=True)
    products = relationship('Product', backref='publisher', lazy=True)

    def __str__(self):
        return self.name

class Category(BaseModel):
    name = Column(String(50), nullable=False, unique=True)
    products = relationship('Product', backref='category', lazy=True)

    def __str__(self):
        return self.name



class Product(BaseModel):

    name = Column(Text, nullable=False)
    description = Column(Text, nullable=True)
    price = Column(Float, default=0)
    active = Column(Boolean, default=True)
    image = Column(Text, nullable=True)
    category_id = Column(Integer, ForeignKey(Category.id), nullable=False)
    created_date = Column(DateTime, default=datetime.now())
    receipt_detail = relationship('ReceiptDetail', backref='product', lazy=True)
    author_id = Column(Integer, ForeignKey(Author.id), nullable=False)
    publisher_id = Column(Integer, ForeignKey(Publisher.id), nullable=False)
    comments = relationship('Comment', backref="product", lazy=True)
    quantity = Column(Integer, default=150, nullable=False)

    def __str__(self):
        return self.name


class Receipt(BaseModel):
    created_date = Column(DateTime, default=datetime.now())
    user_id = Column(Integer, ForeignKey(User.id), nullable=False)
    details = relationship('ReceiptDetail', backref='receipt', lazy=True)


class ReceiptDetail(db.Model):
    receipt_id = Column(Integer, ForeignKey(Receipt.id), nullable=False, primary_key=True)
    product_id = Column(Integer, ForeignKey(Product.id), nullable=False, primary_key=True)
    quantity = Column(Integer, default=0)
    unit_price = Column(Float, default=0)

class Comment(BaseModel):
    content = Column(String(255), nullable=False)
    product_id = Column(Integer, ForeignKey(Product.id), nullable=False)
    user_id = Column(Integer, ForeignKey(User.id), nullable=False)
    created_date = Column(DateTime, default=datetime.now())

    def __str__(self):
        return self.content


if __name__ == '__main__':
    with app.app_context():
        db.create_all()


