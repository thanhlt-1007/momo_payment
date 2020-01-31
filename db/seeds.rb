10.times do
  Order.create name: FFaker::Lorem.phrase, price: 1000 * (rand(10) + 1)
end
