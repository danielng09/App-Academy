Cat.destroy_all
CatRentalRequest.destroy_all

Cat.create!(birth_date: '10/01/1991', color: 'Calico', name: 'Daniel', gender: 'M', description: 'Just whatever.')
Cat.create!(birth_date: '24/12/1991', color: 'Blue', name: 'Maxim', gender: 'M', description: 'He goes by a lot of things.')
Cat.create!(birth_date: '01/01/0001', color: 'Golden', name: 'Jesus', gender: 'M', description: 'Dont piss off his dad.')
Cat.create!(birth_date: '05/10/1994', color: 'Blue', name: 'Green Tea', gender: 'F', description: 'She prefers Earl Grey actually.')

CatRentalRequest.create!(cat_id: 1, start_date: '02/01/2000', end_date: '05/01/2000') #A
CatRentalRequest.create!(cat_id: 1, start_date: '01/01/2000', end_date: '06/01/2000') #B
CatRentalRequest.create!(cat_id: 1, start_date: '01/01/2000', end_date: '03/01/2000') #C
CatRentalRequest.create!(cat_id: 1, start_date: '05/01/2000', end_date: '06/01/2000') #D
CatRentalRequest.create!(cat_id: 1, start_date: '03/01/2000', end_date: '04/01/2000') #E
CatRentalRequest.create!(cat_id: 1, start_date: '07/01/2000', end_date: '08/01/2000') #F
CatRentalRequest.create!(cat_id: 2, start_date: '03/01/2000', end_date: '04/01/2000') #G
CatRentalRequest.create!(cat_id: 2, start_date: '07/01/2000', end_date: '08/01/2000') #H
CatRentalRequest.create!(cat_id: 1, start_date: '02/01/2000', end_date: '05/01/2000') #F

# CatRentalRequest.create!(cat_id: 1, start_date: '01/01/2000', end_date: '06/01/2000', status: "APPROVED") #B
