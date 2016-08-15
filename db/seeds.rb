# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear data
User.delete_all()
Tag.delete_all()
Type.delete_all()
Item.delete_all()
PrintRequestStatus.delete_all()
PrintRequestAction.delete_all()
PrintRequest.delete_all()


# Initial user with temporary throwaway password
User.create(email: 'tparenti@andrew.cmu.edu', password: 'nachos', password_confirmation: 'nachos')


# Initial print request statuses
PrintRequestStatus.create([ { name: 'Cancelled', order: 0 }, { name: 'Submitted', order: 1000 }, { name: 'Updated', order: 1100 }, { name: 'Confirmed', order: 1500 }, { name: 'Approved', order: 3000 }, { name: 'File Prepared', order: 3500 }, { name: 'Printing', order: 5000 }, { name: 'In Caustic Bath', order: 5500 }, { name: 'Ready', order: 7000 }, { name: 'Picked Up', order: 7500 }, { name: 'Billed', order: 9000 } ])


# Basic preliminary inventory
# From lines 4-7 of Physical Computing inventory as of 2016-08-02
types = Type.create([ { name: 'Consumable' }, { name: 'Local' } ])

tags1 = Tag.create([ { name: 'Audio' }, { name: 'Recording' } ])
item1 = Item.create( name: 'Audio Mixer', description: '16-channel, 4-bus Mixer with Built-in Effects and USB', minimum_quantity: 0, current_quantity: 1, tags: tags1, types: [types[1]] )

tags2 = Tag.create([ { name: 'Adapter' }, { name: 'Cables' } ])
tags2 << tags1[0]
item2 = Item.create( name: 'XLR Cable', description: 'XLR cable to 1/4in TRS, 5 foot', minimum_quantity: 0, current_quantity: 2, tags: tags2 )

tags3 = Tag.create([ { name: 'Actuators' }, { name: 'Drivers' }, { name: 'Sensors' } ])
item3 = Item.create( name: 'Arduino CNC Shield (GRBL Compatible)', current_quantity: 0, tags: tags3, types: types )

tags4 = Tag.create([ { name: 'Electronics' }, { name: 'LED' }, { name: 'Lighting' } ])
item4 = Item.create( name: 'LED, 5mm Infrared 850nm', current_quantity: 0, sale_price: 0.36, tags: tags4, types: [types[1]] )
