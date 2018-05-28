require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    valid_user = {
      first_name: "Bruce",
      last_name: "Wayne",
      email: "batman@batcave.com",
      password: "batpassword",
      password_confirmation: "batpassword"
    }

    context "with a valid User" do
      it "creates a User successfully" do
        User.create valid_user
        expect(User.count).to eq(1)
      end
    end

    context "with an invalid password" do
      it "raises error with mismatched password confirmation" do
        u = User.create valid_user.merge(password: "batpassword", 
                                        password_confirmation: "different_batpassword")
        expect(User.all).to be_empty
        expect(u.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "raises error when password missing" do
        u = User.create valid_user.merge(password: nil)
        expect(User.all).to be_empty
        expect(u.errors.full_messages).to include("Password can't be blank")
      end
      
      it "raises error when password confirmation missing" do
        u = User.create valid_user.merge(password_confirmation: nil)
        expect(User.all).to be_empty
        expect(u.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it "enforces minimum password length" do
        u = User.create valid_user.merge(password: "abcde",
                                        password_confirmation: "abcde")
        expect(User.all).to be_empty
        expect(u.errors.full_messages).to include(/Password is too short/)
      end
      it "enforces maximum password length" do
        u = User.create valid_user.merge(password: "1234567890123456789012345678901234567890abc",
                                        password_confirmation: "1234567890123456789012345678901234567890abc")
        expect(User.all).to be_empty
        expect(u.errors.full_messages).to include(/Password is too long/)
      end
    end

    context "with an invalid email" do
      it "prevents duplicate email" do
        u1 = User.create valid_user
        u2 = User.create valid_user

        expect(User.count).to eq(1)
        expect(u2.errors.full_messages).to include("Email has already been taken")
      end
    end

    context "with missing user info" do
      it "requires first name" do
        u = User.create valid_user.merge(first_name: nil)
        expect(User.all).to be_empty
        expect(u.errors.full_messages).to include("First name can't be blank")
      end
      it "requires last name" do
        u = User.create valid_user.merge(last_name: nil)
        expect(User.all).to be_empty
        expect(u.errors.full_messages).to include("Last name can't be blank")
      end
      it "requires email" do
        u = User.create valid_user.merge(email: nil)
        expect(User.all).to be_empty
        expect(u.errors.full_messages).to include("Email can't be blank")
      end
    end
  end

  describe ".authenticate_with_credentials" do
    valid_user_2 = { first_name: "Peter",
                    last_name: "Parker",
                    email: "spiderman@marvel.com",
                    password: "maryjane",
                    password_confirmation: "maryjane" }

    context "with correct credentials" do
      it "returns the correct user instance" do
        User.create valid_user_2
        u = User.authenticate_with_credentials("spiderman@marvel.com", "maryjane")
        expect(u).to be_a(User)
        expect(u.email).to eq("spiderman@marvel.com")
      end
    end
    
    context "with incorrect credentials" do
      it "fails when given wrong password" do
        User.create valid_user_2
        u = User.authenticate_with_credentials("spiderman@marvel.com", "emospiderman")
        expect(u).to eq(nil)
      end

      it "fails when password missing" do
        User.create valid_user_2
        u = User.authenticate_with_credentials("spiderman@marvel.com", "")
        expect(u).to eq(nil)
      end
    end
  end
end
