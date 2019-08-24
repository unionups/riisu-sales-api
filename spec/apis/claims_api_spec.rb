require 'rails_helper'

RSpec.describe 'Claims API', type: :api do
    let(:user) {create(:user)}
    let(:place){create(:place)}
    let(:claimed_place){create(:place, claimed: true)}
    let(:place_lvl_2){create(:place, access_level: 2)}
    let(:claim){place.claims.create!}

    ################
    it "USER must can create claim, place must be marked as claimed: POST '/api/v1/claims' -> claims#create " do
    ################
      post api_v1_claims_path,{claim: {place_id: place.id}}, { "token" => user.auth_token }

      expect( last_response.status ).to eq 200
      expect( JSON.parse(last_response.body )['place_price']).to be_present

      expect( Place.find(place.id).claimed ).to be true
    end

    ################
    it "USER must ACCES DINED for hightes access level plase: POST '/api/v1/claims' -> claims#create " do
    ################
      post api_v1_claims_path,{claim: {place_id: place_lvl_2.id}}, { "token" => user.auth_token }

      expect( last_response.status ).to eq 403
    end

    ################
    it "USER must can't create claim for claimed place: POST '/api/v1/claims' -> claims#create" do
    ################
      post api_v1_claims_path,{claim: {place_id: claimed_place.id}}, { "token" => user.auth_token }

      expect( last_response.status ).to eq 422
    end

    ################
    it "USER must send 'updates text' to them claims: PATCH '/api/v1/claims/:id' -> claims#update" do
    ################
      user.add_role :claimer, claim
      patch api_v1_claim_path(claim),{claim: {update: "Update text"}}, { "token" => user.auth_token }
      
      expect( Claim.find(claim.id).updates.last ).to eq "Update text"
      expect( last_response.status ).to eq 200
    end

    ################
    it "USER must ACEES DINED send 'updates text' to no user claims: PATCH '/api/v1/claims/:id' -> claims#update" do
    ################
      patch api_v1_claim_path(claim),{claim: {update: "Update text"}}, { "token" => user.auth_token }

      expect( last_response.status ).to eq 403
    end

    ################
    it  "USER must get his claims: GET '/api/v1/claims' -> claims#index " do
    ################
      create_list(:place, 3).each do |pl|
        cl = pl.claims.create!
        user.add_role :claimer, cl
      end
      create_list(:place, 2).each do |pl|
        pl.claims.create!
      end

      get api_v1_claims_path, nil, { "token" => user.auth_token }
      
      expect( Claim.all.count ).to eq 5
      expect( JSON.parse(last_response.body).count ).to eq 3
    end

    ################
    it  "USER must 'cancel' his claim, force place marked as 'unclaimed': GET '/api/v1/claims/:id/cancel' -> claims#cancel " do
    ################
      user.add_role :claimer, claim
      expect(claim.place.claimed).to eq true

      get api_v1_cancel_claim_path(claim), nil, { "token" => user.auth_token }
      expect( last_response.status ).to eq 200
      expect(Claim.find(claim.id).place.claimed).to eq false
    end

    ################
    it  "USER must ACEES DINED 'cancel' not his claim: GET '/api/v1/claims/:id/cancel' -> claims#cancel " do
    ################
      get api_v1_cancel_claim_path(claim), nil, { "token" => user.auth_token }
      expect( last_response.status ).to eq 403
    end

    ################
    it  "USER must 'accept' his claim, force admin 'started' state, 
         place remains marked as 'claimed': POST '/api/v1/claims/:id/accept' -> claims#accept " do
    ################
      user.add_role :claimer, claim
      expect(claim.place.claimed).to eq true
      expect(claim.user_state).to eq "started"
      expect(claim.admin_state).to eq "pending"

      post api_v1_accept_claim_path(claim), {claim: attributes_for(:claim)}, { "token" => user.auth_token }
      expect( last_response.status ).to eq 200
      
      cl = Claim.find(claim.id) 
      expect(cl.place.claimed).to eq true
      expect(cl.user_state).to eq "accepted"
      expect(cl.admin_state).to eq "started"
    end

    ################
    it  "USER must ACEES DINED 'accept' not his claim: POST '/api/v1/claims/:id/accept' -> claims#accept " do
    ################
      post api_v1_accept_claim_path(claim), {claim: attributes_for(:claim)}, { "token" => user.auth_token }
      expect( last_response.status ).to eq 403
    end

    ################
    it  "USER must 'decline' his claim, force admin 'started' state, 
         place remains marked as 'claimed': POST '/api/v1/claims/:id/decline' -> claims#decline " do
    ################
      user.add_role :claimer, claim
      expect(claim.place.claimed).to eq true
      expect(claim.user_state).to eq "started"
      expect(claim.admin_state).to eq "pending"

      post api_v1_decline_claim_path(claim), {claim: attributes_for(:claim)}, { "token" => user.auth_token }
      expect( last_response.status ).to eq 200
      
      cl = Claim.find(claim.id) 
      expect(cl.place.claimed).to eq true
      expect(cl.user_state).to eq "declined"
      expect(cl.admin_state).to eq "started"
    end

    ################
    it  "USER must ACEES DINED 'decline' not his claim: POST '/api/v1/claims/:id/decline' -> claims#decline " do
    ################
      post api_v1_decline_claim_path(claim), {claim: attributes_for(:claim)}, { "token" => user.auth_token }
      expect( last_response.status ).to eq 403
    end
end
