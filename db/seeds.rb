# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear data
User.delete_all()
Item.delete_all()
PrintRequestStatus.delete_all()
PrintRequestAction.delete_all()
PrintRequest.delete_all()


# Initial users with temporary throwaway password
user1 = User.create(email: 'tparenti@andrew.cmu.edu', password: 'nachos', password_confirmation: 'nachos')
user1.add_role :superadmin
user2 = User.create(email: 'egarbade@andrew.cmu.edu', password: 'nachos', password_confirmation: 'nachos')

# Initial print request statuses
PrintRequestStatus.create([ { name: 'Cancelled', order: 0 }, { name: 'Submitted', order: 1000 }, { name: 'Updated', order: 1100 }, { name: 'Confirmed', order: 1500 }, { name: 'Approved', order: 3000 }, { name: 'File Prepared', order: 3500 }, { name: 'Printing', order: 5000 }, { name: 'In Caustic Bath', order: 5500 }, { name: 'Ready', order: 7000 }, { name: 'Picked Up', order: 7500 }, { name: 'Billed', order: 9000 } ])


# Basic preliminary inventory
# From lines 4-7 of Physical Computing inventory as of 2016-08-02
item1 = Item.create( name: 'Audio Mixer', description: '16-channel, 4-bus Mixer with Built-in Effects and USB', type: 'LendableItem' )
item2 = Item.create( name: 'XLR Cable', description: 'XLR cable to 1/4in TRS, 5 foot', type: 'LendableItem' )
item3 = Item.create( name: 'Arduino CNC Shield (GRBL Compatible)', type: 'LendableItem' )
item4 = Item.create( name: 'LED, 5mm Infrared 850nm', price: 0.36, type: 'SaleableItem' )
