unless User.find_by(email: 'admin@gmail.com', user_name: 'sadmin')
  User.create(email: 'admin@gmail.com',
              user_name: 'sadmin',
              password: 'asdf12456',
              role: User::ADMIN,
              status: 'active',
              first_name: 'Glebchik',
              last_name: 'Parkhomenchik')
end