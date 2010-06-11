def login_as user
  visit path_to("/login")
  fill_in("Login", :with => user)
  fill_in("Password", :with => "minhasenha")
  click_button("Login")
end
