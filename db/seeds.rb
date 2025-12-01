LineItem.delete_all
Cart.delete_all
Order.delete_all
Product.delete_all

product = Product.new(
  title: 'Rails Scales!',
  description: %(
    <p>
      <em>Practical Techniques for Performance and Growth</em><br>
      Rails runs some of the biggest sites in the world, impacting millions of users
      while efficiently crunching petabytes of data.
      This book reveals how they do it, and how you can apply the same techniques
      to your applications.
    </p>
  ),
  price: 30.95
)

product.image.attach(
  io: File.open(Rails.root.join('db', 'images', 'cprpo.jpg')),
  filename: 'cprpo.jpg'
)

product.save!
