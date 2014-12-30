module UserHelper
	def create_field_and_entry(display_type, content, values="")
		@profile_field = create(:user_profile_field, display_type: display_type, values: values)
		@profile_entry = create(:user_profile_entry, user: @user, user_profile_field: @profile_field, content: content)
	end
	# Capybara Browser helpers, modifies browser state
	def fill_in_user_form(user)
		fill_in "Login", with: user[:login]
		fill_in "First name", with: user[:first_name]
		fill_in "Nick name", with: user[:nick_name]
		fill_in "Last name", with: user[:last_name]
		fill_in "Email", with: user[:email]
		fill_in "Employee ID", with: user[:employee_id]
	end
end
