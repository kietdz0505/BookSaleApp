
from BookApp import app, db
from flask_admin import Admin, BaseView, expose, AdminIndexView
from flask_admin.contrib.sqla import ModelView
from BookApp.models import Category, Product, UserRole, Publisher, Author, User
from flask_login import current_user, logout_user
from flask import redirect, request
from datetime import datetime
import utils
from wtforms import IntegerField
from wtforms.validators import NumberRange

class AuthenticatedModelView(ModelView):
    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role.__eq__(UserRole.ADMIN)

class CategoryView(AuthenticatedModelView):
    column_list = ['name', 'products']
    form_excluded_columns = ['products']

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN

class PublisherView(AuthenticatedModelView):
    form_excluded_columns = ['products']
    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN

class AuthorView(AuthenticatedModelView):
    form_excluded_columns = ['products']
    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN

class UserView(AuthenticatedModelView):
    form_excluded_columns = ['comments', 'receipts']
    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN

class ProductView(AuthenticatedModelView):
    column_list = ['id', 'name', 'price', 'active', 'created_date']
    column_searchable_list = ['name']
    column_filters = ['id', 'name', 'price']
    column_editable_list = ['name']
    page_size = 10
    can_export = True
    form_excluded_columns = ['comments', 'receipt_detail']

    # Định dạng giá tiền
    def _format_price(view, context, model, name):
        return f"{model.price:,.0f} VND" if model.price else "N/A"

    column_formatters = {
        'price': _format_price
    }

    form_overrides = {
        'quantity': IntegerField
    }

    form_args = {
        'quantity': {
            'label': 'Quantity',
            'validators': [NumberRange(min=150)]
        }
    }

    form_args = {
        'quantity': {
            'label': 'Quantity',
            'validators': [NumberRange(min=150, message="Số lượng phải lớn hơn hoặc bằng 150")]
        }
    }

    def on_model_change(self, form, model, is_created):
        if is_created:  # Chỉ kiểm tra khi tạo mới
            quantity = form.quantity.data
            # Áp dụng giới hạn số lượng cho phần tạo mới
            if quantity < 150 or quantity > 300:
                # Gắn thông báo lỗi vào form quantity
                form.quantity.errors.append("Số lượng phải nằm trong khoảng từ 150 đến 300")
                return False  # Ngừng quá trình tạo mới
        else:
            # Kiểm tra số lượng chỉ cho phép tăng trong phần chỉnh sửa
            original_quantity = model.quantity  # Giá trị ban đầu của quantity
            new_quantity = form.quantity.data  # Giá trị mới của quantity
            if new_quantity < original_quantity:
                # Gắn thông báo lỗi vào form quantity
                form.quantity.errors.append("Số lượng không thể giảm. Chỉ có thể tăng số lượng.")
                return False  # Ngừng quá trình chỉnh sửa

        return super().on_model_change(form, model, is_created)

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN

class LogoutView(BaseView):
    @expose('/')
    def index(self):
        logout_user()
        return redirect('/admin')

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN


class StatsView(BaseView):
    @expose('/')
    def index(self):
        kw = request.args.get('kw')
        from_date = request.args.get('from_date')
        to_date = request.args.get('to_date')
        year = request.args.get('year', datetime.now().year)
        return self.render('admin/stats.html',
                           month_stats=utils.product_month_stats(year=year),
                           stats=utils.product_stats(kw=kw, from_date=from_date, to_date=to_date))

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN

class MyAdminIndex(AdminIndexView):
    @expose('/')
    def index(self):
        return self.render('admin/index.html', stats=utils.category_stats())


admin = Admin(app=app,
              name="E-Bookstore Administration",
              template_mode='bootstrap4',
              index_view=MyAdminIndex())

admin.add_view(CategoryView(Category, db.session, name="Thể loại"))
admin.add_view(ProductView(Product, db.session, name="Sách"))
admin.add_view(PublisherView(Publisher, db.session, name="Nhà xuất bản"))
admin.add_view(AuthorView(Author, db.session, name="Tác giả"))
admin.add_view(UserView(User, db.session, name="Người dùng"))
admin.add_view(StatsView(name='Thống kê'))
admin.add_view(LogoutView(name='Đăng xuất'))
