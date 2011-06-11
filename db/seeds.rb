u = User.create :first_name => "Peter", :last_name => "Rebernik", :email => "peter@skuhajmo.si", :password => "peterr", :password_confirmation => "peterr"
u.admin = true
u.save

u = User.create :first_name => "Ljubomir", :last_name => "Marković", :email => "ljm@skuhajmo.si", :password => "ljmljm", :password_confirmation => "ljmljm"
u.admin = true
u.save

u = User.create :first_name => "Miha", :last_name => "Rebernik", :email => "mre@skuhajmo.si", :password => "mremre", :password_confirmation => "mremre"
u.admin = true
u.save
