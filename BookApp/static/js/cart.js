function addToCart(id, name, price){
    event.preventDefault()
    fetch('/api/add-cart', {
        method: 'post',
        body: JSON.stringify({
            'id': id,
            'name': name,
            'price': price
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(function(res){
        console.info(res)
        return res.json()
    }).then(function(data) {
        console.info(data)

        let counter = document.getElementsByClassName('cart-counter')
        for (let i = 0; i< counter.length; i++)
             counter[i].innerText = data.total_quantity
    }).catch(function(err){
        console.error(err)
    })
}
function pay() {
    if(confirm("Bạn có muốn thanh toán không?")){
           fetch('/api/pay', {
        method: 'post',
    }).then(res => res.json()).then(data =>{
        if (data.code ==200)
            location.reload()
    }).catch(err => console.error(err))
    }
}

function updateCart(id, obj) {
    fetch('/api/update-cart', {
        method: 'put',
        body: JSON.stringify({
            'id': id,
            'quantity': parseInt(obj.value)
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(data => {
         let counter = document.getElementsByClassName('cart-counter')
        for (let i = 0; i< counter.length; i++)
             counter[i].innerText = data.total_quantity

        let amount = document.getElementById('total-amount')
        amount.innerText = new Intl.NumberFormat().format(data.total_amount)
    })
}

function deleteCart(id){
    if(confirm("Bạn có chắc chắn muốn xóa không?")){
        fetch('/api/delete-cart/' + id, {
        method: 'delete',
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(data => {
         let counter = document.getElementsByClassName('cart-counter')
        for (let i = 0; i< counter.length; i++)
             counter[i].innerText = data.total_quantity

        let amount = document.getElementById('total-amount')
        amount.innerText = new Intl.NumberFormat().format(data.total_amount)

        let e = document.getElementById("product" +id)
        e.style.display = "none"
    }).catch(err=> console.err(err))
    }
}

function addComment(productId) {
    let content = document.getElementById('commentId')
    if (content !== null){
        fetch('/api/comments', {
            method: 'post',
            body: JSON.stringify({
                'product_id': productId,
                'content': content.value
            }),
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(res => res.json()).then(data => {
            if (data.status == 201){
                let c = data.comment
                let area = document.getElementById('commentArea')

                area.innerHTML =  `
                     <div class="row">
                         <div class="col-md-1 col-xs-4">
                             <img src="${c.user.avatar}" alt="" class="img-fluid rounded-circle">
                        </div>
                        <div class="col-md-11 col-xs-8">
                            <b>${ c.user.name }</b>
                            <p>${c.content}</p>
                            <p style="font-size: 10px;"><em>${moment(c.created_date).locale('vi').fromNow()}</em></p>
                        </div>
                    </div>
                ` + area.innerHTML
            } else if(data.status ==404)
                alert(data.err_msg)
        })
    }
}
 function toggleDescription(event) {
        // Ngừng cuộn trang khi nhấn vào "Xem thêm" hoặc "Thu gọn"
        event.preventDefault();

        var shortDescription = document.getElementById("short-description");
        var fullDescription = document.getElementById("full-description");
        var readMoreLink = document.getElementById("read-more");

        if (fullDescription.style.display === "none") {
            fullDescription.style.display = "inline";
            shortDescription.style.display = "none"; // Ẩn mô tả ngắn đi
            readMoreLink.textContent = "Thu gọn";
        } else {
            fullDescription.style.display = "none";
            shortDescription.style.display = "inline"; // Hiển thị lại mô tả ngắn
            readMoreLink.textContent = "Xem thêm";
        }
    }
