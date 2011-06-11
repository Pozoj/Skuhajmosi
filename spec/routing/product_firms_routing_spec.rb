require "spec_helper"

describe ProductFirmsController do
  describe "routing" do

    it "routes to #index" do
      get("/product_firms").should route_to("product_firms#index")
    end

    it "routes to #new" do
      get("/product_firms/new").should route_to("product_firms#new")
    end

    it "routes to #show" do
      get("/product_firms/1").should route_to("product_firms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/product_firms/1/edit").should route_to("product_firms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/product_firms").should route_to("product_firms#create")
    end

    it "routes to #update" do
      put("/product_firms/1").should route_to("product_firms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/product_firms/1").should route_to("product_firms#destroy", :id => "1")
    end

  end
end
