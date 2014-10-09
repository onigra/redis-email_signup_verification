require File.expand_path(File.join('../../../', 'spec_helper'), File.dirname(__FILE__))

describe "redis" do
  before :all do
    @redis = Redis.new db: 15
  end

  before :each do
    @redis.flushdb
  end

  after :all do
    @redis.flushdb
    @redis.quit
  end

  describe Redis::EmailSignupVerification do
    let(:email) { Faker::Internet.free_email }
    let(:password) { Faker::Internet.password }
    let(:obj) { described_class.new(redis: @redis) }

    describe "#generate" do
      context "Success" do
        it "Return verification token" do
          expect(obj.generate email, password).to be_kind_of String
        end
      end

      context "Set expire time" do
        it "Could set expiry" do
          token = obj.generate(email, password, expire: 2)
          sleep 3
          expect(@redis.exists token).to be_falsy
        end
      end
    end

    describe "#get" do
      let(:token) { obj.generate email, password }
      subject { obj.get token }

      it "Return token infomation hash" do
        expect(subject[:token]).to eq token
        expect(subject[:email]).to eq email
        expect(subject[:password]).to be_kind_of String
        expect(subject[:created_at]).to be_kind_of Time
      end
    end

    describe "#email" do
      let(:token) { obj.generate email, password }

      it "Token is can get email" do
        expect(obj.email token).to eq email
      end
    end

    describe "#password" do
      let(:token) { obj.generate email, password }

      it "Token is can get password and password is encrypted" do
        encrypted_password = BCrypt::Password.new(obj.password token)

        expect(encrypted_password).to eq password
      end
    end

    describe "#created_at" do
      let(:token) { obj.generate email, password }

      it "Token is can get created_at" do
        expect(obj.created_at token).to be_kind_of Time
      end
    end

  end
end
