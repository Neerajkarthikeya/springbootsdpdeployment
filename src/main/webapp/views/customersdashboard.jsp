<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Handloom Marketplace</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        header {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            margin: 0;
            font-size: 1.5rem;
        }

        header nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        header nav ul li {
            margin-left: 20px;
        }

        header nav ul li a {
            color: white;
            text-decoration: none;
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        header nav ul li a:hover {
            color: #d1ffd1;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .product-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center;
            padding: 15px;
            transition: transform 0.2s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-card img {
            max-width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product-card h4 {
            font-size: 1.2rem;
            color: #333;
            margin: 10px 0;
        }

        .product-card p {
            font-size: 1rem;
            color: #555;
            margin: 10px 0;
        }

        .product-actions button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .product-actions button:hover {
            background-color: #45a049;
        }

        #cart-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .cart-content {
            background: white;
            border-radius: 8px;
            padding: 20px;
            max-width: 500px;
            width: 90%;
            text-align: center;
            position: relative;
        }

        .close-modal {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 1.5rem;
            cursor: pointer;
            color: #555;
        }

        .checkout-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 15px;
        }.checkout-btn:hover {
            background-color: #45a049;
        }.toast {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            border-radius: 5px;
            padding: 10px;
            position: fixed;
            z-index: 1;
            bottom: 30px;
            left: 50%;
            font-size: 17px;
        }

        .toast.show {
            visibility: visible;
            animation: fadein 0.5s, fadeout 0.5s 2.5s;
        }

        @keyframes fadein {
            from { bottom: 0; opacity: 0; }
            to { bottom: 30px; opacity: 1; }
        }

        @keyframes fadeout {
            from { bottom: 30px; opacity: 1; }
            to { bottom: 0; opacity: 0; }
        }

        #payment-details {
            margin-top: 20px;
            text-align: left;
        }

        #payment-details label {
            display: block;
            margin: 10px 0 5px;
        }

        #payment-details input, #payment-details select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        #customer-details input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <h1><i class="fas fa-shopping-bag"></i> Handloom Marketplace</h1>
            <nav>
                <ul>
                    <li><a href="#" onclick="openCart()"><i class="fas fa-shopping-cart"></i> Cart</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <div id="product-grid" class="product-grid">
            <%-- Dynamic product rendering using JSP --%>
            <%
                String[][] products = {
                    {"1", "Handwoven Pashmina Shawl", "249.99", "https://via.placeholder.com/300x250?text=Pashmina+Shawl"},
                    {"2", "Kantha Embroidered Silk Stole", "179.99", "https://via.placeholder.com/300x250?text=Kantha+Stole"}
                };

                for (String[] product : products) {
            %>
            <div class="product-card">
                <img src="<%= product[3] %>" alt="<%= product[1] %>">
                <h4><%= product[1] %></h4>
                <p>$<%= product[2] %></p>
                <div class="product-actions">
                    <button onclick="addToCart(<%= product[0] %>, '<%= product[1] %>', <%= product[2] %>)">
                        <i class="fas fa-shopping-cart"></i> Add to Cart
                    </button>
                </div>
            </div>
            <% } %>
        </div>
    </main><!-- Cart Modal -->
    <div id="cart-modal" class="cart-modal">
        <div class="cart-content">
            <span class="close-modal" onclick="closeCart()">&times;</span>
            <h2>Your Cart</h2>
            <div id="cart-items"></div>
            <div id="cart-total">
                <strong>Total: $<span id="total-price">0.00</span></strong>
            </div>
            
            <!-- Customer Details Section -->
            <div id="customer-details">
                <h3>Customer Information</h3>
                <label for="customer-name">Full Name:</label>
                <input type="text" id="customer-name" placeholder="Enter your full name" required>
                
                <label for="customer-email">Email:</label>
                <input type="email" id="customer-email" placeholder="Enter your email" required>
                
                <label for="customer-phone">Phone Number:</label>
                <input type="tel" id="customer-phone" placeholder="Enter your phone number" required>
            </div><!-- Payment Details Section -->
            <div id="payment-details">
                <h3>Payment Details</h3>
                <label for="payment-method">Choose Payment Method:</label>
                <select id="payment-method" onchange="updatePaymentMethod()">
                    <option value="card">Credit/Debit Card</option>
                    <option value="upi">UPI</option>
                    <option value="cod">Cash on Delivery</option>
                </select>

                <div id="card-details" style="margin-top: 10px;">
                    <label for="card-number">Card Number:</label>
                    <input type="text" id="card-number" placeholder="Enter your card number" required>
                    
                    <label for="card-name">Name on Card:</label>
                    <input type="text" id="card-name" placeholder="Enter name on card" required>
                    
                    <label for="card-expiry">Expiry Date:</label>
                    <input type="text" id="card-expiry" placeholder="MM/YY" required>
                    
                    <label for="card-cvv">CVV:</label>
                    <input type="text" id="card-cvv" placeholder="CVV" required>
                </div>

                <div id="upi-details" style="margin-top: 10px; display: none;">
                    <label for="upi-id">UPI ID:</label>
                    <input type="text" id="upi-id" placeholder="Enter your UPI ID">
                </div>
            </div>
            
            <button class="checkout-btn" onclick="processOrder()">Place Order</button>
        </div>
    </div>

    <div id="toast" class="toast"></div>

    <script>
        const cart = [];

        function addToCart(id, name, price) {
            const existingProduct = cart.find(item => item.id === id);
            if (existingProduct) {
                existingProduct.quantity++;
            } else {
                cart.push({ id, name, price, quantity: 1 });
            }
            showToast(`${name} added to cart`);
            updateCartDisplay();
        }

        function updateCartDisplay() {
            const cartItemsContainer = document.getElementById('cart-items');
            const totalPriceSpan = document.getElementById('total-price');

            if (cart.length === 0) {
                cartItemsContainer.innerHTML = 'Your cart is empty.';
            } else {
                cartItemsContainer.innerHTML = cart
                    .map(item => `<p>${item.name} - $${item.price} x ${item.quantity}</p>`)
                    .join('');
            }

            const total = cart.reduce((sum, item) => sum + item.price * item.quantity, 0);
            totalPriceSpan.textContent = total.toFixed(2);
        }

        function showToast(message) {
            const toast = document.getElementById('toast');
            toast.textContent = message;
            toast.classList.add('show');
            setTimeout(() => toast.classList.remove('show'), 3000);
        }function openCart() {
            document.getElementById('cart-modal').style.display = 'flex';
        }

        function closeCart() {
            document.getElementById('cart-modal').style.display = 'none';
        }

        function updatePaymentMethod() {
            const method = document.getElementById('payment-method').value;
            document.getElementById('card-details').style.display = method === 'card' ? 'block' : 'none';
            document.getElementById('upi-details').style.display = method === 'upi' ? 'block' : 'none';
        }

        function validateForm() {
            // Customer Details Validation
            const name = document.getElementById('customer-name').value.trim();
            const email = document.getElementById('customer-email').value.trim();
            const phone = document.getElementById('customer-phone').value.trim();

            if (!name || name.length < 2) {
                alert('Please enter a valid name');
                return false;
            }if (!email || !email.includes('@')) {
                alert('Please enter a valid email address');
                return false;
            }

            if (!phone || phone.length < 10) {
                alert('Please enter a valid phone number');
                return false;
            }

            // Payment Method Validation
            const paymentMethod = document.getElementById('payment-method').value;

            if (paymentMethod === 'card') {
                const cardNumber = document.getElementById('card-number').value.trim();
                const cardName = document.getElementById('card-name').value.trim();
                const cardExpiry = document.getElementById('card-expiry').value.trim();
                const cardCVV = document.getElementById('card-cvv').value.trim();

                if (!cardNumber || cardNumber.length < 12) {
                    alert('Please enter a valid card number');
                    return false;
                }

                if (!cardName) {
                    alert('Please enter the name on the card');
                    return false;
                }

                if (!cardExpiry.match(/^\d{2}\/\d{2}$/)) {
                    alert('Please enter a valid expiry date (MM/YY)');
                    return false;
                }

                if (!cardCVV || cardCVV.length !== 3) {
                    alert('Please enter a valid CVV');
                    return false;
                }
            }

            if (paymentMethod === 'upi') {
                const upiId = document.getElementById('upi-id').value.trim();

                if (!upiId || !upiId.includes('@')) {
                    alert('Please enter a valid UPI ID');
                    return false;
                }
            }

            return true;
        }

        function processOrder() {
            if (cart.length === 0) {
                alert('Your cart is empty. Please add items before placing an order.');
                return;
            }

            if (!validateForm()) {
                return;
            }

            const paymentMethod = document.getElementById('payment-method').value;
            const total = cart.reduce((sum, item) => sum + item.price * item.quantity, 0);
            const customerName = document.getElementById('customer-name').value;

            // Simulate order processing
            alert(`Order Placed Successfully!\n\nPayment Method: ${paymentMethod}\nTotal Amount: $${total.toFixed(2)}\nCustomer: ${customerName}\n\nThank you for shopping with Handloom Marketplace!`);

            // Clear cart and reset form
            cart.length = 0;
            updateCartDisplay();
            closeCart();
            document.getElementById('payment-method').selectedIndex = 0;
            updatePaymentMethod();
            
            // Reset
            // Existing script code from previous artifact...// Reset form fields
        document.getElementById('customer-name').value = '';
        document.getElementById('customer-email').value = '';
        document.getElementById('customer-phone').value = '';
        document.getElementById('card-number').value = '';
        document.getElementById('card-name').value = '';
        document.getElementById('card-expiry').value = '';
        document.getElementById('card-cvv').value = '';
        document.getElementById('upi-id').value = '';
        
        // Optional: Track order for future reference
        trackOrder(customerName, total, paymentMethod);
    }

    // Optional function to track orders (could be extended to send to backend)
    function trackOrder(customerName, total, paymentMethod) {
        const orders = JSON.parse(localStorage.getItem('handloomOrders') || '[]');
        
        const newOrder = {
            id: 'HLM-' + Math.random().toString(36).substr(2, 9),
            customerName: customerName,
            total: total,
            paymentMethod: paymentMethod,
            date: new Date().toLocaleString()
        };orders.push(newOrder);
        localStorage.setItem('handloomOrders', JSON.stringify(orders));
    }

    // Function to view order history (optional)
    function viewOrderHistory() {
        const orders = JSON.parse(localStorage.getItem('handloomOrders') || '[]');
        
        if (orders.length === 0) {
            alert('No order history found.');
            return;
        }

        let orderHistory = "Your Order History:\n\n";
        orders.forEach(order => {
            orderHistory += `Order ID: ${order.id}\n`;
            orderHistory += `Date: ${order.date}\n`;
            orderHistory += `Total: $${order.total.toFixed(2)}\n`;
            orderHistory += `Payment Method: ${order.paymentMethod}\n\n`;
        });

        alert(orderHistory);
    }

    // Optional: Add event listener for order history button if needed
    document.addEventListener('DOMContentLoaded', () => {
        // Example of how you might add an order history button to the header
        const orderHistoryButton = document.createElement('li');
        orderHistoryButton.innerHTML = '<a href="#" onclick="viewOrderHistory()"><i class="fas fa-history"></i> Order History</a>';
        document.querySelector('header nav ul').appendChild(orderHistoryButton);
    });
    </script>
</body>
</html>