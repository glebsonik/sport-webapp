User.find_or_create_by!(email: 'admin@gmail.com',
                        user_name: 'sadmin',
                        password: 'asdf12',
                        role: UserConstants::ADMIN,
                        status: 'active',
                        first_name: 'Glebchik',
                        last_name: 'Parkhomenchik')