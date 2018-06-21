# Seed Admin User
User.create name: 'admin', password: 'admin', admin: true


# Seed Usage Tiers
Tier.create([
  {
    name: 'Basic',
    price: 5,
    quantity: 10
  },
  {
    name: 'Pro',
    price: 10,
    quantity: 100
  },
  {
    name: 'Enterprise',
    price: 20,
    quantity: 1000
  }
])
