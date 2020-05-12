require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to be_success
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the users email and password" do
        post :create, params: { user: { email: "tester@testy.com",
                                        password: ""} }
        expect(response).to redirect_to("/users/new")
        expect(flash[:errors]).to be_present
      end
      it "validates the password is at least 6 characters long" do
        post :create, params: { user: { email: "tester@testy.com",
                                        password: "short" } }
        expect(response).to redirect_to("/users/new")
        expect(flash[:errors]).to be_present
      end
    end
    context "with valid params" do
      it "redirects user to bands index on success" do
        post :create, params: { user: { email: "testy@test.com",
                                        password: "password" } }
        expect(response).to redirect_to("/session/new")
        expect(flash[:notice]).to be_present
      end
    end

  end

end
