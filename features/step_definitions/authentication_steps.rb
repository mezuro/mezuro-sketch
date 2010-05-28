def login
  visit path_to("login")
  fill_in("Login", :with => "viviane")
  fill_in("Password", :with => "minhasenha")
  click_button("Login")
end
